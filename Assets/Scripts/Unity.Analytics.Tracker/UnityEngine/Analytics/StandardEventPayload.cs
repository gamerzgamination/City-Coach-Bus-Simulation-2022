using System;
using UnityEngine;

namespace UnityEngine.Analytics
{
	[Serializable]
	public class StandardEventPayload
	{
		[SerializeField]
		private bool m_IsEventExpanded;
		[SerializeField]
		private string m_StandardEventType;
		[SerializeField]
		private AnalyticsEventParamListContainer m_Parameters;
		[SerializeField]
		private string m_Name;
	}
}
