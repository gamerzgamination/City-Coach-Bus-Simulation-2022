using System;
using UnityEngine;

namespace UnityEngine.Analytics
{
	[Serializable]
	public class TrackableField : TrackablePropertyBase
	{
		public TrackableField(Type[] validTypes)
		{
		}

		[SerializeField]
		private string[] m_ValidTypeNames;
		[SerializeField]
		private string m_Type;
		[SerializeField]
		private string m_EnumType;
	}
}
