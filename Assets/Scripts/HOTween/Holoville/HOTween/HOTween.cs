using System.Collections;
using System.Collections.Generic;
//using Holoville.HOTween.Core;
//using Holoville.HOTween.Plugins;
//using Holoville.HOTween.Plugins.Core;
using UnityEngine;

//namespace Holoville.HOTween;

public class HOTween : MonoBehaviour
{
	public const string VERSION = "1.1.724";

	public const string AUTHOR = "Daniele Giardini - Holoville";

	private const string GAMEOBJNAME = "HOTween";

	public static UpdateType defUpdateType = UpdateType.Update;

	public static float defTimeScale = 1f;

	public static EaseType defEaseType = EaseType.EaseOutQuad;

	public static float defEaseOvershootOrAmplitude = 1.70158f;

	public static float defEasePeriod = 0f;

	public static LoopType defLoopType = LoopType.Restart;

	public static bool showPathGizmos;

	public static WarningLevel warningLevel = WarningLevel.Verbose;

	internal static bool isIOS;

	internal static bool isEditor;

	internal static List<ABSTweenComponent> onCompletes = new List<ABSTweenComponent>();

	private static bool initialized;

	private static bool isPermanent;

	private static bool renameInstToCountTw;

	private static float time;

	private static bool isUpdateLoop;

	private static List<int> tweensToRemoveIndexes = new List<int>();

	internal static OverwriteManager overwriteManager;

	private static List<ABSTweenComponent> tweens;

	private static GameObject tweenGOInstance;

	private static HOTween it;

	public static int totTweens
	{
		get
		{
			if (tweens == null)
			{
				return 0;
			}
			return tweens.Count;
		}
	}

	public static void Init()
	{
		Init(p_permanentInstance: false, p_renameInstanceToCountTweens: true, p_allowOverwriteManager: false);
	}

	public static void Init(bool p_permanentInstance)
	{
		Init(p_permanentInstance, p_renameInstanceToCountTweens: true, p_allowOverwriteManager: false);
	}

	public static void Init(bool p_permanentInstance, bool p_renameInstanceToCountTweens, bool p_allowOverwriteManager)
	{
		if (!initialized)
		{
			initialized = true;
			isIOS = Application.platform == RuntimePlatform.IPhonePlayer;
			isEditor = Application.isEditor;
			isPermanent = p_permanentInstance;
			renameInstToCountTw = p_renameInstanceToCountTweens;
			if (p_allowOverwriteManager)
			{
				overwriteManager = new OverwriteManager();
			}
			if (isPermanent && tweenGOInstance == null)
			{
				NewTweenInstance();
				SetGOName();
			}
		}
	}

	private void OnDrawGizmos()
	{
		if (tweens == null || !showPathGizmos)
		{
			return;
		}
		List<ABSTweenPlugin> plugins = GetPlugins();
		int count = plugins.Count;
		for (int i = 0; i < count; i++)
		{
			if (plugins[i] is PlugVector3Path plugVector3Path && plugVector3Path.path != null)
			{
				plugVector3Path.path.GizmoDraw(plugVector3Path.pathPerc, p_drawTrig: false);
			}
		}
	}

	private void OnDestroy()
	{
		if (this == it)
		{
			Clear();
		}
	}

	internal static void AddSequence(Sequence p_sequence)
	{
		if (!initialized)
		{
			Init();
		}
		AddTween(p_sequence);
	}

	public static Tweener To(object p_target, float p_duration, string p_propName, object p_endVal)
	{
		return To(p_target, p_duration, new TweenParms().Prop(p_propName, p_endVal));
	}

	public static Tweener To(object p_target, float p_duration, string p_propName, object p_endVal, bool p_isRelative)
	{
		return To(p_target, p_duration, new TweenParms().Prop(p_propName, p_endVal, p_isRelative));
	}

	public static Tweener To(object p_target, float p_duration, TweenParms p_parms)
	{
		if (!initialized)
		{
			Init();
		}
		Tweener tweener = new Tweener(p_target, p_duration, p_parms);
		if (tweener.isEmpty)
		{
			return null;
		}
		AddTween(tweener);
		return tweener;
	}

