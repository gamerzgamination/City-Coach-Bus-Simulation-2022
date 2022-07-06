using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class GameManagerU : MonoBehaviour
{
	[HideInInspector]
	public static GameManagerU instance;

	[Header("Game Manager")]
	public GameObject levelsdata;

	public GameObject playerPositions;

	public Transform playerNew;

	[Header("sprites")]
	public Sprite[] engineOnOff;

	public Sprite[] GareChangeSprite;

	public GameObject GamePlayPanel;

	public GameObject PausePanel;

	public GameObject WatchVideoPanel;

	public GameObject levelDescriptionPanel;

	public GameObject levelCompletePanel;

	public GameObject levelFailedPanel;

	public GameObject loadingPanel;

	public GameObject InteriorImage;

	public GameObject triggercube;

	public GameObject enginePanel;

	public GameObject watchVideoBtn;

	public GameObject[] Des;

	public bool Refuel = true;

	public GameObject RefuelText;

	public GameObject WatchToRefuelReminder;

	public GameObject[] BusesToEnable;

	public GameObject[] GearButtons;

	public GameObject[] HornButtons;

	public GameObject MapImg;

	private bool ClickNextBool;

	public Button control;

	public Button engineButton;

	public Button gareButton;

	private bool isGamePlay;

	private bool isPause;

	private bool isLevelDescription;

	private bool isLevelComplete;

	private bool islevelFailed;

	private bool isLoading;

	private bool RefuelMsgBool = true;

	private float ZeroTime = 1E-06f;

	private AsyncOperation ALLOperation;

	public static bool femaleTalkingBool;

	public Image fuelImage;

	public Text loading_text;

	public Text loadingVideotextToNext;

	public GameObject[] CameraButtons;

	private bool LevelFailBool;

	public GameObject Starfill1;

	public GameObject Starfill2;

	public GameObject Starfill3;

	public GameObject Starfill4;

	public GameObject Starfill5;

	public GameObject ThanksBtn;

	public GameObject RateUsBtn;

	public GameObject RateUSPanel;

	public Text LevelNmbr;

	public GameObject[] MissionTexts;

	private bool loadMenu;

	private void Awake()
	{
		if (PlayerPrefs.GetInt("SteerMode") == 0 && PlayerPrefs.GetInt("tiltMode") == 0 && PlayerPrefs.GetInt("ButtonMode") == 0)
		{
			PlayerPrefs.SetInt("tiltMode", 0);
			PlayerPrefs.SetInt("SteerMode", 0);
			PlayerPrefs.SetInt("ButtonMode", 1);
			HornButtons[0].SetActive(value: false);
			HornButtons[1].SetActive(value: true);
			HornButtons[2].SetActive(value: false);
		}
		else
		{
			PlayerPrefs.SetInt("tiltMode", 0);
			PlayerPrefs.SetInt("SteerMode", 0);
			PlayerPrefs.SetInt("ButtonMode", 1);
			HornButtons[0].SetActive(value: false);
			HornButtons[1].SetActive(value: true);
			HornButtons[2].SetActive(value: false);
		}
		femaleTalkingBool = false;
		instance = this;
		if (LevelSelectionDemo.instance.currentLevel == 4)
		{
			GameObject.FindGameObjectWithTag("path7").gameObject.SetActive(value: false);
		}
		if (LevelSelectionDemo.instance.currentLevel == 1)
		{
			for (int i = 0; i < 4; i++)
			{
				if (i == 3)
				{
					Des[i].SetActive(value: false);
				}
				else
				{
					Des[i].SetActive(value: true);
				}
			}
			return;
		}
		for (int j = 0; j < 3; j++)
		{
			if (j == 3)
			{
				Des[j].SetActive(value: true);
			}
			else
			{
				Des[j].SetActive(value: false);
			}
		}
	}

	public void WatchVideoToUnlockLvl()
	{
		PlayerPrefs.SetInt("WatchToUnlock", 1);
		StartCoroutine("loadingVideo_text_To_Next");
		//AdsManager.Instance.hideBanner();
		//AdsManager.Instance.ShowRewardedUnityADS();
	}

	private void Start()
	{
		PlayerPrefs.SetInt("tiltMode", 0);
		PlayerPrefs.SetInt("SteerMode", 0);
		PlayerPrefs.SetInt("ButtonMode", 1);
		RCC_Settings.instance.useSteeringWheelForSteering = false;
		RCC_Settings.instance.useAccelerometerForSteering = false;
		HornButtons[0].SetActive(value: false);
		HornButtons[1].SetActive(value: true);
		HornButtons[2].SetActive(value: false);
		if (LevelSelectionDemo.instance.currentLevel > 1 && LevelSelectionDemo.instance.currentLevel < 4)
		{
			MissionTexts[0].SetActive(value: true);
			MissionTexts[1].SetActive(value: false);
			MissionTexts[2].SetActive(value: false);
			MissionTexts[3].SetActive(value: false);
			MissionTexts[4].SetActive(value: false);
			MissionTexts[5].SetActive(value: false);
			MissionTexts[6].SetActive(value: false);
		}
		else if (LevelSelectionDemo.instance.currentLevel >= 4 && LevelSelectionDemo.instance.currentLevel <= 6)
		{
			MissionTexts[0].SetActive(value: false);
			MissionTexts[1].SetActive(value: true);
			MissionTexts[2].SetActive(value: false);
			MissionTexts[3].SetActive(value: false);
			MissionTexts[4].SetActive(value: false);
			MissionTexts[5].SetActive(value: false);
			MissionTexts[6].SetActive(value: false);
		}
		else if (LevelSelectionDemo.instance.currentLevel >= 7 && LevelSelectionDemo.instance.currentLevel <= 8)
		{
			MissionTexts[0].SetActive(value: false);
			MissionTexts[1].SetActive(value: false);
			MissionTexts[2].SetActive(value: true);
			MissionTexts[3].SetActive(value: false);
			MissionTexts[4].SetActive(value: false);
			MissionTexts[5].SetActive(value: false);
			MissionTexts[6].SetActive(value: false);
		}
		else if (LevelSelectionDemo.instance.currentLevel >= 9 && LevelSelectionDemo.instance.currentLevel <= 10)
		{
			MissionTexts[0].SetActive(value: false);
			MissionTexts[1].SetActive(value: false);
			MissionTexts[2].SetActive(value: false);
			MissionTexts[3].SetActive(value: true);
			MissionTexts[4].SetActive(value: false);
			MissionTexts[5].SetActive(value: false);
			MissionTexts[6].SetActive(value: false);
		}
		else if (LevelSelectionDemo.instance.currentLevel >= 11 && LevelSelectionDemo.instance.currentLevel <= 14)
		{
			MissionTexts[0].SetActive(value: false);
			MissionTexts[1].SetActive(value: false);
			MissionTexts[2].SetActive(value: false);
			MissionTexts[3].SetActive(value: false);
			MissionTexts[4].SetActive(value: true);
			MissionTexts[5].SetActive(value: false);
			MissionTexts[6].SetActive(value: false);
		}
		else if (LevelSelectionDemo.instance.currentLevel >= 15 && LevelSelectionDemo.instance.currentLevel <= 18)
		{
			MissionTexts[0].SetActive(value: false);
			MissionTexts[1].SetActive(value: false);
			MissionTexts[2].SetActive(value: false);
			MissionTexts[3].SetActive(value: false);
			MissionTexts[4].SetActive(value: false);
			MissionTexts[5].SetActive(value: true);
			MissionTexts[6].SetActive(value: false);
		}
		else if (LevelSelectionDemo.instance.currentLevel >= 19 && LevelSelectionDemo.instance.currentLevel <= 20)
		{
			MissionTexts[0].SetActive(value: false);
			MissionTexts[1].SetActive(value: false);
			MissionTexts[2].SetActive(value: false);
			MissionTexts[3].SetActive(value: false);
			MissionTexts[4].SetActive(value: false);
			MissionTexts[5].SetActive(value: false);
			MissionTexts[6].SetActive(value: true);
		}
		LevelNmbr.text = LevelSelectionDemo.instance.currentLevel.ToString();
		gareButton.image.sprite = GareChangeSprite[0];
		BusesToEnable[PlayerPrefs.GetInt("SelectedPlayer")].SetActive(value: true);
		playerNew = GameObject.FindGameObjectWithTag("Player").transform;
		InteriorImage.SetActive(value: false);
		Invoke("ExtraCube", 2f);
		if (!levelDescriptionPanel)
		{
			showGameplay();
		}
		else
		{
			ShowLevelDescription();
		}
		if (LevelSelectionDemo.instance.currentLevel == 1)
		{
			levelsdata.transform.GetChild(0).gameObject.SetActive(value: true);
		}
		else if (LevelSelectionDemo.instance.currentLevel == 2)
		{
			levelsdata.transform.GetChild(1).gameObject.SetActive(value: true);
			levelsdata.transform.GetChild(0).gameObject.SetActive(value: false);
			playerNew.transform.position = playerPositions.transform.GetChild(1).transform.position;
			playerNew.transform.rotation = playerPositions.transform.GetChild(1).transform.rotation;
		}
		else if (LevelSelectionDemo.instance.currentLevel == 3)
		{
			levelsdata.transform.GetChild(0).gameObject.SetActive(value: false);
			levelsdata.transform.GetChild(2).gameObject.SetActive(value: true);
			playerNew.transform.position = playerPositions.transform.GetChild(1).transform.position;
			playerNew.transform.rotation = playerPositions.transform.GetChild(1).transform.rotation;
		}
		else if (LevelSelectionDemo.instance.currentLevel == 4)
		{
			levelsdata.transform.GetChild(0).gameObject.SetActive(value: false);
			levelsdata.transform.GetChild(3).gameObject.SetActive(value: true);
			playerNew.transform.position = playerPositions.transform.GetChild(2).transform.position;
			playerNew.transform.rotation = playerPositions.transform.GetChild(2).transform.rotation;
		}
		else if (LevelSelectionDemo.instance.currentLevel == 5)
		{
			levelsdata.transform.GetChild(0).gameObject.SetActive(value: false);
			levelsdata.transform.GetChild(4).gameObject.SetActive(value: true);
			playerNew.transform.position = playerPositions.transform.GetChild(2).transform.position;
			playerNew.transform.rotation = playerPositions.transform.GetChild(2).transform.rotation;
		}
		else if (LevelSelectionDemo.instance.currentLevel == 6)
		{
			levelsdata.transform.GetChild(0).gameObject.SetActive(value: false);
			levelsdata.transform.GetChild(5).gameObject.SetActive(value: true);
			playerNew.transform.position = playerPositions.transform.GetChild(4).transform.position;
			playerNew.transform.rotation = playerPositions.transform.GetChild(4).transform.rotation;
		}
		else if (LevelSelectionDemo.instance.currentLevel == 7)
		{
			levelsdata.transform.GetChild(0).gameObject.SetActive(value: false);
			levelsdata.transform.GetChild(6).gameObject.SetActive(value: true);
			playerNew.transform.position = playerPositions.transform.GetChild(5).transform.position;
			playerNew.transform.rotation = playerPositions.transform.GetChild(5).transform.rotation;
		}
		else if (LevelSelectionDemo.instance.currentLevel == 8)
		{
			levelsdata.transform.GetChild(0).gameObject.SetActive(value: false);
			levelsdata.transform.GetChild(7).gameObject.SetActive(value: true);
			playerNew.transform.position = playerPositions.transform.GetChild(6).transform.position;
			playerNew.transform.rotation = playerPositions.transform.GetChild(6).transform.rotation;
		}
		else if (LevelSelectionDemo.instance.currentLevel == 9)
		{
			levelsdata.transform.GetChild(0).gameObject.SetActive(value: false);
			levelsdata.transform.GetChild(8).gameObject.SetActive(value: true);
			playerNew.transform.position = playerPositions.transform.GetChild(7).transform.position;
		}
		else if (LevelSelectionDemo.instance.currentLevel == 10)
		{
			levelsdata.transform.GetChild(0).gameObject.SetActive(value: false);
			levelsdata.transform.GetChild(9).gameObject.SetActive(value: true);
			playerNew.transform.position = playerPositions.transform.GetChild(5).transform.position;
		}
		else if (LevelSelectionDemo.instance.currentLevel == 11)
		{
			levelsdata.transform.GetChild(0).gameObject.SetActive(value: false);
			levelsdata.transform.GetChild(10).gameObject.SetActive(value: true);
			playerNew.transform.position = playerPositions.transform.GetChild(6).transform.position;
		}
		else if (LevelSelectionDemo.instance.currentLevel == 12)
		{
			levelsdata.transform.GetChild(0).gameObject.SetActive(value: false);
			levelsdata.transform.GetChild(11).gameObject.SetActive(value: true);
			playerNew.transform.position = playerPositions.transform.GetChild(5).transform.position;
			playerNew.transform.rotation = playerPositions.transform.GetChild(5).transform.rotation;
		}
		else if (LevelSelectionDemo.instance.currentLevel == 13)
		{
			levelsdata.transform.GetChild(0).gameObject.SetActive(value: false);
			levelsdata.transform.GetChild(12).gameObject.SetActive(value: true);
			playerNew.transform.position = playerPositions.transform.GetChild(10).transform.position;
			playerNew.transform.rotation = playerPositions.transform.GetChild(10).transform.rotation;
		}
		else if (LevelSelectionDemo.instance.currentLevel == 14)
		{
			levelsdata.transform.GetChild(0).gameObject.SetActive(value: false);
			levelsdata.transform.GetChild(13).gameObject.SetActive(value: true);
		}
		else if (LevelSelectionDemo.instance.currentLevel == 15)
		{
			levelsdata.transform.GetChild(0).gameObject.SetActive(value: false);
			levelsdata.transform.GetChild(14).gameObject.SetActive(value: true);
		}
		else if (LevelSelectionDemo.instance.currentLevel == 16)
		{
			levelsdata.transform.GetChild(0).gameObject.SetActive(value: false);
			levelsdata.transform.GetChild(15).gameObject.SetActive(value: true);
		}
		else if (LevelSelectionDemo.instance.currentLevel == 17)
		{
			levelsdata.transform.GetChild(0).gameObject.SetActive(value: false);
			levelsdata.transform.GetChild(16).gameObject.SetActive(value: true);
			playerNew.transform.position = playerPositions.transform.GetChild(12).transform.position;
			playerNew.transform.rotation = playerPositions.transform.GetChild(12).transform.rotation;
		}
		else if (LevelSelectionDemo.instance.currentLevel == 18)
		{
			levelsdata.transform.GetChild(0).gameObject.SetActive(value: false);
			levelsdata.transform.GetChild(17).gameObject.SetActive(value: true);
			playerNew.transform.position = playerPositions.transform.GetChild(13).transform.position;
		}
		else if (LevelSelectionDemo.instance.currentLevel == 19)
		{
			levelsdata.transform.GetChild(0).gameObject.SetActive(value: false);
			levelsdata.transform.GetChild(18).gameObject.SetActive(value: true);
			playerNew.transform.position = playerPositions.transform.GetChild(14).transform.position;
			playerNew.transform.rotation = playerPositions.transform.GetChild(14).transform.rotation;
		}
		else if (LevelSelectionDemo.instance.currentLevel == 20)
		{
			levelsdata.transform.GetChild(0).gameObject.SetActive(value: false);
			levelsdata.transform.GetChild(19).gameObject.SetActive(value: true);
			playerNew.transform.position = playerPositions.transform.GetChild(14).transform.position;
			playerNew.transform.rotation = playerPositions.transform.GetChild(14).transform.rotation;
		}
		if (playerNew.name != "BUS")
		{
			CameraButtons[0].SetActive(value: true);
			CameraButtons[1].SetActive(value: false);
		}
		else
		{
			CameraButtons[0].SetActive(value: false);
			CameraButtons[1].SetActive(value: true);
		}
		//AdsManager.Instance.hideBanner2();
		//AdsManager.Instance.hideBanner();
	}

	public void Star1()
	{
		Starfill1.SetActive(value: true);
		Starfill2.SetActive(value: false);
		Starfill3.SetActive(value: false);
		Starfill4.SetActive(value: false);
		Starfill5.SetActive(value: false);
	}

	public void Star2()
	{
		Starfill1.SetActive(value: true);
		Starfill2.SetActive(value: true);
		Starfill3.SetActive(value: false);
		Starfill4.SetActive(value: false);
		Starfill5.SetActive(value: false);
	}

	public void Star3()
	{
		MonoBehaviour.print("3");
		Starfill1.SetActive(value: true);
		Starfill2.SetActive(value: true);
		Starfill3.SetActive(value: true);
		Starfill4.SetActive(value: false);
		Starfill5.SetActive(value: false);
	}

	public void Star4()
	{
		MonoBehaviour.print("4");
		Starfill1.SetActive(value: true);
		Starfill2.SetActive(value: true);
		Starfill3.SetActive(value: true);
		Starfill4.SetActive(value: true);
		Starfill5.SetActive(value: false);
	}

	public void Star5()
	{
		Starfill1.SetActive(value: true);
		Starfill2.SetActive(value: true);
		Starfill3.SetActive(value: true);
		Starfill4.SetActive(value: true);
		Starfill5.SetActive(value: true);
	}

	public void EmailUs()
	{
		string text = "crownapps94@gmail.com";
		string text2 = MyEscapeURL("FEEDBACK/SUGGESTION");
		string text3 = MyEscapeURL("Please Enter your message here\n\n\n\n________\n\nPlease Do Not Modify This\n\nModel: " + SystemInfo.deviceModel + "\n\nOS: " + SystemInfo.operatingSystem + "\n\n________");
		Application.OpenURL("mailto:" + text + "?subject=" + text2 + "&body=" + text3);
	}

	private string MyEscapeURL(string url)
	{
		return WWW.EscapeURL(url).Replace("+", "%20");
	}

	public void Thansks()
	{
		ThanksBtn.SetActive(value: true);
		RateUsBtn.SetActive(value: false);
	}

	public void RateUs()
	{
		ThanksBtn.SetActive(value: false);
		RateUsBtn.SetActive(value: true);
	}

	public void ThanksFtn()
	{
		RateUSPanel.SetActive(value: false);
		EmailUs();
		Completed();
	}

	public void RateFtn()
	{
		Application.OpenURL("https://play.google.com/store/apps/details?id=com.city.coach.bus.simulator.drive");
		RateUSPanel.SetActive(value: false);
		Completed();
	}

	public void WatchVideo1()
	{
		StartCoroutine("loadingVideo_text");
		//AdsManager.Instance.ShowRewardedUnityADS();
	}

	private IEnumerator loadingVideo_text()
	{
		if (PlayerPrefs.GetInt("SetText") == 1)
		{
			PlayerPrefs.SetInt("SetText", 0);
			set_loading_text(loading_text, string.Empty);
			yield break;
		}
		float i = 0f;
		while (i <= 50f)
		{
			i += 1f;
			if (i == 1f)
			{
				set_loading_text(loading_text, "Loading");
			}
			else if (i == 4f)
			{
				set_loading_text(loading_text, "Loading.");
			}
			else if (i == 7f)
			{
				set_loading_text(loading_text, "Loading..");
			}
			else if (i == 10f)
			{
				set_loading_text(loading_text, "Loading...");
			}
			else if (i == 13f)
			{
				set_loading_text(loading_text, "Loading");
			}
			else if (i == 16f)
			{
				set_loading_text(loading_text, "Loading.");
			}
			else if (i == 19f)
			{
				set_loading_text(loading_text, "Loading..");
			}
			else if (i == 22f)
			{
				set_loading_text(loading_text, "Loading...");
			}
			else if (i == 25f)
			{
				set_loading_text(loading_text, "Loading");
			}
			else if (i == 28f)
			{
				set_loading_text(loading_text, "Loading.");
			}
			else if (i == 31f)
			{
				set_loading_text(loading_text, "Loading..");
			}
			else if (i == 34f)
			{
				set_loading_text(loading_text, "Loading...");
			}
			else if (i == 37f)
			{
				set_loading_text(loading_text, "Video Not Found!");
			}
			else if (i == 50f)
			{
				set_loading_text(loading_text, string.Empty);
			}
			yield return new WaitForSeconds(0f);
		}
		StopAllCoroutines();
	}

	private void set_loading_text(Text tex, string st)
	{
		if (tex.gameObject.activeInHierarchy)
		{
			tex.text = st;
		}
	}

	private IEnumerator loadingVideo_text_To_Next()
	{
		float i = 0f;
		while (i <= 50f)
		{
			i += 1f;
			if (i == 1f)
			{
				set_loading_text_To_Next(loadingVideotextToNext, "Loading");
			}
			else if (i == 4f)
			{
				set_loading_text_To_Next(loadingVideotextToNext, "Loading.");
			}
			else if (i == 7f)
			{
				set_loading_text_To_Next(loadingVideotextToNext, "Loading..");
			}
			else if (i == 10f)
			{
				set_loading_text_To_Next(loadingVideotextToNext, "Loading...");
			}
			else if (i == 13f)
			{
				set_loading_text_To_Next(loadingVideotextToNext, "Loading");
			}
			else if (i == 16f)
			{
				set_loading_text_To_Next(loadingVideotextToNext, "Loading.");
			}
			else if (i == 19f)
			{
				set_loading_text_To_Next(loadingVideotextToNext, "Loading..");
			}
			else if (i == 22f)
			{
				set_loading_text_To_Next(loadingVideotextToNext, "Loading...");
			}
			else if (i == 25f)
			{
				set_loading_text_To_Next(loadingVideotextToNext, "Loading");
			}
			else if (i == 28f)
			{
				set_loading_text_To_Next(loadingVideotextToNext, "Loading.");
			}
			else if (i == 31f)
			{
				set_loading_text_To_Next(loadingVideotextToNext, "Loading..");
			}
			else if (i == 34f)
			{
				set_loading_text_To_Next(loadingVideotextToNext, "Loading...");
			}
			else if (i == 37f)
			{
				set_loading_text_To_Next(loadingVideotextToNext, "Video Not Found!");
			}
			else if (i == 50f)
			{
				set_loading_text_To_Next(loadingVideotextToNext, string.Empty);
			}
			yield return new WaitForSeconds(0f);
		}
		StopAllCoroutines();
	}

	private void set_loading_text_To_Next(Text tex, string st)
	{
		if (tex.gameObject.activeInHierarchy)
		{
			tex.text = st;
		}
	}

	private void Update()
	{
		if (Input.GetKeyDown(KeyCode.Escape))
		{
			if (isGamePlay)
			{
				showPause();
			}
			else if (isPause || isLevelDescription)
			{
				showGameplay();
			}
		}
		if (Input.touchCount > 0 && enginePanel.activeSelf)
		{
			enginePanel.SetActive(value: false);
		}
		if (RCC_CarControllerV3.instance.speed > 5f && !PassengerTrigger.RefuelBool)
		{
			if (LevelSelectionDemo.instance.currentLevel <= 15)
			{
				fuelImage.fillAmount -= 0.00357142859f * Time.deltaTime;
			}
			else
			{
				fuelImage.fillAmount -= 0.00357142859f * Time.deltaTime;
			}
		}
		if ((double)fuelImage.fillAmount < 0.3)
		{
			if (Refuel)
			{
				Refuel = false;
			}
			fuelImage.color = Color.red;
			if (RefuelMsgBool)
			{
				RefuelMsgBool = false;
				StartCoroutine("showRefuelMsg");
				StartCoroutine("showReminder");
			}
			watchVideoBtn.SetActive(value: true);
		}
		if ((double)fuelImage.fillAmount > 0.3)
		{
			fuelImage.color = Color.white;
			watchVideoBtn.SetActive(value: false);
		}
		if ((double)fuelImage.fillAmount >= 0.9)
		{
			fuelImage.color = Color.green;
		}
		if (fuelImage.fillAmount == 0f && !LevelFailBool)
		{
			LevelFailBool = true;
			showLevelFailed();
		}
	}

	public void ChangeCamera()
	{
	}

	public void SetGearValuetoReverse()
	{
		PlayerPrefs.SetInt("gearValue", 1);
	}

	private IEnumerator showReminder()
	{
		WatchToRefuelReminder.SetActive(value: true);
		yield return new WaitForSecondsRealtime(3f);
		WatchToRefuelReminder.SetActive(value: false);
	}

	private IEnumerator showRefuelMsg()
	{
		RefuelText.SetActive(value: true);
		yield return new WaitForSeconds(3f);
		RefuelText.SetActive(value: false);
	}

	public void showGameplay()
	{
		SetActivePanel(isgamply: true);
		TimeScale(1f);
		//AdsManager.Instance.hideRectBanner();
		//AdsManager.Instance.hideBanner();
	}

	public void showLoading()
	{
		SetActivePanel(isgamply: false, ispause: false, islevelDescription: false, islevelcomplete: false, islevelfailed: false, isloading: true);
		//if (PlayerPrefs.GetInt("RemoveAds") == 0)
		//{
		//	//AdsManager.Instance.ShowInterstitail();
		//}
	}

	public void showPause()
	{
		RCC_CarControllerV3.instance.OffBusSounds();
		if (enginePanel.activeInHierarchy)
		{
			return;
		}
		SetActivePanel(isgamply: false, ispause: true);
		TimeScale(ZeroTime);
		//if (PlayerPrefs.GetInt("RemoveAds") == 0)
		//{
		//	if (PlayerPrefs.GetInt("declined") == 0)
		//	{
		//		AdsManager.Instance.showRectBanner();
		//	}
		//	AdsManager.Instance.showUnityAdmob();
		//}
	}

	public void showlevelComplete()
	{
		TimeScale(ZeroTime);
		if (LevelSelectionDemo.instance.currentLevel >= PlayerPrefs.GetInt("levels") && LevelSelectionDemo.instance.currentLevel < 21)
		{
			PlayerPrefs.SetInt("levels", LevelSelectionDemo.instance.currentLevel);
		}
		PlayerPrefs.SetInt("TotalCash", PlayerPrefs.GetInt("TotalCash") + 5000);
		if (LevelSelectionDemo.instance.currentLevel % 5 == 0)
		{
			RateUSPanel.SetActive(value: true);
			return;
		}
		SetActivePanel(isgamply: false, ispause: false, islevelDescription: false, islevelcomplete: true);
		//if (PlayerPrefs.GetInt("RemoveAds") == 0)
		//{
		//	if (PlayerPrefs.GetInt("declined") == 0)
		//	{
		//		AdsManager.Instance.showRectBanner();
		//	}
		//	AdsManager.Instance.showUnityAdmob();
		//}
	}

	private void Completed()
	{
		SetActivePanel(isgamply: false, ispause: false, islevelDescription: false, islevelcomplete: true);
		//if (PlayerPrefs.GetInt("RemoveAds") == 0)
		//{
		//	if (PlayerPrefs.GetInt("declined") == 0)
		//	{
		//		AdsManager.Instance.showRectBanner();
		//	}
		//	AdsManager.Instance.showUnityAdmob();
		//}
	}

	public void showLevelFailed()
	{
		RCC_CarControllerV3.instance.OffBusSounds();
		SetActivePanel(isgamply: false, ispause: false, islevelDescription: false, islevelcomplete: false, islevelfailed: true);
		TimeScale(ZeroTime);
		//if (PlayerPrefs.GetInt("RemoveAds") == 0)
		//{
		//	if (PlayerPrefs.GetInt("declined") == 0)
		//	{
		//		AdsManager.Instance.showRectBanner();
		//	}
		//	AdsManager.Instance.showUnityAdmob();
		//}
	}

	public void ShowLevelDescription()
	{
		SetActivePanel(isgamply: false, ispause: false, islevelDescription: true);
		Time.timeScale = 1f;
	}

	public void watchVideo()
	{
		SetActivePanel(isgamply: false, ispause: false, islevelDescription: false, islevelcomplete: false, islevelfailed: false, isloading: false, iswatchvideo: true);
		TimeScale(ZeroTime);
	}

	public void OnClickHome()
	{
		if (!loadMenu)
		{
			loadMenu = true;
			if (PlayerPrefs.GetInt("music") == 0)
			{
				AudioListener.pause = false;
			}
			PlayerPrefs.SetInt("isLevelSelection1", 1);
			PlayerPrefs.Save();
			LoadLevelAsync("Menu");
			//AdsManager.Instance.hideRectBanner();
		}
	}

	public void OnClickPause()
	{
		showPause();
	}

	public void OnClickResume()
	{
		showGameplay();
	}

	public void OnClickNext()
	{
		if (!ClickNextBool)
		{
			ClickNextBool = true;
			PlayerPrefs.SetInt("isLevelSelection", 1);
			LoadLevelAsync("Menu");
			//AdsManager.Instance.hideRectBanner();
		}
	}

	public void MoveOnWatchVideoToUnlockLvl()
	{
		if (LevelSelectionDemo.instance.currentLevel >= PlayerPrefs.GetInt("levels") && LevelSelectionDemo.instance.currentLevel < 21)
		{
			PlayerPrefs.SetInt("levels", LevelSelectionDemo.instance.currentLevel);
		}
		PlayerPrefs.SetInt("TotalCash", PlayerPrefs.GetInt("TotalCash") + 5000);
		PlayerPrefs.SetInt("isLevelSelection1", 1);
		LoadLevelAsync("Menu");
	}

	public void OnClickRestart()
	{
		Application.LoadLevel(Application.loadedLevel);
		TimeScale(1f);
		//AdsManager.Instance.hideRectBanner();
	}

	public void OnClickOK()
	{
		enginePanel.SetActive(value: true);
		showGameplay();
	}

	public void OnClickOKk()
	{
		showGameplay();
		PassengerTrigger.instance.warmingPanel.SetActive(value: false);
		enginePanel.SetActive(value: false);
	}

	private void SetActivePanel(bool isgamply = false, bool ispause = false, bool islevelDescription = false, bool islevelcomplete = false, bool islevelfailed = false, bool isloading = false, bool iswatchvideo = false)
	{
		GamePlayPanel.SetActive(isgamply);
		isGamePlay = isgamply;
		PausePanel.SetActive(ispause);
		isPause = ispause;
		levelDescriptionPanel.SetActive(islevelDescription);
		isLevelDescription = islevelDescription;
		levelCompletePanel.SetActive(islevelcomplete);
		levelFailedPanel.SetActive(islevelfailed);
		loadingPanel.SetActive(isloading);
		WatchVideoPanel.SetActive(iswatchvideo);
	}

	private void TimeScale(float value)
	{
		Time.timeScale = value;
	}

	private void LoadLevelAsync(string LevelName)
	{
		ALLOperation = Application.LoadLevelAsync(LevelName);
	}

	public void pausee()
	{
		showPause();
		GamePlayPanel.SetActive(value: false);
		Time.timeScale = 0.001f;
	}

	public void ExtraCube()
	{
		triggercube.SetActive(value: true);
	}

	public void ButtonsControl(string btnName)
	{
		switch (btnName)
		{
		case "control":
			control.transform.parent.gameObject.GetComponent<Animator>().SetBool("onOff", !control.transform.parent.gameObject.GetComponent<Animator>().GetBool("onOff"));
			break;
		case "steer":
			PlayerPrefs.SetInt("tiltMode", 0);
			PlayerPrefs.SetInt("SteerMode", 1);
			PlayerPrefs.SetInt("ButtonMode", 0);
			RCC_Settings.instance.useAccelerometerForSteering = false;
			RCC_Settings.instance.useSteeringWheelForSteering = true;
			control.transform.parent.gameObject.GetComponent<Animator>().SetBool("onOff", !control.transform.parent.gameObject.GetComponent<Animator>().GetBool("onOff"));
			HornButtons[0].SetActive(value: true);
			HornButtons[1].SetActive(value: false);
			HornButtons[2].SetActive(value: false);
			break;
		case "button":
			PlayerPrefs.SetInt("tiltMode", 0);
			PlayerPrefs.SetInt("SteerMode", 0);
			PlayerPrefs.SetInt("ButtonMode", 1);
			RCC_Settings.instance.useAccelerometerForSteering = false;
			RCC_Settings.instance.useSteeringWheelForSteering = false;
			control.transform.parent.gameObject.GetComponent<Animator>().SetBool("onOff", !control.transform.parent.gameObject.GetComponent<Animator>().GetBool("onOff"));
			HornButtons[0].SetActive(value: false);
			HornButtons[1].SetActive(value: true);
			HornButtons[2].SetActive(value: false);
			break;
		case "tilt":
			PlayerPrefs.SetInt("tiltMode", 1);
			PlayerPrefs.SetInt("SteerMode", 0);
			PlayerPrefs.SetInt("ButtonMode", 0);
			RCC_Settings.instance.useAccelerometerForSteering = true;
			RCC_Settings.instance.useSteeringWheelForSteering = false;
			control.transform.parent.gameObject.GetComponent<Animator>().SetBool("onOff", !control.transform.parent.gameObject.GetComponent<Animator>().GetBool("onOff"));
			HornButtons[0].SetActive(value: false);
			HornButtons[1].SetActive(value: false);
			HornButtons[2].SetActive(value: true);
			break;
		}
	}

	public void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.tag == "water")
		{
			showLevelFailed();
		}
		if (other.gameObject.tag == "people")
		{
			showLevelFailed();
		}
	}

	public void OnClickRateUs()
	{
		Application.OpenURL("https://play.google.com/store/apps/details?id=com.city.coach.bus.simulator.drive");
	}
}
