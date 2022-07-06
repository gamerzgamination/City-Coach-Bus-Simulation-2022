using System;
using UnityEngine;

namespace UnityEngine.Analytics
{
	[Serializable]
	public class TriggerRule
	{
		[SerializeField]
		private TrackableField m_Target;
		[SerializeField]
		private TriggerOperator m_Operator;
		[SerializeField]
		private ValueProperty m_Value;
		[SerializeField]
		private ValueProperty m_Value2;
	}
}