	public static Tweener From(object p_target, float p_duration, string p_propName, object p_fromVal)
	{
		return From(p_target, p_duration, new TweenParms().Prop(p_propName, p_fromVal));
	}

	public static Tweener From(object p_target, float p_duration, string p_propName, object p_fromVal, bool p_isRelative)
	{
		return From(p_target, p_duration, new TweenParms().Prop(p_propName, p_fromVal, p_isRelative));
	}

	public static Tweener From(object p_target, float p_duration, TweenParms p_parms)
	{
		if (!initialized)
		{
			Init();
		}
		p_parms = p_parms.IsFrom();
		Tweener tweener = new Tweener(p_target, p_duration, p_parms);
		if (tweener.isEmpty)
		{
			return null;
		}
		AddTween(tweener);
		if (!tweener._isPaused)
		{
			tweener.Update(0f, p_forceUpdate: true, p_isStartupIteration: true, p_ignoreCallbacks: false, p_ignoreDelay: true);
		}
		return tweener;
	}

	private void Update()
	{
		if (tweens != null)
		{
			DoUpdate(UpdateType.Update, Time.deltaTime);
			CheckClear();
		}
	}

	private void LateUpdate()
	{
		if (tweens != null)
		{
			DoUpdate(UpdateType.LateUpdate, Time.deltaTime);
			CheckClear();
		}
	}

	private void FixedUpdate()
	{
		if (tweens != null)
		{
			DoUpdate(UpdateType.FixedUpdate, Time.fixedDeltaTime);
			CheckClear();
		}
	}

	private static IEnumerator TimeScaleIndependentUpdate()
	{
		while (tweens != null)
		{
			float elapsed = Time.realtimeSinceStartup - time;
			time = Time.realtimeSinceStartup;
			DoUpdate(UpdateType.TimeScaleIndependentUpdate, elapsed);
			if (CheckClear())
			{
				break;
			}
			yield return null;
		}
	}

	public static void EnableOverwriteManager()
	{
		if (overwriteManager != null)
		{
			overwriteManager.enabled = true;
		}
	}

	public static void DisableOverwriteManager()
	{
		if (overwriteManager != null)
		{
			overwriteManager.enabled = false;
		}
	}

	public static int Pause(object p_target)
	{
		return DoFilteredIteration(p_target, DoFilteredPause, p_collectionChanger: false);
	}

	public static int Pause(string p_id)
	{
		return DoFilteredIteration(p_id, DoFilteredPause, p_collectionChanger: false);
	}

	public static int Pause(int p_intId)
	{
		return DoFilteredIteration(p_intId, DoFilteredPause, p_collectionChanger: false);
	}

	public static int Pause(Tweener p_tweener)
	{
		return DoFilteredIteration(p_tweener, DoFilteredPause, p_collectionChanger: false);
	}

	public static int Pause(Sequence p_sequence)
	{
		return DoFilteredIteration(p_sequence, DoFilteredPause, p_collectionChanger: false);
	}

	public static int Pause()
	{
		return DoFilteredIteration(null, DoFilteredPause, p_collectionChanger: false);
	}

	public static int Play(object p_target)
	{
		return Play(p_target, p_skipDelay: false);
	}

	public static int Play(object p_target, bool p_skipDelay)
	{
		return DoFilteredIteration(p_target, DoFilteredPlay, p_collectionChanger: false, p_skipDelay);
	}

	public static int Play(string p_id)
	{
		return Play(p_id, p_skipDelay: false);
	}

	public static int Play(string p_id, bool p_skipDelay)
	{
		return DoFilteredIteration(p_id, DoFilteredPlay, p_collectionChanger: false, p_skipDelay);
	}

	public static int Play(int p_intId)
	{
		return Play(p_intId, p_skipDelay: false);
	}

	public static int Play(int p_intId, bool p_skipDelay)
	{
		return DoFilteredIteration(p_intId, DoFilteredPlay, p_collectionChanger: false, p_skipDelay);
	}

	public static int Play(Tweener p_tweener)
	{
		return Play(p_tweener, p_skipDelay: false);
	}

	public static int Play(Tweener p_tweener, bool p_skipDelay)
	{
		return DoFilteredIteration(p_tweener, DoFilteredPlay, p_collectionChanger: false, p_skipDelay);
	}

