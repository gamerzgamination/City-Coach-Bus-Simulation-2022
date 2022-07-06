using UnityEngine;

public class WheelRotation : MonoBehaviour
{
	public float speed;

	private void Start()
	{
		speed = Time.deltaTime;
	}

	private void Update()
	{
		wheelrotate();
	}

	public void wheelrotate()
	{
		if (Time.timeScale != 1E-06f)
		{
			base.transform.Rotate(speed * 500f, 0f, 0f);
		}
	}
}
