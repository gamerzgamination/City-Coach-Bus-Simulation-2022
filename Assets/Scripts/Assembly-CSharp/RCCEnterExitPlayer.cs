using UnityEngine;

public class RCCEnterExitPlayer : MonoBehaviour
{
	public float maxRayDistance = 2f;

	private bool showGui;

	private void Start()
	{
		GameObject gameObject = Object.FindObjectOfType<RCC_Camera>().gameObject;
		gameObject.SetActive(value: false);
	}

	private void Update()
	{
		Vector3 direction = base.transform.TransformDirection(Vector3.forward);
		if (Physics.Raycast(base.transform.position, direction, out var hitInfo, maxRayDistance))
		{
			if ((bool)hitInfo.transform.GetComponentInParent<RCC_CarControllerV3>())
			{
				showGui = true;
				if (Input.GetKeyDown(RCC_Settings.Instance.enterExitVehicleKB))
				{
					hitInfo.transform.GetComponentInParent<RCC_CarControllerV3>().SendMessage("Act", GetComponentInParent<CharacterController>().gameObject, SendMessageOptions.DontRequireReceiver);
				}
			}
			else
			{
				showGui = false;
			}
		}
		else
		{
			showGui = false;
		}
	}

	private void OnGUI()
	{
		if (showGui)
		{
			GUI.Label(new Rect((float)Screen.width - (float)Screen.width / 1.7f, (float)Screen.height - (float)Screen.height / 1.2f, 800f, 100f), "Press ''" + RCC_Settings.Instance.enterExitVehicleKB.ToString() + "'' key to Get In");
		}
	}
}
