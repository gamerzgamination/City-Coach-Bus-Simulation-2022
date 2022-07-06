using UnityEngine;
using UnityEngine.UI;

[AddComponentMenu("BoneCracker Games/Realistic Car Controller/UI/Dashboard Button")]
public class RCC_UIDashboardButton : MonoBehaviour
{
	public enum ButtonType
	{
		Start,
		ABS,
		ESP,
		TCS,
		Headlights,
		LeftIndicator,
		RightIndicator,
		Gear
	}

	public GameObject EngineBtn;

	public ButtonType _buttonType;

	private Scrollbar gearSlider;

	private RCC_CarControllerV3[] carControllers;

	private int gearDirection;

	private static bool reverse;

	public static RCC_UIDashboardButton instance;

	private void Start()
	{
		instance = this;
		reverse = false;
	}

	private void OnEnable()
	{
		Check();
	}

	public void OnClicked()
	{
		//GameManagerU.instance.enginePanel.SetActive(value: false);
		base.gameObject.GetComponent<Animator>().enabled = false;
		carControllers = Object.FindObjectsOfType<RCC_CarControllerV3>();
		switch (_buttonType)
		{
		case ButtonType.Start:
		{
			for (int n = 0; n < carControllers.Length; n++)
			{
				if (carControllers[n].canControl)
				{
					carControllers[n].KillOrStartEngine();
				}
			}
			break;
		}
		case ButtonType.ABS:
		{
			for (int j = 0; j < carControllers.Length; j++)
			{
				if (carControllers[j].canControl)
				{
					carControllers[j].ABS = !carControllers[j].ABS;
				}
			}
			break;
		}
		case ButtonType.ESP:
		{
			for (int l = 0; l < carControllers.Length; l++)
			{
				if (carControllers[l].canControl)
				{
					carControllers[l].ESP = !carControllers[l].ESP;
				}
			}
			break;
		}
		case ButtonType.TCS:
		{
			for (int num = 0; num < carControllers.Length; num++)
			{
				if (carControllers[num].canControl)
				{
					carControllers[num].TCS = !carControllers[num].TCS;
				}
			}
			break;
		}
		case ButtonType.Headlights:
		{
			for (int m = 0; m < carControllers.Length; m++)
			{
				if (carControllers[m].canControl)
				{
					if (!carControllers[m].highBeamHeadLightsOn && carControllers[m].lowBeamHeadLightsOn)
					{
						carControllers[m].highBeamHeadLightsOn = true;
						carControllers[m].lowBeamHeadLightsOn = true;
						break;
					}
					if (!carControllers[m].lowBeamHeadLightsOn)
					{
						carControllers[m].lowBeamHeadLightsOn = true;
					}
					if (carControllers[m].highBeamHeadLightsOn)
					{
						carControllers[m].lowBeamHeadLightsOn = false;
						carControllers[m].highBeamHeadLightsOn = false;
					}
				}
			}
			break;
		}
		case ButtonType.LeftIndicator:
		{
			for (int k = 0; k < carControllers.Length; k++)
			{
				if (carControllers[k].canControl)
				{
					if (carControllers[k].indicatorsOn != RCC_CarControllerV3.IndicatorsOn.Left)
					{
						carControllers[k].indicatorsOn = RCC_CarControllerV3.IndicatorsOn.Left;
					}
					else
					{
						carControllers[k].indicatorsOn = RCC_CarControllerV3.IndicatorsOn.Off;
					}
				}
			}
			break;
		}
		case ButtonType.RightIndicator:
		{
			for (int i = 0; i < carControllers.Length; i++)
			{
				if (carControllers[i].canControl)
				{
					if (carControllers[i].indicatorsOn != RCC_CarControllerV3.IndicatorsOn.Right)
					{
						carControllers[i].indicatorsOn = RCC_CarControllerV3.IndicatorsOn.Right;
					}
					else
					{
						carControllers[i].indicatorsOn = RCC_CarControllerV3.IndicatorsOn.Off;
					}
				}
			}
			break;
		}
		}
		Check();
	}

	public void Check()
	{
		carControllers = Object.FindObjectsOfType<RCC_CarControllerV3>();
		switch (_buttonType)
		{
		case ButtonType.ABS:
		{
			for (int l = 0; l < carControllers.Length; l++)
			{
				if (carControllers[l].canControl && carControllers[l].ABS)
				{
					GetComponent<Image>().color = new Color(1f, 1f, 1f, 1f);
				}
				else if (carControllers[l].canControl)
				{
					GetComponent<Image>().color = new Color(0.25f, 0.25f, 0.25f, 1f);
				}
			}
			break;
		}
		case ButtonType.ESP:
		{
			for (int j = 0; j < carControllers.Length; j++)
			{
				if (carControllers[j].canControl && carControllers[j].ESP)
				{
					GetComponent<Image>().color = new Color(1f, 1f, 1f, 1f);
				}
				else if (carControllers[j].canControl)
				{
					GetComponent<Image>().color = new Color(0.25f, 0.25f, 0.25f, 1f);
				}
			}
			break;
		}
		case ButtonType.TCS:
		{
			for (int k = 0; k < carControllers.Length; k++)
			{
				if (carControllers[k].canControl && carControllers[k].TCS)
				{
					GetComponent<Image>().color = new Color(1f, 1f, 1f, 1f);
				}
				else if (carControllers[k].canControl)
				{
					GetComponent<Image>().color = new Color(0.25f, 0.25f, 0.25f, 1f);
				}
			}
			break;
		}
		case ButtonType.Headlights:
		{
			for (int i = 0; i < carControllers.Length; i++)
			{
				if ((carControllers[i].canControl && carControllers[i].lowBeamHeadLightsOn) || carControllers[i].highBeamHeadLightsOn)
				{
					GetComponent<Image>().color = new Color(1f, 1f, 1f, 1f);
				}
				else if (carControllers[i].canControl)
				{
					GetComponent<Image>().color = new Color(0.25f, 0.25f, 0.25f, 1f);
				}
			}
			break;
		}
		}
	}

	public void ChangeGear()
	{
		reverse = !reverse;
		for (int i = 0; i < carControllers.Length; i++)
		{
			if (carControllers[i].canControl)
			{
				carControllers[i].semiAutomaticGear = true;
				if (reverse)
				{
					carControllers[i].StartCoroutine("ChangingGear", -1);
					GameManagerU.instance.gareButton.image.sprite = GameManagerU.instance.GareChangeSprite[1];
				}
				else
				{
					carControllers[i].StartCoroutine("ChangingGear", 0);
					GameManagerU.instance.gareButton.image.sprite = GameManagerU.instance.GareChangeSprite[0];
				}
			}
		}
	}

	private void OnDisable()
	{
		if (_buttonType != ButtonType.Gear)
		{
			return;
		}
		carControllers = Object.FindObjectsOfType<RCC_CarControllerV3>();
		RCC_CarControllerV3[] array = carControllers;
		foreach (RCC_CarControllerV3 rCC_CarControllerV in array)
		{
			if (rCC_CarControllerV.canControl)
			{
				rCC_CarControllerV.semiAutomaticGear = false;
			}
		}
	}
}