	public static int Play(Sequence p_sequence)
	{
		return DoFilteredIteration(p_sequence, DoFilteredPlay, p_collectionChanger: false);
	}

	public static int Play()
	{
		return Play(p_skipDelay: false);
	}

	public static int Play(bool p_skipDelay)
	{
		return DoFilteredIteration(null, DoFilteredPlay, p_collectionChanger: false, p_skipDelay);
	}

	public static int PlayForward(object p_target)
	{
		return PlayForward(p_target, p_skipDelay: false);
	}

	public static int PlayForward(object p_target, bool p_skipDelay)
	{
		return DoFilteredIteration(p_target, DoFilteredPlayForward, p_collectionChanger: false, p_skipDelay);
	}

	public static int PlayForward(string p_id)
	{
		return PlayForward(p_id, p_skipDelay: false);
	}

	public static int PlayForward(string p_id, bool p_skipDelay)
	{
		return DoFilteredIteration(p_id, DoFilteredPlayForward, p_collectionChanger: false, p_skipDelay);
	}

	public static int PlayForward(int p_intId)
	{
		return PlayForward(p_intId, p_skipDelay: false);
	}

	public static int PlayForward(int p_intId, bool p_skipDelay)
	{
		return DoFilteredIteration(p_intId, DoFilteredPlayForward, p_collectionChanger: false, p_skipDelay);
	}

	public static int PlayForward(Tweener p_tweener)
	{
		return PlayForward(p_tweener, p_skipDelay: false);
	}

	public static int PlayForward(Tweener p_tweener, bool p_skipDelay)
	{
		return DoFilteredIteration(p_tweener, DoFilteredPlayForward, p_collectionChanger: false, p_skipDelay);
	}

	public static int PlayForward(Sequence p_sequence)
	{
		return DoFilteredIteration(p_sequence, DoFilteredPlayForward, p_collectionChanger: false);
	}

	public static int PlayForward()
	{
		return PlayForward(p_skipDelay: false);
	}

	public static int PlayForward(bool p_skipDelay)
	{
		return DoFilteredIteration(null, DoFilteredPlayForward, p_collectionChanger: false, p_skipDelay);
	}

	public static int PlayBackwards(object p_target)
	{
		return DoFilteredIteration(p_target, DoFilteredPlayBackwards, p_collectionChanger: false);
	}

	public static int PlayBackwards(string p_id)
	{
		return DoFilteredIteration(p_id, DoFilteredPlayBackwards, p_collectionChanger: false);
	}

	public static int PlayBackwards(int p_intId)
	{
		return DoFilteredIteration(p_intId, DoFilteredPlayBackwards, p_collectionChanger: false);
	}

	public static int PlayBackwards(Tweener p_tweener)
	{
		return DoFilteredIteration(p_tweener, DoFilteredPlayBackwards, p_collectionChanger: false);
	}

	public static int PlayBackwards(Sequence p_sequence)
	{
		return DoFilteredIteration(p_sequence, DoFilteredPlayBackwards, p_collectionChanger: false);
	}

	public static int PlayBackwards()
	{
		return DoFilteredIteration(null, DoFilteredPlayBackwards, p_collectionChanger: false);
	}

	public static int Rewind(object p_target)
	{
		return Rewind(p_target, p_skipDelay: false);
	}

	public static int Rewind(object p_target, bool p_skipDelay)
	{
		return DoFilteredIteration(p_target, DoFilteredRewind, p_collectionChanger: false, p_skipDelay);
	}

	public static int Rewind(string p_id)
	{
		return Rewind(p_id, p_skipDelay: false);
	}

	public static int Rewind(string p_id, bool p_skipDelay)
	{
		return DoFilteredIteration(p_id, DoFilteredRewind, p_collectionChanger: false, p_skipDelay);
	}

	public static int Rewind(int p_intId)
	{
		return Rewind(p_intId, p_skipDelay: false);
	}

	public static int Rewind(int p_intId, bool p_skipDelay)
	{
		return DoFilteredIteration(p_intId, DoFilteredRewind, p_collectionChanger: false, p_skipDelay);
	}

	public static int Rewind(Tweener p_tweener)
	{
		return Rewind(p_tweener, p_skipDelay: false);
	}

