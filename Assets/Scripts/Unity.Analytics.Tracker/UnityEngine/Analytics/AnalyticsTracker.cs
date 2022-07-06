using UnityEngine;

namespace UnityEngine.Analytics
{
	public class AnalyticsTracker : MonoBehaviour
	{
		internal enum Trigger
		{
			External = 0,
			Awake = 1,
			Start = 2,
			OnEnable = 3,
			OnDisable = 4,
			OnApplicationPause = 5,
			OnDestroy = 6,
		}

		[SerializeField]
		private string m_EventName;
		[SerializeField]
		private TrackableProperty m_TrackableProperty;
		[SerializeField]
		internal Trigger m_Trigger;
	}
}
