using System;
using System.Collections.Generic;
using UnityEngine;

namespace UnityEngine.Analytics
{
	[Serializable]
	public class TriggerListContainer
	{
		[SerializeField]
		private List<TriggerRule> m_Rules;
	}
}