	public static int Rewind(Tweener p_tweener, bool p_skipDelay)
	{
		return DoFilteredIteration(p_tweener, DoFilteredRewind, p_collectionChanger: false, p_skipDelay);
	}

	public static int Rewind(Sequence p_sequence)
	{
		return DoFilteredIteration(p_sequence, DoFilteredRewind, p_collectionChanger: false);
	}

	public static int Rewind()
	{
		return Rewind(p_skipDelay: false);
	}

	public static int Rewind(bool p_skipDelay)
	{
		return DoFilteredIteration(null, DoFilteredRewind, p_collectionChanger: false, p_skipDelay);
	}

	public static int Restart(object p_target)
	{
		return Restart(p_target, p_skipDelay: false);
	}

	public static int Restart(object p_target, bool p_skipDelay)
	{
		return DoFilteredIteration(p_target, DoFilteredRestart, p_collectionChanger: false, p_skipDelay);
	}

	public static int Restart(string p_id)
	{
		return Restart(p_id, p_skipDelay: false);
	}

	public static int Restart(string p_id, bool p_skipDelay)
	{
		return DoFilteredIteration(p_id, DoFilteredRestart, p_collectionChanger: false, p_skipDelay);
	}

	public static int Restart(int p_intId)
	{
		return Restart(p_intId, p_skipDelay: false);
	}

	public static int Restart(int p_intId, bool p_skipDelay)
	{
		return DoFilteredIteration(p_intId, DoFilteredRestart, p_collectionChanger: false, p_skipDelay);
	}

	public static int Restart(Tweener p_tweener)
	{
		return Restart(p_tweener, p_skipDelay: false);
	}

	public static int Restart(Tweener p_tweener, bool p_skipDelay)
	{
		return DoFilteredIteration(p_tweener, DoFilteredRestart, p_collectionChanger: false, p_skipDelay);
	}

	public static int Restart(Sequence p_sequence)
	{
		return DoFilteredIteration(p_sequence, DoFilteredRestart, p_collectionChanger: false);
	}

	public static int Restart()
	{
		return Restart(p_skipDelay: false);
	}

	public static int Restart(bool p_skipDelay)
	{
		return DoFilteredIteration(null, DoFilteredRestart, p_collectionChanger: false, p_skipDelay);
	}

	public static int Reverse(object p_target)
	{
		return DoFilteredIteration(p_target, DoFilteredReverse, p_collectionChanger: false);
	}

	public static int Reverse(string p_id)
	{
		return DoFilteredIteration(p_id, DoFilteredReverse, p_collectionChanger: false);
	}

	public static int Reverse(int p_intId)
	{
		return DoFilteredIteration(p_intId, DoFilteredReverse, p_collectionChanger: false);
	}

	public static int Reverse(Tweener p_tweener)
	{
		return DoFilteredIteration(p_tweener, DoFilteredReverse, p_collectionChanger: false);
	}

	public static int Reverse(Sequence p_sequence)
	{
		return DoFilteredIteration(p_sequence, DoFilteredReverse, p_collectionChanger: false);
	}

	public static int Reverse()
	{
		return DoFilteredIteration(null, DoFilteredReverse, p_collectionChanger: false);
	}

	public static int Complete(object p_target)
	{
		return DoFilteredIteration(p_target, DoFilteredComplete, p_collectionChanger: true);
	}

	public static int Complete(string p_id)
	{
		return DoFilteredIteration(p_id, DoFilteredComplete, p_collectionChanger: true);
	}

	public static int Complete(int p_intId)
	{
		return DoFilteredIteration(p_intId, DoFilteredComplete, p_collectionChanger: true);
	}

	public static int Complete(Tweener p_tweener)
	{
		return DoFilteredIteration(p_tweener, DoFilteredComplete, p_collectionChanger: true);
	}

	public static int Complete(Sequence p_sequence)
	{
		return DoFilteredIteration(p_sequence, DoFilteredComplete, p_collectionChanger: true);
	}

	public static int Complete()
	{
		return DoFilteredIteration(null, DoFilteredComplete, p_collectionChanger: true);
	}

	public static int Kill(object p_target)
	{
		return DoFilteredIteration(p_target, DoFilteredKill, p_collectionChanger: true);
	}

