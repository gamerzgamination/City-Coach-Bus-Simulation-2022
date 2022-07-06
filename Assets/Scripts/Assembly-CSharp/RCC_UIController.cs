using UnityEngine;
using UnityEngine.EventSystems;

[AddComponentMenu("BoneCracker Games/Realistic Car Controller/UI/Mobile/Button")]
public class RCC_UIController : MonoBehaviour, IPointerDownHandler, IPointerUpHandler, IEventSystemHandler
{
	internal float input;

	public bool pressing;

	private float sensitivity => RCC_Settings.Instance.UIButtonSensitivity;

	private float gravity => RCC_Settings.Instance.UIButtonGravity;

	public void OnPointerDown(PointerEventData eventData)
	{
		pressing = true;
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		pressing = false;
	}

	private void OnPress(bool isPressed)
	{
		if (isPressed)
		{
			pressing = true;
		}
		else
		{
			pressing = false;
		}
	}

	private void Update()
	{
		if (pressing)
		{
			input += Time.deltaTime * sensitivity;
		}
		else
		{
			input -= Time.deltaTime * gravity;
		}
		if (input < 0f)
		{
			input = 0f;
		}
		if (input > 1f)
		{
			input = 1f;
		}
	}

	private void OnDisable()
	{
		input = 0f;
		pressing = false;
	}
}
