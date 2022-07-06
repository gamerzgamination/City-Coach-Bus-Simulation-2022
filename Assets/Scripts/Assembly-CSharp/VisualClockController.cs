using UnityEngine;

public class VisualClockController : MonoBehaviour
{
	public Transform hourHand;

	public Transform minuteHand;

	private float hoursToDegrees = 6f;

	private float minsToDegrees = 30f;

	private DayAndNightControl controller;

	private void Awake()
	{
		controller = GameObject.Find("Day and Night Controller").GetComponent<DayAndNightControl>();
	}

	private void Update()
	{
		float num = 24f * controller.currentTime;
		float num2 = 60f * (num - Mathf.Floor(num));
		hourHand.localRotation = Quaternion.Euler(num * hoursToDegrees, 0f, 0f);
		minuteHand.localRotation = Quaternion.Euler(num2 * minsToDegrees, 0f, 0f);
	}
}
