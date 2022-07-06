using UnityEngine;

[AddComponentMenu("BoneCracker Games/Realistic Car Controller/UI/Mobile/Mobile Buttons")]
public class RCC_MobileButtons : MonoBehaviour
{
	public RCC_CarControllerV3 carControllers;

	public RCC_UIController gasButton;

	public RCC_UIController brakeButton;

	public RCC_UIController leftButton;

	public RCC_UIController rightButton;

	public RCC_UISteeringWheelController steeringWheel;

	public RCC_UIController handbrakeButton;

	public RCC_UIController NOSButton;

	public GameObject gearButton;

	public GameObject RefBrakeBtn;

	private float gasInput;

	private float brakeInput;

	private float leftInput;

	private float rightInput;

	private float steeringWheelInput;

	private float handbrakeInput;

	private float NOSInput = 1f;

	private float gyroInput;

	private Vector3 orgBrakeButtonPos;

	private void Start()
	{
		if (RCC_Settings.Instance.controllerType != RCC_Settings.ControllerType.Mobile)
		{
			if ((bool)gasButton)
			{
				gasButton.gameObject.SetActive(value: false);
			}
			if ((bool)leftButton)
			{
				leftButton.gameObject.SetActive(value: false);
			}
			if ((bool)rightButton)
			{
				rightButton.gameObject.SetActive(value: false);
			}
			if ((bool)brakeButton)
			{
				brakeButton.gameObject.SetActive(value: false);
			}
			if ((bool)steeringWheel)
			{
				steeringWheel.gameObject.SetActive(value: false);
			}
			if ((bool)handbrakeButton)
			{
				handbrakeButton.gameObject.SetActive(value: false);
			}
			if ((bool)NOSButton)
			{
				NOSButton.gameObject.SetActive(value: false);
			}
			if ((bool)gearButton)
			{
				gearButton.gameObject.SetActive(value: false);
			}
			base.enabled = false;
		}
		else
		{
			orgBrakeButtonPos = brakeButton.transform.position;
			GetVehicles();
		}
	}

	public void GetVehicles()
	{
		//carControllers = Object.FindObjectsOfType<RCC_CarControllerV3>();
		carControllers = Toolbox.GameplayController.SelectedVehiclePrefab.GetComponent<RCC_CarControllerV3>();
	}

	private void Update()
	{
		if (RCC_Settings.Instance.useSteeringWheelForSteering)
		{
			if (RCC_Settings.Instance.useAccelerometerForSteering)
			{
				RCC_Settings.Instance.useAccelerometerForSteering = false;
			}
			if (!steeringWheel.gameObject.activeInHierarchy)
			{
				steeringWheel.gameObject.SetActive(value: true);
				brakeButton.transform.position = orgBrakeButtonPos;
			}
			if (leftButton.gameObject.activeInHierarchy)
			{
				leftButton.gameObject.SetActive(value: false);
			}
			if (rightButton.gameObject.activeInHierarchy)
			{
				rightButton.gameObject.SetActive(value: false);
			}
		}
		if (RCC_Settings.Instance.useAccelerometerForSteering)
		{
			if (RCC_Settings.Instance.useSteeringWheelForSteering)
			{
				RCC_Settings.Instance.useSteeringWheelForSteering = false;
			}
			brakeButton.transform.position = RefBrakeBtn.transform.position;
			if (steeringWheel.gameObject.activeInHierarchy)
			{
				steeringWheel.gameObject.SetActive(value: false);
			}
			if (leftButton.gameObject.activeInHierarchy)
			{
				leftButton.gameObject.SetActive(value: false);
			}
			if (rightButton.gameObject.activeInHierarchy)
			{
				rightButton.gameObject.SetActive(value: false);
			}
		}
		if (!RCC_Settings.Instance.useAccelerometerForSteering && !RCC_Settings.Instance.useSteeringWheelForSteering)
		{
			if ((bool)steeringWheel && steeringWheel.gameObject.activeInHierarchy)
			{
				steeringWheel.gameObject.SetActive(value: false);
			}
			if (!leftButton.gameObject.activeInHierarchy)
			{
				brakeButton.transform.position = orgBrakeButtonPos;
				leftButton.gameObject.SetActive(value: true);
			}
			if (!rightButton.gameObject.activeInHierarchy)
			{
				rightButton.gameObject.SetActive(value: true);
			}
		}
		gasInput = GetInput(gasButton);
		brakeInput = GetInput(brakeButton);
		leftInput = GetInput(leftButton);
		rightInput = GetInput(rightButton);
		if ((bool)steeringWheel)
		{
			steeringWheelInput = steeringWheel.input;
		}
		if (RCC_Settings.Instance.useAccelerometerForSteering)
		{
			gyroInput = Input.acceleration.x * RCC_Settings.Instance.gyroSensitivity;
		}
		else
		{
			gyroInput = 0f;
		}
		handbrakeInput = GetInput(handbrakeButton);
		NOSInput = Mathf.Clamp(GetInput(NOSButton) * 2.5f, 1f, 2.5f);

		carControllers.gasInput = gasInput;
        carControllers.brakeInput = brakeInput;
        carControllers.steerInput = 0f - leftInput + rightInput + steeringWheelInput + gyroInput;
        carControllers.handbrakeInput = handbrakeInput;
        carControllers.boostInput = NOSInput;

        //RCC_CarControllerV3[] array = carControllers;
        //foreach (RCC_CarControllerV3 rCC_CarControllerV in array)
        //{
        //	if (rCC_CarControllerV.canControl)
        //	{
        //		rCC_CarControllerV.gasInput = gasInput;
        //		rCC_CarControllerV.brakeInput = brakeInput;
        //		rCC_CarControllerV.steerInput = 0f - leftInput + rightInput + steeringWheelInput + gyroInput;
        //		rCC_CarControllerV.handbrakeInput = handbrakeInput;
        //		rCC_CarControllerV.boostInput = NOSInput;
        //	}
        //}
    }

	private float GetInput(RCC_UIController button)
	{
		if (button == null)
		{
			return 0f;
		}
		return button.input;
	}

	public void ChangeCamera()
	{
		if ((bool)Object.FindObjectOfType<RCC_Camera>())
		{
			Object.FindObjectOfType<RCC_Camera>().ChangeCamera();
		}
	}

	public void ChangeController(int index)
	{
		switch (index)
		{
		case 0:
			RCC_Settings.Instance.useAccelerometerForSteering = false;
			RCC_Settings.Instance.useSteeringWheelForSteering = false;
			break;
		case 1:
			RCC_Settings.Instance.useAccelerometerForSteering = true;
			RCC_Settings.Instance.useSteeringWheelForSteering = false;
			break;
		case 2:
			RCC_Settings.Instance.useAccelerometerForSteering = false;
			RCC_Settings.Instance.useSteeringWheelForSteering = true;
			break;
		}
	}
}
