using System;
using UnityEngine;

namespace UnityEngine.Analytics
{
	[Serializable]
	public class TrackablePropertyBase
	{
		[SerializeField]
		protected Object m_Target;
		[SerializeField]
		protected string m_Path;
	}
}
