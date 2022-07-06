using System;
using System.Collections;
using System.Collections.Generic;
//using Holoville.HOTween;
//using Holoville.HOTween.Plugins;
using UnityEngine;

[AddComponentMenu("Simple Waypoint System/hoMove")]
public class hoMove : MonoBehaviour
{
	public enum TimeValue
	{
		time,
		speed
	}

	public enum LoopType
	{
		none,
		loop,
		pingPong,
		random
	}

	public PathManager pathContainer;

	public PathType pathtype = PathType.Curved;

	public bool onStart;

	public bool moveToPath;

	public bool closePath;

	public bool orientToPath;

	public bool local;

	public float lookAhead;

	public float sizeToAdd;

	[HideInInspector]
	public float[] StopAtPoint;

	[HideInInspector]
	public List<MessageOptions> _messages = new List<MessageOptions>();

	public TimeValue timeValue = TimeValue.speed;

	public float speed = 5f;

	public EaseType easetype;

	public LoopType looptype = LoopType.loop;

	private Transform[] waypoints;

	[HideInInspector]
	public int currentPoint;

	private bool repeat;

	public Axis lockAxis;

	public Axis lockPosition;

	[HideInInspector]
	public Animation anim;

	public AnimationClip walkAnim;

	public AnimationClip idleAnim;

	public bool crossfade;

	public Tweener tween;

	private Vector3[] wpPos;

	private TweenParms tParms;

	private PlugVector3Path plugPath;

	private System.Random rand = new System.Random();

	private int[] rndArray;

	private int rndIndex;

	private bool waiting;

	private float originSpeed;

	internal void Start()
	{
		if (!anim)
		{
			anim = base.gameObject.GetComponentInChildren<Animation>();
		}
		if (onStart)
		{
			StartMove();
		}
	}

	internal void InitWaypoints()
	{
		wpPos = new Vector3[waypoints.Length];
		for (int i = 0; i < wpPos.Length; i++)
		{
			ref Vector3 reference = ref wpPos[i];
			reference = waypoints[i].position + new Vector3(0f, sizeToAdd, 0f);
		}
	}

	public void StartMove()
	{
		if (pathContainer == null)
		{
			Debug.LogWarning(base.gameObject.name + " has no path! Please set Path Container.");
			return;
		}
		waypoints = pathContainer.waypoints;
		originSpeed = speed;
		if (StopAtPoint == null)
		{
			StopAtPoint = new float[waypoints.Length];
		}
		else if (StopAtPoint.Length < waypoints.Length)
		{
			float[] array = new float[StopAtPoint.Length];
			Array.Copy(StopAtPoint, array, StopAtPoint.Length);
			StopAtPoint = new float[waypoints.Length];
			Array.Copy(array, StopAtPoint, array.Length);
		}
		if (_messages.Count > 0)
		{
			InitializeMessageOptions();
		}
		StartCoroutine(Move());
	}

	internal IEnumerator Move()
	{
		if (moveToPath)
		{
			yield return StartCoroutine(MoveToPath());
		}
		else
		{
			InitWaypoints();
			base.transform.position = waypoints[currentPoint].position + new Vector3(0f, sizeToAdd, 0f);
			if (orientToPath && currentPoint < wpPos.Length - 1)
			{
				base.transform.LookAt(wpPos[currentPoint + 1]);
			}
		}
		if (looptype == LoopType.random)
		{
			StartCoroutine(ReachedEnd());
			yield break;
		}
		CreateTween();
		StartCoroutine(NextWaypoint());
	}

	internal IEnumerator MoveToPath()
	{
		int max = ((waypoints.Length <= 4) ? waypoints.Length : 4);
		wpPos = new Vector3[max];
		for (int i = 1; i < max; i++)
		{
			 Vector3 reference =  wpPos[i];
			reference = waypoints[i - 1].position + new Vector3(0f, sizeToAdd, 0f);
		}
		 Vector3 reference2 =  wpPos[0];
		reference2 = base.transform.position;
		CreateTween();
		if (tween.isPaused)
		{
			tween.Play();
		}
		yield return StartCoroutine(tween.UsePartialPath(-1, 1).WaitForCompletion());
		moveToPath = false;
		tween.Kill();
		tween = null;
		InitWaypoints();
	}

