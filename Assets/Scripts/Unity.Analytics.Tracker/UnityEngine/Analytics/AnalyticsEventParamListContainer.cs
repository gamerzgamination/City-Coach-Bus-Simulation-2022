using System;
using System.Collections.Generic;
using UnityEngine;

namespace UnityEngine.Analytics
{
	[Serializable]
	public class AnalyticsEventParamListContainer
	{
		[SerializeField]
		private List<AnalyticsEventParam> m_Parameters;
	}
}
