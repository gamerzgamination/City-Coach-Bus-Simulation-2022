using UnityEngine;
using UnityEngine.UI;

public class LevelSelectionDemo : MonoBehaviour
{
	public int currentLevel;

	public static LevelSelectionDemo instance;

	public GameObject levelpanel;

	public Image Selector;

	public Button[] btn;

	public GameObject[] Selectors;

	public GameObject NextBtn;

	private void Awake()
	{
		instance = this;
		if (!PlayerPrefs.HasKey("CurrentLevel"))
		{
			PlayerPrefs.SetInt("CurrentLevel", 1);
		}
		if (!PlayerPrefs.HasKey("levels"))
		{
			PlayerPrefs.SetInt("levels", 0);
		}
	}

	private void Start()
	{
		NextBtn.GetComponent<Animator>().enabled = false;
		currentLevel = 1;
		for (int i = 0; i <= PlayerPrefs.GetInt("levels"); i++)
		{
			levelpanel.transform.GetChild(i).GetComponent<Button>().interactable = true;
		}
		PlayerPrefs.SetInt("CurrentLevel", 1);
	}

	public void onClickBack()
	{
		//AdsManager.Instance.hideBanner2();
		GetComponent<MenuManager>().ShowMenu();
	}

	public void OnClickNext()
	{
		MenuManager.instance.OnclickStore();
		//AdsManager.Instance.hideBanner2();
	}

	public void levelSelection(int level)
	{
		currentLevel = level;
		if (level == 1)
		{
			SelectorActive(isLevel: true);
		}
		if (level == 2)
		{
			SelectorActive(isLevel: false, isLevel2: true);
		}
		if (level == 3)
		{
			SelectorActive(isLevel: false, isLevel2: false, isLevel3: true);
		}
		if (level == 4)
		{
			SelectorActive(isLevel: false, isLevel2: false, isLevel3: false, isLevel4: true);
		}
		if (level == 5)
		{
			SelectorActive(isLevel: false, isLevel2: false, isLevel3: false, isLevel4: false, isLevel5: true);
		}
		if (level == 6)
		{
			SelectorActive(isLevel: false, isLevel2: false, isLevel3: false, isLevel4: false, isLevel5: false, isLevel6: true);
		}
		if (level == 7)
		{
			SelectorActive(isLevel: false, isLevel2: false, isLevel3: false, isLevel4: false, isLevel5: false, isLevel6: false, isLevel7: true);
		}
		if (level == 8)
		{
			SelectorActive(isLevel: false, isLevel2: false, isLevel3: false, isLevel4: false, isLevel5: false, isLevel6: false, isLevel7: false, isLevel8: true);
		}
		if (level == 9)
		{
			SelectorActive(isLevel: false, isLevel2: false, isLevel3: false, isLevel4: false, isLevel5: false, isLevel6: false, isLevel7: false, isLevel8: false, isLevel9: true);
		}
		if (level == 10)
		{
			SelectorActive(isLevel: false, isLevel2: false, isLevel3: false, isLevel4: false, isLevel5: false, isLevel6: false, isLevel7: false, isLevel8: false, isLevel9: false, isLevel10: true);
		}
		if (level == 11)
		{
			SelectorActive(isLevel: false, isLevel2: false, isLevel3: false, isLevel4: false, isLevel5: false, isLevel6: false, isLevel7: false, isLevel8: false, isLevel9: false, isLevel10: false, isLevel11: true);
		}
		if (level == 12)
		{
			SelectorActive(isLevel: false, isLevel2: false, isLevel3: false, isLevel4: false, isLevel5: false, isLevel6: false, isLevel7: false, isLevel8: false, isLevel9: false, isLevel10: false, isLevel11: false, isLevel12: true);
		}
		if (level == 13)
		{
			SelectorActive(isLevel: false, isLevel2: false, isLevel3: false, isLevel4: false, isLevel5: false, isLevel6: false, isLevel7: false, isLevel8: false, isLevel9: false, isLevel10: false, isLevel11: false, isLevel12: false, isLevel13: true);
		}
		if (level == 14)
		{
			SelectorActive(isLevel: false, isLevel2: false, isLevel3: false, isLevel4: false, isLevel5: false, isLevel6: false, isLevel7: false, isLevel8: false, isLevel9: false, isLevel10: false, isLevel11: false, isLevel12: false, isLevel13: false, isLevel14: true);
		}
		if (level == 15)
		{
			SelectorActive(isLevel: false, isLevel2: false, isLevel3: false, isLevel4: false, isLevel5: false, isLevel6: false, isLevel7: false, isLevel8: false, isLevel9: false, isLevel10: false, isLevel11: false, isLevel12: false, isLevel13: false, isLevel14: false, isLevel15: true);
		}
		if (level == 16)
		{
			SelectorActive(isLevel: false, isLevel2: false, isLevel3: false, isLevel4: false, isLevel5: false, isLevel6: false, isLevel7: false, isLevel8: false, isLevel9: false, isLevel10: false, isLevel11: false, isLevel12: false, isLevel13: false, isLevel14: false, isLevel15: false, isLevel16: true);
		}
		if (level == 17)
		{
			SelectorActive(isLevel: false, isLevel2: false, isLevel3: false, isLevel4: false, isLevel5: false, isLevel6: false, isLevel7: false, isLevel8: false, isLevel9: false, isLevel10: false, isLevel11: false, isLevel12: false, isLevel13: false, isLevel14: false, isLevel15: false, isLevel16: false, isLevel17: true);
		}
		if (level == 18)
		{
			SelectorActive(isLevel: false, isLevel2: false, isLevel3: false, isLevel4: false, isLevel5: false, isLevel6: false, isLevel7: false, isLevel8: false, isLevel9: false, isLevel10: false, isLevel11: false, isLevel12: false, isLevel13: false, isLevel14: false, isLevel15: false, isLevel16: false, isLevel17: false, isLevel18: true);
		}
		if (level == 19)
		{
			SelectorActive(isLevel: false, isLevel2: false, isLevel3: false, isLevel4: false, isLevel5: false, isLevel6: false, isLevel7: false, isLevel8: false, isLevel9: false, isLevel10: false, isLevel11: false, isLevel12: false, isLevel13: false, isLevel14: false, isLevel15: false, isLevel16: false, isLevel17: false, isLevel18: false, isLevel19: true);
		}
		if (level == 20)
		{
			SelectorActive(isLevel: false, isLevel2: false, isLevel3: false, isLevel4: false, isLevel5: false, isLevel6: false, isLevel7: false, isLevel8: false, isLevel9: false, isLevel10: false, isLevel11: false, isLevel12: false, isLevel13: false, isLevel14: false, isLevel15: false, isLevel16: false, isLevel17: false, isLevel18: false, isLevel19: false, isLevel20: true);
		}
		NextBtn.GetComponent<Animator>().enabled = true;
	}

