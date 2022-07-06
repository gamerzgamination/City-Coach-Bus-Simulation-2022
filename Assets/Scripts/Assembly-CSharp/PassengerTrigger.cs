using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class PassengerTrigger : MonoBehaviour
{
	public static PassengerTrigger instance;

	public GameObject warmingPanel;

	public GameObject TollPlaza;

	public GameObject TollPlaza2;

	public GameObject SpeedLimitText;

	public GameObject OverSpeedText;

	public bool MotorWayStarted;

	public bool cashDeductCounter = true;

	public static bool RefuelBool;

	public GameObject RefuelCompleted;

	public static bool Refueling;

	public GameObject GameCanvas;

	public Image ParkingImage;

	private void Awake()
	{
		instance = this;
	}

	private void Start()
	{
		RefuelBool = false;
		Refueling = false;
	}

	private void Update()
	{
	}

	public void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.tag == "people1")
		{
			GameManagerU.instance.GamePlayPanel.SetActive(value: false);
			warmingPanel.SetActive(value: true);
			Invoke("ShowLevelFailed", 3f);
		}
		if (other.gameObject.tag == "tollplaza")
		{
			Invoke("OpenTollPlaza", 0.1f);
		}
		if (other.gameObject.tag == "tollplaza2")
		{
			Invoke("OpenTollPlaza2", 0.1f);
		}
		if (other.gameObject.tag == "speedLimit")
		{
			MotorWayStarted = true;
			StartCoroutine(ShowSpeedLimitText());
		}
		if (other.gameObject.tag == "motorwayExit")
		{
			MotorWayStarted = false;
		}
		if (other.gameObject.tag == "speedcheck" && RCC_CarControllerV3.instance.speed > 80f && PlayerPrefs.GetInt("TotalCash") > 500 && cashDeductCounter)
		{
			cashDeductCounter = false;
			PlayerPrefs.SetInt("TotalCash", PlayerPrefs.GetInt("TotalCash") - 500);
			PlayerPrefs.Save();
			if (!SpeedLimitText.activeInHierarchy && !OverSpeedText.activeInHierarchy)
			{
				StartCoroutine(ShowOverSpeedText());
			}
		}
	}

	private void OnTriggerStay(Collider c)
	{
		//if (LevelSelectionDemo.instance.currentLevel < 1)
		//{
		//	return;
		//}
		if (c.gameObject.gameObject.tag == "refuelpoint")
		{
			RefuelBool = true;
			GameManagerU.instance.fuelImage.fillAmount += 0.025f * Time.deltaTime;
			if (GameManagerU.instance.fuelImage.fillAmount >= 1f && !Refueling)
			{
				Refueling = true;
				StartCoroutine("ShowRefuelDone");
			}
		}
		if (c.gameObject.tag == "stand")
		{
			ParkingImage.fillAmount += 0.1f * Time.deltaTime;
		}
	}

	private void OnTriggerExit(Collider c)
	{
		if (LevelSelectionDemo.instance.currentLevel >= 1 && c.gameObject.gameObject.tag == "refuelpoint")
		{
			RefuelBool = false;
			Refueling = false;
		}
	}

	private IEnumerator ShowRefuelDone()
	{
		RefuelCompleted.SetActive(value: true);
		yield return new WaitForSeconds(3f);
		RefuelCompleted.SetActive(value: false);
	}

	private IEnumerator ShowSpeedLimitText()
	{
		SpeedLimitText.SetActive(value: true);
		yield return new WaitForSeconds(5f);
		SpeedLimitText.SetActive(value: false);
	}

	private IEnumerator ShowOverSpeedText()
	{
		OverSpeedText.SetActive(value: true);
		yield return new WaitForSeconds(3f);
		OverSpeedText.SetActive(value: false);
	}

	private void OpenTollPlaza()
	{
		TollPlaza.GetComponent<Animator>().enabled = true;
	}

	private void OpenTollPlaza2()
	{
		TollPlaza2.GetComponent<Animator>().enabled = true;
	}

	public void ShowLevelFailed()
	{
		GameManagerU.instance.showLevelFailed();
		warmingPanel.SetActive(value: false);
	}
}
