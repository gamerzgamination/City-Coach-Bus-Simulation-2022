using System;
using UnityEngine;

namespace UnityEngine.Analytics
{
	[Serializable]
	public class ValueProperty
	{
		public enum PropertyType
		{
			Disabled = 0,
			Static = 1,
			Dynamic = 2,
		}

		[SerializeField]
		private bool m_EditingCustomValue;
		[SerializeField]
		private int m_PopupIndex;
		[SerializeField]
		private string m_CustomValue;
		[SerializeField]
		private bool m_FixedType;
		[SerializeField]
		private string m_EnumType;
		[SerializeField]
		private bool m_EnumTypeIsCustomizable;
		[SerializeField]
		private bool m_CanDisable;
		[SerializeField]
		private PropertyType m_PropertyType;
		[SerializeField]
		private string m_ValueType;
		[SerializeField]
		private string m_Value;
		[SerializeField]
		private TrackableField m_Target;
	}
}
