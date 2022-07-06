using System;
using UnityEngine;

namespace UnityEngine.Analytics
{
	[Serializable]
	public class EventTrigger
	{
		[SerializeField]
		private bool m_IsTriggerExpanded;
		[SerializeField]
		private TriggerType m_Type;
		[SerializeField]
		private TriggerLifecycleEvent m_LifecycleEvent;
		[SerializeField]
		private bool m_ApplyRules;
		[SerializeField]
		private TriggerListContainer m_Rules;
		[SerializeField]
		private TriggerBool m_TriggerBool;
		[SerializeField]
		private float m_InitTime;
		[SerializeField]
		private float m_RepeatTime;
		[SerializeField]
		private int m_Repetitions;
		public int repetitionCount;
	}
}