	public static int Kill(string p_id)
	{
		return DoFilteredIteration(p_id, DoFilteredKill, p_collectionChanger: true);
	}

	public static int Kill(int p_intId)
	{
		return DoFilteredIteration(p_intId, DoFilteredKill, p_collectionChanger: true);
	}

	public static int Kill(Tweener p_tweener)
	{
		return DoFilteredIteration(p_tweener, DoFilteredKill, p_collectionChanger: true);
	}

	public static int Kill(Sequence p_sequence)
	{
		return DoFilteredIteration(p_sequence, DoFilteredKill, p_collectionChanger: true);
	}

	public static int Kill()
	{
		return DoFilteredIteration(null, DoFilteredKill, p_collectionChanger: true);
	}

	internal static void RemoveFromTweens(IHOTweenComponent p_tween)
	{
		if (tweens == null)
		{
			return;
		}
		int count = tweens.Count;
		for (int i = 0; i < count; i++)
		{
			if (tweens[i] == p_tween)
			{
				tweens.RemoveAt(i);
				break;
			}
		}
	}

	public static List<IHOTweenComponent> GetTweensById(string p_id, bool p_includeNestedTweens)
	{
		List<IHOTweenComponent> list = new List<IHOTweenComponent>();
		if (tweens == null)
		{
			return list;
		}
		int count = tweens.Count;
		for (int i = 0; i < count; i++)
		{
			ABSTweenComponent aBSTweenComponent = tweens[i];
			if (p_includeNestedTweens)
			{
				list.AddRange(aBSTweenComponent.GetTweensById(p_id));
			}
			else if (aBSTweenComponent.id == p_id)
			{
				list.Add(aBSTweenComponent);
			}
		}
		return list;
	}

	public static List<IHOTweenComponent> GetTweensByIntId(int p_intId, bool p_includeNestedTweens)
	{
		List<IHOTweenComponent> list = new List<IHOTweenComponent>();
		if (tweens == null)
		{
			return list;
		}
		int count = tweens.Count;
		for (int i = 0; i < count; i++)
		{
			ABSTweenComponent aBSTweenComponent = tweens[i];
			if (p_includeNestedTweens)
			{
				list.AddRange(aBSTweenComponent.GetTweensByIntId(p_intId));
			}
			else if (aBSTweenComponent.intId == p_intId)
			{
				list.Add(aBSTweenComponent);
			}
		}
		return list;
	}

	public static List<Tweener> GetTweenersByTarget(object p_target, bool p_includeNestedTweens)
	{
		List<Tweener> list = new List<Tweener>();
		if (tweens == null)
		{
			return list;
		}
		int count = tweens.Count;
		for (int i = 0; i < count; i++)
		{
			ABSTweenComponent aBSTweenComponent = tweens[i];
			if (aBSTweenComponent is Tweener tweener)
			{
				if (tweener.target == p_target)
				{
					list.Add(tweener);
				}
			}
			else if (p_includeNestedTweens)
			{
				list.AddRange(((Sequence)aBSTweenComponent).GetTweenersByTarget(p_target));
			}
		}
		return list;
	}

	public static bool IsTweening(object p_target)
	{
		if (tweens == null)
		{
			return false;
		}
		int count = tweens.Count;
		for (int i = 0; i < count; i++)
		{
			if (tweens[i].IsTweening(p_target))
			{
				return true;
			}
		}
		return false;
	}

	public static bool IsLinkedTo(object p_target)
	{
		if (tweens == null)
		{
			return false;
		}
		int count = tweens.Count;
		for (int i = 0; i < count; i++)
		{
			ABSTweenComponent aBSTweenComponent = tweens[i];
			if (aBSTweenComponent.IsLinkedTo(p_target))
			{
				return true;
			}
		}
		return false;
	}

	public static TweenInfo[] GetTweenInfos()
	{
		if (totTweens <= 0)
		{
			return null;
		}
		int count = tweens.Count;
		TweenInfo[] array = new TweenInfo[count];
		for (int i = 0; i < count; i++)
		{
			array[i] = new TweenInfo(tweens[i]);
		}
		return array;
	}

