using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class StoreManager : MonoBehaviour
{
	public static StoreManager instance;

	public GameObject NextButton;

	public GameObject BuyButton;

	public float _TotalCash;

	private int Index;

	private int OldIndex;

	private bool isBuy;

	[Header("Text Attributes")]
	public Text TotalCash;

	public Text _NameText;

	public Text _PriceText;

	public Image properties;

	[Header("Buttons")]
	public Button btnBuy;

	[Header("Sprites")]
	public Image LockImage;

	public Sprite BuyImage;

	public Sprite NextImage;

	[Header("Panels")]
	public Transform _DialoguePanel;

	[Header("Store Things")]
	[SerializeField]
	private GameObject CamView;

	[Header("All Store Elements")]
	public _StoreElementProperties[] StoreElements;

	public GameObject StoreObjects;

	private bool isOnce;

	private void Awake()
	{
		instance = this;
	}

	private void Start()
	{
		CreatePlayerPrefabs();
		_TotalCash = PlayerPrefs.GetInt("TotalCash");
		TotalCash.text = _TotalCash.ToString();
		MonoBehaviour.print("Target" + StoreElements[Index]._Element.name);
		ShowStoreElementForStart();
	}

	private void Update()
	{
		if (!isOnce && MenuManager.instance.StoreCam.activeInHierarchy)
		{
			isOnce = true;
			SmoothCamera2D.instance.target = StoreElements[Index]._Element.transform;
		}
	}

	public void Next()
	{
		if (Index == StoreElements.Length - 1)
		{
			OldIndex = Index;
			Index = 0;
		}
		else
		{
			OldIndex = Index;
			Index++;
		}
		PlayerPrefs.SetInt("Ind", Index);
		ShowStoreElement();
	}

	public void Previous()
	{
		if (Index > 0)
		{
			OldIndex = Index;
			Index--;
		}
		else
		{
			OldIndex = Index;
			Index = StoreElements.Length - 1;
		}
		PlayerPrefs.SetInt("Ind", Index);
		ShowStoreElement();
	}

	public void BuyAll()
	{
		PlayerPrefs.SetInt("PlayerLock" + 1, 1);
		PlayerPrefs.SetInt("PlayerLock" + 2, 1);
		PlayerPrefs.SetInt("PlayerLock" + 3, 1);
	}

	public void Buy()
	{
		if (isBuy)
		{
			if (_TotalCash >= StoreElements[Index]._Price)
			{
				_TotalCash -= StoreElements[Index]._Price;
				TotalCash.text = _TotalCash.ToString();
				PlayerPrefs.SetInt("TotalCash", Mathf.RoundToInt(_TotalCash));
				PlayerPrefs.SetInt("PlayerLock" + Index, 1);
				ShowStoreElement();
				StopAllCoroutines();
				StartCoroutine(ShowDialogue("Purchased!", watchVideo: false));
			}
			else
			{
				StopAllCoroutines();
				StartCoroutine(ShowDialogue("Not Enough Cash!", watchVideo: true));
			}
		}
		else
		{
			PlayerPrefs.SetInt("SelectedPlayer", Index);
			MenuManager.instance.LoadGamePlay();
		}
	}

	public void BackToMenu()
	{
		GetComponent<MenuManager>().ShowMenu();
		StoreObjects.SetActive(value: false);
		GetComponent<MenuManager>().MainCam.SetActive(value: true);
	}

	public void AddCashWatchVideo()
	{
		StopAllCoroutines();
		StartCoroutine(ShowDialogue("Watch to Get Cash", watchVideo: true));
	}

	private void ShowStoreElement()
	{
		Index = PlayerPrefs.GetInt("Ind");
		HideStoreElement();
		_NameText.text = StoreElements[Index]._Name;
		_PriceText.text = StoreElements[Index]._Price.ToString();
		properties.sprite = StoreElements[Index]._Properties;
		CheckBuyStatus();
		SmoothCamera2D.instance.target = StoreElements[Index]._Element.transform;
	}

	public void delay()
	{
		if ((bool)SmoothCamera2D.instance)
		{
			SmoothCamera2D.instance.target = StoreElements[Index]._Element.transform;
		}
	}

	private void ShowStoreElementForStart()
	{
		HideStoreElement();
		_NameText.text = StoreElements[Index]._Name;
		_PriceText.text = StoreElements[Index]._Price.ToString();
		properties.sprite = StoreElements[Index]._Properties;
		CheckBuyStatus();
		Index = PlayerPrefs.GetInt("Ind");
		SmoothCamera2D.instance.target = StoreElements[Index]._Element.transform;
	}

	private void HideStoreElement()
	{
		_PriceText.text = string.Empty;
	}

	private void CheckBuyStatus()
	{
		if (PlayerPrefs.GetInt("PlayerLock" + Index) == 1)
		{
			NextButton.SetActive(value: true);
			BuyButton.SetActive(value: false);
			LockImage.transform.gameObject.SetActive(value: false);
			isBuy = false;
		}
		else
		{
			NextButton.SetActive(value: false);
			BuyButton.SetActive(value: true);
			LockImage.transform.gameObject.SetActive(value: true);
			isBuy = true;
		}
	}

	private void CreatePlayerPrefabs()
	{
		if (!PlayerPrefs.HasKey("TotalCash"))
		{
			PlayerPrefs.SetInt("TotalCash", 100);
		}
		if (!PlayerPrefs.HasKey("PlayerLock0"))
		{
			for (int i = 0; i < StoreElements.Length - 1; i++)
			{
				PlayerPrefs.SetInt("PlayerLock" + i, 0);
			}
			PlayerPrefs.SetInt("PlayerLock" + 0, 1);
		}
		if (!PlayerPrefs.HasKey("SelectedPlayer"))
		{
			PlayerPrefs.SetInt("SelectedPlayer", 0);
		}
	}

	public IEnumerator ShowDialogue(string msg, bool watchVideo)
	{
		_DialoguePanel.gameObject.SetActive(value: true);
		_DialoguePanel.GetComponentInChildren<Text>().text = msg;
		yield return new WaitForSeconds(3f);
		StopCoroutine("ShowDialogue");
		_DialoguePanel.gameObject.SetActive(value: false);
	}

	public void RewardForWatchVideo()
	{
		_TotalCash += 100f;
		PlayerPrefs.SetInt("TotalCash", (int)_TotalCash);
		TotalCash.text = _TotalCash.ToString();
	}
}