	internal void CreateTween()
	{
		PlayWalk();
		plugPath = new PlugVector3Path(wpPos, p_isRelative: true, pathtype);
		if (orientToPath || lockAxis != 0)
		{
			plugPath.OrientToPath(lookAhead, lockAxis);
		}
		if (lockPosition != 0)
		{
			plugPath.LockPosition(lockPosition);
		}
		if (closePath)
		{
			plugPath.ClosePath(p_close: true);
		}
		tParms = new TweenParms();
		if (local)
		{
			tParms.Prop("localPosition", plugPath);
		}
		else
		{
			tParms.Prop("position", plugPath);
		}
		tParms.AutoKill(p_active: false);
		tParms.Pause(p_pause: true);
		tParms.Loops(1);
		if (timeValue == TimeValue.speed)
		{
			tParms.SpeedBased();
			tParms.Ease(EaseType.Linear);
		}
		else
		{
			tParms.Ease(easetype);
		}
		tween = HOTween.To(base.transform, originSpeed, tParms);
		if (originSpeed != speed)
		{
			ChangeSpeed(speed);
		}
	}

	internal IEnumerator NextWaypoint()
	{
		for (int point = 0; point < wpPos.Length - 1; point++)
		{
			StartCoroutine(SendMessages());
			if (StopAtPoint[currentPoint] > 0f)
			{
				yield return StartCoroutine(WaitDelay());
			}
			while (waiting)
			{
				yield return null;
			}
			PlayWalk();
			tween.Play();
			yield return StartCoroutine(tween.UsePartialPath(point, point + 1).WaitForCompletion());
			if (repeat)
			{
				currentPoint--;
			}
			else if (looptype == LoopType.random)
			{
				rndIndex++;
				currentPoint = rndArray[rndIndex];
			}
			else
			{
				currentPoint++;
			}
		}
		if (looptype != LoopType.pingPong && looptype != LoopType.random)
		{
			StartCoroutine(SendMessages());
			if (StopAtPoint[currentPoint] > 0f)
			{
				yield return StartCoroutine(WaitDelay());
			}
		}
		StartCoroutine(ReachedEnd());
	}

	internal IEnumerator WaitDelay()
	{
		tween.Pause();
		PlayIdle();
		float timer = Time.time + StopAtPoint[currentPoint];
		while (!waiting && Time.time < timer)
		{
			yield return null;
		}
	}

	internal IEnumerator SendMessages()
	{
		if (_messages.Count != waypoints.Length)
		{
			yield break;
		}
		for (int i = 0; i < _messages[currentPoint].message.Count; i++)
		{
			if (!(_messages[currentPoint].message[i] == string.Empty))
			{
				MessageOptions messageOptions = _messages[currentPoint];
				switch (messageOptions.type[i])
				{
				case MessageOptions.ValueType.None:
					SendMessage(messageOptions.message[i], SendMessageOptions.DontRequireReceiver);
					break;
				case MessageOptions.ValueType.Object:
					SendMessage(messageOptions.message[i], messageOptions.obj[i], SendMessageOptions.DontRequireReceiver);
					break;
				case MessageOptions.ValueType.Text:
					SendMessage(messageOptions.message[i], messageOptions.text[i], SendMessageOptions.DontRequireReceiver);
					break;
				case MessageOptions.ValueType.Numeric:
					SendMessage(messageOptions.message[i], messageOptions.num[i], SendMessageOptions.DontRequireReceiver);
					break;
				case MessageOptions.ValueType.Vector2:
					SendMessage(messageOptions.message[i], messageOptions.vect2[i], SendMessageOptions.DontRequireReceiver);
					break;
				case MessageOptions.ValueType.Vector3:
					SendMessage(messageOptions.message[i], messageOptions.vect3[i], SendMessageOptions.DontRequireReceiver);
					break;
				}
			}
		}
	}

	internal void InitializeMessageOptions()
	{
		if (_messages.Count < waypoints.Length)
		{
			for (int i = _messages.Count; i < waypoints.Length; i++)
			{
				MessageOptions item = AddMessageToOption(new MessageOptions());
				_messages.Add(item);
			}
		}
		else if (_messages.Count > waypoints.Length)
		{
			for (int num = _messages.Count - 1; num >= waypoints.Length; num--)
			{
				_messages.RemoveAt(num);
			}
		}
	}