	private static void DoUpdate(UpdateType p_updateType, float p_elapsed)
	{
		tweensToRemoveIndexes.Clear();
		isUpdateLoop = true;
		int count = tweens.Count;
		for (int i = 0; i < count; i++)
		{
			ABSTweenComponent aBSTweenComponent = tweens[i];
			if (aBSTweenComponent.updateType == p_updateType && aBSTweenComponent.Update(p_elapsed * aBSTweenComponent.timeScale) && (aBSTweenComponent.destroyed || aBSTweenComponent.autoKillOnComplete))
			{
				aBSTweenComponent.Kill(p_autoRemoveFromHOTween: false);
				if (tweensToRemoveIndexes.IndexOf(i) == -1)
				{
					tweensToRemoveIndexes.Add(i);
				}
			}
		}
		isUpdateLoop = false;
		int count2 = tweensToRemoveIndexes.Count;
		if (count2 > 0)
		{
			tweensToRemoveIndexes.Sort();
			for (int i = 0; i < count2; i++)
			{
				tweens.RemoveAt(tweensToRemoveIndexes[i] - i);
			}
		}
		int count3 = onCompletes.Count;
		if (count3 > 0)
		{
			for (int i = 0; i < count3; i++)
			{
				onCompletes[i].OnCompleteDispatch();
			}
			onCompletes = new List<ABSTweenComponent>();
		}
	}

	private static void DoFilteredKill(int p_index, bool p_optionalBool)
	{
		tweens[p_index].Kill(p_autoRemoveFromHOTween: false);
		if (isUpdateLoop)
		{
			if (tweensToRemoveIndexes.IndexOf(p_index) == -1)
			{
				tweensToRemoveIndexes.Add(p_index);
			}
		}
		else
		{
			tweens.RemoveAt(p_index);
		}
	}

	private static void DoFilteredPause(int p_index, bool p_optionalBool)
	{
		tweens[p_index].Pause();
	}

	private static void DoFilteredPlay(int p_index, bool p_skipDelay)
	{
		ABSTweenComponent aBSTweenComponent = tweens[p_index];
		if (aBSTweenComponent is Tweener tweener)
		{
			tweener.Play(p_skipDelay);
		}
		else
		{
			aBSTweenComponent.Play();
		}
	}

	private static void DoFilteredPlayForward(int p_index, bool p_skipDelay)
	{
		ABSTweenComponent aBSTweenComponent = tweens[p_index];
		if (aBSTweenComponent is Tweener tweener)
		{
			tweener.PlayForward(p_skipDelay);
		}
		else
		{
			aBSTweenComponent.PlayForward();
		}
	}

	private static void DoFilteredPlayBackwards(int p_index, bool p_optionalBool)
	{
		ABSTweenComponent aBSTweenComponent = tweens[p_index];
		if (aBSTweenComponent is Tweener tweener)
		{
			tweener.PlayBackwards();
		}
		else
		{
			aBSTweenComponent.PlayBackwards();
		}
	}

	private static void DoFilteredRewind(int p_index, bool p_skipDelay)
	{
		ABSTweenComponent aBSTweenComponent = tweens[p_index];
		if (aBSTweenComponent is Tweener tweener)
		{
			tweener.Rewind(p_skipDelay);
		}
		else
		{
			aBSTweenComponent.Rewind();
		}
	}

	private static void DoFilteredRestart(int p_index, bool p_skipDelay)
	{
		ABSTweenComponent aBSTweenComponent = tweens[p_index];
		if (aBSTweenComponent is Tweener tweener)
		{
			tweener.Restart(p_skipDelay);
		}
		else
		{
			aBSTweenComponent.Restart();
		}
	}

	private static void DoFilteredReverse(int p_index, bool p_optionalBool)
	{
		tweens[p_index].Reverse();
	}

	private static void DoFilteredComplete(int p_index, bool p_optionalBool)
	{
		tweens[p_index].Complete(p_doAutoKill: false);
	}

	internal static void DoSendMessage(TweenEvent e)
	{
		GameObject gameObject = e.parms[0] as GameObject;
		if (!(gameObject == null))
		{
			string methodName = e.parms[1] as string;
			object obj = e.parms[2];
			SendMessageOptions options = (SendMessageOptions)e.parms[3];
			if (obj != null)
			{
				gameObject.SendMessage(methodName, e.parms[2], options);
			}
			else
			{
				gameObject.SendMessage(methodName, options);
			}
		}
	}

