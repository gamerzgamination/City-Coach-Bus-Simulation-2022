using UnityEngine;

namespace UnityEngine.Analytics
{
	public class AnalyticsEventTracker : MonoBehaviour
	{
		[SerializeField]
		public EventTrigger m_Trigger;
		[SerializeField]
		private StandardEventPayload m_EventPayload;
	}
}
