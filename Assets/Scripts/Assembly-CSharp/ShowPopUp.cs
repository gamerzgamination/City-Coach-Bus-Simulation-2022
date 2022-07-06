using System.Collections;
using UnityEngine;

public class ShowPopUp : MonoBehaviour
{
	public GameObject privacyPnl;

	public GameObject RemoveAds;

	private int CrossCount;

	private void Start()
	{
		if (!PlayerPrefs.HasKey("declined"))
		{
			PlayerPrefs.SetInt("declined", 1);
		}
		if (PlayerPrefs.GetInt("declined") == 1)
		{
			OpenPrivacyPopUp();
			return;
		}
		OpenRemoveAdsPopUp();
		Invoke("showAd", 2f);
	}

	public void OpenPrivacyPopUp()
	{
		Invoke("PrivacyPopUp", 3f);
	}

	public void OpenRemoveAdsPopUp()
	{
		Invoke("RemoveAdsPopUP", 3f);
	}

	public void OpenPrivacyURL()
	{
		Application.OpenURL("https://sites.google.com/view/crown-apps/home");
	}

	public void CloseRemoveAdsPanel()
	{
		CrossCount++;
		if (CrossCount >= 2)
		{
			RemoveAds.SetActive(value: false);
			StartCoroutine(CloseLoading());
			CrossCount = 0;
		}
	}

	public void ClosePrivacyPanelPanel()
	{
		privacyPnl.SetActive(value: false);
		StartCoroutine(CloseLoading());
	}

	private void showAd()
	{
		//AdsManager.Instance.ShowInterstitail();
	}

	private void PrivacyPopUp()
	{
		privacyPnl.SetActive(value: true);
	}

	private void RemoveAdsPopUP()
	{
		RemoveAds.SetActive(value: true);
	}

	private IEnumerator CloseLoading()
	{
		yield return new WaitForSecondsRealtime(3f);
		loadingImage.instance.LoadNextLevel();
	}

	public void OnAcceptClick()
	{
		ClosePrivacyPanelPanel();
		PlayerPrefs.SetInt("declined", 0);
		Invoke("showAd", 1.5f);
	}

	private void Update()
	{
	}
}
