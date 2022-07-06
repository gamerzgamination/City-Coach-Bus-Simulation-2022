using UnityEngine;

public class csRotate : MonoBehaviour
{
	public float XRotateSpeed;

	public float YRotateSpeed;

	public float ZRotateSpeed;

	private void Update()
	{
		base.transform.Rotate(XRotateSpeed, YRotateSpeed, ZRotateSpeed);
	}
}
