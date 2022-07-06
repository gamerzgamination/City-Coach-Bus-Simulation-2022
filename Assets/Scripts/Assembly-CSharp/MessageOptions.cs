using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class MessageOptions
{
	public enum ValueType
	{
		None,
		Object,
		Text,
		Numeric,
		Vector2,
		Vector3
	}

	public List<string> message = new List<string>();

	public List<ValueType> type = new List<ValueType>();

	public List<UnityEngine.Object> obj = new List<UnityEngine.Object>();

	public List<string> text = new List<string>();

	public List<float> num = new List<float>();

	public List<Vector2> vect2 = new List<Vector2>();

	public List<Vector3> vect3 = new List<Vector3>();
}
