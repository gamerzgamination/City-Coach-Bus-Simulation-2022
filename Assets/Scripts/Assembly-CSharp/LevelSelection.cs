using UnityEngine;
using UnityEngine.UI;

public class LevelSelection : MonoBehaviour
{
	public Button LoadLevelBtn;

	public Sprite[] LevelImages;

	public GameObject LockImage;

	public Text LevelName;

	private void Awake()
	{
		if (!PlayerPrefs.HasKey("CurrentLevel"))
		{
			PlayerPrefs.SetInt("CurrentLevel", 1);
		}
		if (!PlayerPrefs.HasKey("UnlockLevel2"))
		{
			for (int i = 0; i < 10; i++)
			{
				PlayerPrefs.SetInt("UnlockLevel" + (i + 1), 0);
			}
			PlayerPrefs.SetInt("UnlockLevel1", 1);
		}
	}

	private void Start()
	{
		PlayerPrefs.SetInt("CurrentLevel", 1);
	}

	private void Update()
	{
	}

	public void onClickBack()
	{
		GetComponent<MenuManager>().ShowMenu();
	}

	public void OnClickNext()
	{
		GetComponent<MenuManager>().LoadGamePlay();
	}

	public void onClickLevel(int Level_No)
	{
		if (PlayerPrefs.GetInt("UnlockLevel" + Level_No) == 1)
		{
			LockImage.SetActive(value: false);
			LoadLevelBtn.interactable = true;
			PlayerPrefs.SetInt("CurrentLevel", Level_No);
		}
		else
		{
			LoadLevelBtn.interactable = false;
			LockImage.SetActive(value: true);
		}
		LoadLevelBtn.gameObject.GetComponent<Image>().sprite = LevelImages[Level_No - 1];
		LevelName.text = "Level " + Level_No;
	}
}
