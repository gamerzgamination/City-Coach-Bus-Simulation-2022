using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class MenuManager : MonoBehaviour
{
	public static MenuManager instance;

	[Header("Panels")]
	public GameObject MenuPanel;

	[Header("Panels")]
	public GameObject UnlockLevelsPanel;

	[Header("Panels")]
	public GameObject UnlockVehiclesPanel;

	[Header("Panels")]
	public GameObject DummyLoading;

	public GameObject LevelSelectionPanel;

	public GameObject QuitPanel;

	public GameObject LoadingPanel;

	public GameObject StorePanel;

	public GameObject SettingPanel;

	public GameObject MainCam;

	public GameObject StoreCam;

	private int counter;

	[Header("Settings")]
	public Image Musicbtn;

	public Image Soundbtn;

	public Sprite[] MusicSoundOnOff;

	public bool isMusic;

	[Header("Store")]
	public GameObject StoreElements;

	private AsyncOperation asyncLoader;

	private void Awake()
	{
		instance = this;
	}

	private void Start()
	{
		//AdsManager.Instance.hideBanner();
		//AdsManager.Instance.hideRectBanner();
		//if (PlayerPrefs.GetInt("RemoveAds") == 0)
		//{
		//	AdsManager.Instance.showBanner();
		//}
		if (Time.timeScale != 1f)
		{
			Time.timeScale = 1f;
		}
		if (!PlayerPrefs.HasKey("music"))
		{
			PlayerPrefs.SetInt("music", 0);
		}
		if (PlayerPrefs.GetInt("music") == 0)
		{
			isMusic = true;
			Musicbtn.sprite = MusicSoundOnOff[0];
			AudioListener.pause = false;
		}
		else if (PlayerPrefs.GetInt("music") == 1)
		{
			isMusic = false;
			Musicbtn.sprite = MusicSoundOnOff[1];
			AudioListener.pause = true;
		}
		if (!PlayerPrefs.HasKey("isLevelSelection"))
		{
			PlayerPrefs.SetInt("isLevelSelection", 0);
		}
		if (!PlayerPrefs.HasKey("isLevelSelection1"))
		{
			PlayerPrefs.SetInt("isLevelSelection1", 0);
		}
		if (PlayerPrefs.GetInt("isLevelSelection") == 1)
		{
			//AdsManager.Instance.hideBanner();
			//if (PlayerPrefs.GetInt("RemoveAds") == 0)
			//{
			//	AdsManager.Instance.showBanner2();
			//}
			ShowLevelSelection2();
			PlayerPrefs.SetInt("isLevelSelection", 0);
		}
		if (PlayerPrefs.GetInt("isLevelSelection1") == 1)
		{
			//AdsManager.Instance.hideBanner();
			//if (PlayerPrefs.GetInt("RemoveAds") == 0)
			//{
			//	AdsManager.Instance.showBanner2();
			//}
			ShowLevelSelection2();
			PlayerPrefs.SetInt("isLevelSelection1", 0);
		}
	}

	private void Update()
	{
		if (Input.GetKeyDown(KeyCode.Escape))
		{
			if (MenuPanel.activeSelf)
			{
				ShowQuit();
			}
			else if (QuitPanel.activeSelf || SettingPanel.activeSelf)
			{
				ShowMenu();
			}
			else if (Object.FindObjectOfType<StoreManager>()._DialoguePanel.gameObject.activeSelf)
			{
				Object.FindObjectOfType<StoreManager>()._DialoguePanel.gameObject.SetActive(value: false);
			}
		}
	}

	public void WatchVideo()
	{
	}

	public void ShowMenu()
	{
		ShowStore();
		PanelActivity(isMenu: true);
		Time.timeScale = 1f;
		//if (PlayerPrefs.GetInt("RemoveAds") == 0)
		//{
		//	AdsManager.Instance.hideRectBanner();
		//	AdsManager.Instance.showBanner();
		//}
	}

	public void ShowQuit()
	{
		if (QuitPanel.activeSelf)
		{
			return;
		}
		PanelActivity(isMenu: false, isSetting: false, isLevelSelect: false, isQuit: true);
		Time.timeScale = 0f;
		//if (PlayerPrefs.GetInt("RemoveAds") == 0)
		//{
		//	if (PlayerPrefs.GetInt("declined") == 0)
		//	{
		//		AdsManager.Instance.showRectBanner();
		//	}
		//	AdsManager.Instance.hideBanner();
		//	AdsManager.Instance.showUnityAdmob();
		//}
	}

	public void OnClickSetting()
	{
		PanelActivity(isMenu: false, isSetting: true);
	}

	public void OnclickPlay()
	{
		MainCam.SetActive(value: false);
		StoreCam.SetActive(value: true);
		DummyLoading.SetActive(value: true);
		Invoke("OpenUnlockLevels", 3f);
		ShowLevelSelection();
	}

	public void CloseUnlockLevels()
	{
		counter++;
		if (counter >= 2)
		{
			UnlockLevelsPanel.SetActive(value: false);
			Invoke("CloseLoading", 3f);
			counter = 0;
		}
	}

	public void CloseUnlockVehicles()
	{
		counter++;
		if (counter >= 2)
		{
			UnlockVehiclesPanel.SetActive(value: false);
			Invoke("CloseLoading", 3f);
			counter = 0;
		}
	}

	private void CloseLoading()
	{
		DummyLoading.SetActive(value: false);
		if (LevelSelectionPanel.activeInHierarchy)
		{
			//AdsManager.Instance.hideBanner();
			//if (PlayerPrefs.GetInt("RemoveAds") == 0)
			//{
			//	AdsManager.Instance.showBanner2();
			//}
		}
	}

	private void OpenUnlockLevels()
	{
		UnlockLevelsPanel.SetActive(value: true);
	}

	private void OpenUnlockVehicles()
	{
		UnlockVehiclesPanel.SetActive(value: true);
	}

	public void OnclickStore()
	{
		MainCam.SetActive(value: false);
		StoreCam.SetActive(value: true);
		DummyLoading.SetActive(value: true);
		Invoke("OpenUnlockVehicles", 3f);
		ShowStore(isTrue: true);
		PanelActivity(isMenu: false, isSetting: false, isLevelSelect: false, isQuit: false, isLoading: false, isStore: true);
		MainCam.SetActive(value: false);
		StoreManager.instance.StoreObjects.SetActive(value: true);
		//AdsManager.Instance.hideBanner();
	}

	public void HidesStore()
	{
		ShowStore();
		MainCam.SetActive(value: true);
	}

	public void OnClickYES()
	{
		Application.Quit();
	}

	public void OnClickNO()
	{
		ShowMenu();
	}

	public void Sound()
	{
		isMusic = !isMusic;
		if (isMusic)
		{
			PlayerPrefs.SetInt("music", 0);
			AudioListener.pause = false;
			Musicbtn.sprite = MusicSoundOnOff[0];
		}
		else
		{
			PlayerPrefs.SetInt("music", 1);
			AudioListener.pause = true;
			Musicbtn.sprite = MusicSoundOnOff[1];
		}
	}

	public void OnClickShare()
	{
		SocialNetworks.ShareURL("City Coach Bus Simulator 2019", "https://play.google.com/store/apps/details?id=com.city.coach.bus.simulator.drive");
	}

	public void OnClickMoreGames()
	{
	}

	public void OnClickRateUs()
	{
		Application.OpenURL("https://play.google.com/store/apps/details?id=com.city.coach.bus.simulator.drive");
	}

	public void ShowStore(bool isTrue = false)
	{
		StoreElements.SetActive(isTrue);
		StoreManager.instance.delay();
		if (isTrue && Object.FindObjectOfType<StoreManager>()._DialoguePanel.gameObject.activeSelf)
		{
			Object.FindObjectOfType<StoreManager>()._DialoguePanel.gameObject.SetActive(value: false);
		}
	}

	public void ShowLevelSelection()
	{
		PanelActivity(isMenu: false, isSetting: false, isLevelSelect: true);
	}

	public void ShowLevelSelection2()
	{
		PanelActivity(isMenu: false, isSetting: false, isLevelSelect: true);
	}

	public void PanelActivity(bool isMenu = false, bool isSetting = false, bool isLevelSelect = false, bool isQuit = false, bool isLoading = false, bool isStore = false)
	{
		MenuPanel.SetActive(isMenu);
		LevelSelectionPanel.SetActive(isLevelSelect);
		SettingPanel.SetActive(isSetting);
		QuitPanel.SetActive(isQuit);
		LoadingPanel.SetActive(isLoading);
		StorePanel.SetActive(isStore);
	}

	private void StartLoading()
	{
		PanelActivity(isMenu: true);
	}

	public void LoadGamePlay()
	{
		PanelActivity(isMenu: false, isSetting: false, isLevelSelect: false, isQuit: false, isLoading: true);
		Invoke("loadlevelMain", 4f);
		//if (PlayerPrefs.GetInt("RemoveAds") == 0)
		//{
		//	AdsManager.Instance.ShowInterstitail();
		//}
	}

	private void loadlevelMain()
	{
		asyncLoader = SceneManager.LoadSceneAsync("GamePlay");
	}
}
