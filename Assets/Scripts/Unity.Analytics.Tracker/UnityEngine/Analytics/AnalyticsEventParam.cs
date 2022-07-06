using System;
using UnityEngine;

namespace UnityEngine.Analytics
{
	[Serializable]
	public class AnalyticsEventParam
	{
		public enum RequirementType
		{
			None = 0,
			Required = 1,
			Optional = 2,
		}

		public AnalyticsEventParam(string name)
		{
		}

		[SerializeField]
		private RequirementType m_RequirementType;
		[SerializeField]
		private string m_GroupID;
		[SerializeField]
		private string m_Tooltip;
		[SerializeField]
		private string m_Name;
		[SerializeField]
		private ValueProperty m_Value;
	}
}