	public void SelectorActive(bool isLevel = false, bool isLevel2 = false, bool isLevel3 = false, bool isLevel4 = false, bool isLevel5 = false, bool isLevel6 = false, bool isLevel7 = false, bool isLevel8 = false, bool isLevel9 = false, bool isLevel10 = false, bool isLevel11 = false, bool isLevel12 = false, bool isLevel13 = false, bool isLevel14 = false, bool isLevel15 = false, bool isLevel16 = false, bool isLevel17 = false, bool isLevel18 = false, bool isLevel19 = false, bool isLevel20 = false)
	{
		Selectors[0].SetActive(isLevel);
		Selectors[1].SetActive(isLevel2);
		Selectors[2].SetActive(isLevel3);
		Selectors[3].SetActive(isLevel4);
		Selectors[4].SetActive(isLevel5);
		Selectors[5].SetActive(isLevel6);
		Selectors[6].SetActive(isLevel7);
		Selectors[7].SetActive(isLevel8);
		Selectors[8].SetActive(isLevel9);
		Selectors[9].SetActive(isLevel10);
		Selectors[10].SetActive(isLevel11);
		Selectors[11].SetActive(isLevel12);
		Selectors[12].SetActive(isLevel13);
		Selectors[13].SetActive(isLevel14);
		Selectors[14].SetActive(isLevel15);
		Selectors[15].SetActive(isLevel16);
		Selectors[16].SetActive(isLevel17);
		Selectors[17].SetActive(isLevel18);
		Selectors[18].SetActive(isLevel19);
		Selectors[19].SetActive(isLevel20);
	}
}
