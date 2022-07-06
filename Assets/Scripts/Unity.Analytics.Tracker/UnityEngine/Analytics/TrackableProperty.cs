using System;
using UnityEngine;
using System.Collections.Generic;

namespace UnityEngine.Analytics
{
	[Serializable]
	internal class TrackableProperty
	{
		[Serializable]
		internal class FieldWithTarget
		{
			[SerializeField]
			private string m_ParamName;
			[SerializeField]
			private Object m_Target;
			[SerializeField]
			private string m_FieldPath;
			[SerializeField]
			private string m_TypeString;
			[SerializeField]
			private bool m_DoStatic;
			[SerializeField]
			private string m_StaticString;
		}

		[SerializeField]
		private List<TrackableProperty.FieldWithTarget> m_Fields;
	}
}