	private static void AddTween(ABSTweenComponent p_tween)
	{
		if (tweenGOInstance == null)
		{
			NewTweenInstance();
		}
		if (tweens == null)
		{
			tweens = new List<ABSTweenComponent>();
			it.StartCoroutines();
		}
		tweens.Add(p_tween);
		SetGOName();
	}

	private static void NewTweenInstance()
	{
		tweenGOInstance = new GameObject("HOTween");
		it = tweenGOInstance.AddComponent<HOTween>();
		Object.DontDestroyOnLoad(tweenGOInstance);
	}

	private void StartCoroutines()
	{
		time = Time.realtimeSinceStartup;
		StartCoroutine(StartCoroutines_StartTimeScaleIndependentUpdate());
	}

	private IEnumerator StartCoroutines_StartTimeScaleIndependentUpdate()
	{
		yield return null;
		StartCoroutine(TimeScaleIndependentUpdate());
	}

	private static void SetGOName()
	{
		if (isEditor && renameInstToCountTw)
		{
			tweenGOInstance.name = "HOTween : " + totTweens;
		}
	}

	private static bool CheckClear()
	{
		if (tweens == null || tweens.Count == 0)
		{
			Clear();
			if (isPermanent)
			{
				SetGOName();
			}
			return true;
		}
		SetGOName();
		return false;
	}

	private static void Clear()
	{
		if (it != null)
		{
			it.StopAllCoroutines();
		}
		tweens = null;
		if (!isPermanent)
		{
			if (tweenGOInstance != null)
			{
				Object.Destroy(tweenGOInstance);
			}
			tweenGOInstance = null;
			it = null;
		}
	}

	private static int DoFilteredIteration(object p_filter, TweenDelegate.FilterFunc p_operation, bool p_collectionChanger)
	{
		return DoFilteredIteration(p_filter, p_operation, p_collectionChanger, p_optionalBool: false);
	}

	private static int DoFilteredIteration(object p_filter, TweenDelegate.FilterFunc p_operation, bool p_collectionChanger, bool p_optionalBool)
	{
		if (tweens == null)
		{
			return 0;
		}
		int num = 0;
		int num2 = tweens.Count - 1;
		if (p_filter == null)
		{
			for (int num3 = num2; num3 > -1; num3--)
			{
				p_operation(num3, p_optionalBool);
				num++;
			}
		}
		else if (p_filter is int num4)
		{
			for (int num3 = num2; num3 > -1; num3--)
			{
				if (tweens[num3].intId == num4)
				{
					p_operation(num3, p_optionalBool);
					num++;
				}
			}
		}
		else if (p_filter is string)
		{
			string text = (string)p_filter;
			for (int num3 = num2; num3 > -1; num3--)
			{
				if (tweens[num3].id == text)
				{
					p_operation(num3, p_optionalBool);
					num++;
				}
			}
		}
		else if (p_filter is Tweener)
		{
			Tweener tweener = p_filter as Tweener;
			for (int num3 = num2; num3 > -1; num3--)
			{
				if (tweens[num3] == tweener)
				{
					p_operation(num3, p_optionalBool);
					num++;
				}
			}
		}
		else if (p_filter is Sequence)
		{
			Sequence sequence = p_filter as Sequence;
			for (int num3 = num2; num3 > -1; num3--)
			{
				if (tweens[num3] == sequence)
				{
					p_operation(num3, p_optionalBool);
					num++;
				}
			}
		}
		else
		{
			for (int num3 = num2; num3 > -1; num3--)
			{
				if (tweens[num3] is Tweener tweener2 && tweener2.target == p_filter)
				{
					p_operation(num3, p_optionalBool);
					num++;
				}
			}
		}
		if (p_collectionChanger)
		{
			CheckClear();
		}
		return num;
	}

	private static List<ABSTweenPlugin> GetPlugins()
	{
		if (tweens == null)
		{
			return null;
		}
		List<ABSTweenPlugin> list = new List<ABSTweenPlugin>();
		int count = tweens.Count;
		for (int i = 0; i < count; i++)
		{
			tweens[i].FillPluginsList(list);
		}
		return list;
	}
}