	internal MessageOptions AddMessageToOption(MessageOptions opt)
	{
		opt.message.Add(string.Empty);
		opt.type.Add(MessageOptions.ValueType.None);
		opt.obj.Add(null);
		opt.text.Add(null);
		opt.num.Add(0f);
		opt.vect2.Add(Vector2.zero);
		opt.vect3.Add(Vector3.zero);
		return opt;
	}

	internal IEnumerator ReachedEnd()
	{
		switch (looptype)
		{
		case LoopType.none:
			tween.Kill();
			tween = null;
			PlayIdle();
			yield break;
		case LoopType.loop:
			if (closePath)
			{
				tween.Play();
				PlayWalk();
				yield return StartCoroutine(tween.UsePartialPath(currentPoint, -1).WaitForCompletion());
			}
			currentPoint = 0;
			break;
		case LoopType.pingPong:
			tween.Kill();
			tween = null;
			if (!repeat)
			{
				repeat = true;
				for (int l = 0; l < wpPos.Length; l++)
				{
					 Vector3 reference3 =  wpPos[l];
					reference3 = waypoints[waypoints.Length - 1 - l].position + new Vector3(0f, sizeToAdd, 0f);
				}
			}
			else
			{
				InitWaypoints();
				repeat = false;
			}
			CreateTween();
			break;
		case LoopType.random:
		{
			rndIndex = 0;
			InitWaypoints();
			if (tween != null)
			{
				tween.Kill();
				tween = null;
			}
			rndArray = new int[wpPos.Length];
			for (int j = 0; j < rndArray.Length; j++)
			{
				rndArray[j] = j;
			}
			int i = wpPos.Length;
			while (i > 1)
			{
				int num = rand.Next(i--);
				Vector3 vector = wpPos[i];
				 Vector3 reference =  wpPos[i];
				reference = wpPos[num];
				wpPos[num] = vector;
				int num2 = rndArray[i];
				rndArray[i] = rndArray[num];
				rndArray[num] = num2;
			}
			Vector3 first = wpPos[0];
			int rndFirst = rndArray[0];
			for (int k = 0; k < wpPos.Length; k++)
			{
				if (rndArray[k] == currentPoint)
				{
					rndArray[k] = rndFirst;
					 Vector3 reference2 =  wpPos[0];
					reference2 = wpPos[k];
					wpPos[k] = first;
				}
			}
			rndArray[0] = currentPoint;
			CreateTween();
			break;
		}
		}
		StartCoroutine(NextWaypoint());
	}

	internal void PlayIdle()
	{
		if ((bool)idleAnim)
		{
			if (crossfade)
			{
				anim.CrossFade(idleAnim.name, 0.2f);
			}
			else
			{
				anim.Play(idleAnim.name);
			}
		}
	}

	internal void PlayWalk()
	{
		if ((bool)walkAnim)
		{
			if (crossfade)
			{
				anim.CrossFade(walkAnim.name, 0.2f);
			}
			else
			{
				anim.Play(walkAnim.name);
			}
		}
	}

	public void SetPath(PathManager newPath)
	{
		Stop();
		pathContainer = newPath;
		waypoints = pathContainer.waypoints;
		currentPoint = 0;
		StartMove();
	}

	public void Stop()
	{
		StopAllCoroutines();
		HOTween.Kill(base.transform);
		plugPath = null;
		tween = null;
		PlayIdle();
	}

	public void Reset()
	{
		Stop();
		currentPoint = 0;
		if ((bool)pathContainer)
		{
			base.transform.position = waypoints[currentPoint].position + new Vector3(0f, sizeToAdd, 0f);
		}
	}

	public void Pause()
	{
		waiting = true;
		HOTween.Pause(base.transform);
		PlayIdle();
	}

	public void Resume()
	{
		waiting = false;
		HOTween.Play(base.transform);
		PlayWalk();
	}

	public void ChangeSpeed(float value)
	{
		float timeScale = ((timeValue != TimeValue.speed) ? (originSpeed / value) : (value / originSpeed));
		speed = value;
		tween.timeScale = timeScale;
	}

	public MessageOptions GetMessageOption(int waypointID, int messageID)
	{
		InitializeMessageOptions();
		MessageOptions messageOptions = _messages[waypointID];
		for (int i = messageOptions.message.Count; i <= messageID; i++)
		{
			AddMessageToOption(messageOptions);
		}
		return messageOptions;
	}
}
