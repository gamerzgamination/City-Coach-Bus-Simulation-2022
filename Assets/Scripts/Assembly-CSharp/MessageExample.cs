using System.Collections;
//using Holoville.HOTween;
using UnityEngine;

public class MessageExample : MonoBehaviour
{
	private iMove iScript;

	private hoMove hoScript;

	private Transform thisObject;

	private void Start()
	{
		iScript = GetComponent<iMove>();
		hoScript = GetComponent<hoMove>();
		thisObject = base.transform;
	}

	private void PositionObject(Object point)
	{
		GameObject gameObject = (GameObject)point;
		HOTween.To(thisObject, 1f, new TweenParms().Prop("position", gameObject.transform.position + new Vector3(0f, 10f, 0f)).Ease(EaseType.Linear).Loops(2, LoopType.Yoyo));
	}

	private void RotateObject(Vector3 rot)
	{
		HOTween.To(thisObject, 1f, new TweenParms().Prop("rotation", rot).Ease(EaseType.Linear).Loops(2, LoopType.Yoyo));
	}

	private void UpdatePoints()
	{
		hoScript.Stop();
		hoScript.currentPoint = 0;
		hoScript.moveToPath = true;
		hoScript.StartMove();
	}

	private IEnumerator StopAndResume(float seconds)
	{
		iScript.Stop();
		yield return new WaitForSeconds(seconds);
		iScript.StartMove();
	}

	private IEnumerator PauseAndResume(float seconds)
	{
		hoScript.Pause();
		yield return new WaitForSeconds(seconds);
		hoScript.Resume();
	}

	private void PrintProgress()
	{
		Debug.Log(base.gameObject.name + ": I'm now at waypoint " + (hoScript.currentPoint + 1) + ".");
	}

	private void PrintText(string text)
	{
		Debug.Log(text);
	}

	private void Method1()
	{
	}
}
