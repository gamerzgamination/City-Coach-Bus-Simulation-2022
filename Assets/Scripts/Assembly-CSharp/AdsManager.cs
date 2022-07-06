using System;
using GoogleMobileAds.Api;
//using Heyzap;
using UnityEngine;
using UnityEngine.Advertisements;

public class AdsManager : MonoBehaviour
{
	//private RewardBasedVideoAd rewardBasedVideo;

	//private static AdsManager _instance;

	//private InterstitialAd interstitial;

	//private BannerView bannerView;

	//private BannerView bannerView2;

	//private BannerView MediumRect;

	//public static bool BannerAtLeft;

	//private NativeExpressAdView nativeExpressAdView;

	//private NativeExpressAdView nativeExpressAdViewMedium;

	//private NativeExpressAdView nativeExpressAdViewLarge;

	//private bool showAdmobInsterstitial;

	//public string admob_APPID;

	//private string rewardedVideoID;

	//public static AdsManager Instance
	//{
	//	get
	//	{
	//		if (_instance == null)
	//		{
	//			_instance = UnityEngine.Object.FindObjectOfType<AdsManager>();
	//			UnityEngine.Object.DontDestroyOnLoad(_instance.gameObject);
	//		}
	//		return _instance;
	//	}
	//}

	//private void Awake()
	//{
	//	if (_instance == null)
	//	{
	//		_instance = this;
	//		UnityEngine.Object.DontDestroyOnLoad(this);
	//	}
	//	else if (this != _instance)
	//	{
	//		UnityEngine.Object.Destroy(base.gameObject);
	//	}
	//	MobileAds.Initialize(admob_APPID);
	//}

	//public void initAdmobBanner(string admobID)
	//{
	//	bannerView = new BannerView(admobID, AdSize.Banner, AdPosition.TopRight);
	//	AdRequest request = new AdRequest.Builder().Build();
	//	bannerView.LoadAd(request);
	//	hideBanner();
	//}

	//public void showBanner()
	//{
	//	bannerView.Show();
	//}

	//public void hideBanner()
	//{
	//	bannerView.Hide();
	//}

	//public void initAdmobBanner2(string admobID)
	//{
	//	bannerView2 = new BannerView(admobID, AdSize.Banner, AdPosition.Bottom);
	//	AdRequest request = new AdRequest.Builder().Build();
	//	bannerView2.LoadAd(request);
	//	hideBanner2();
	//}

	//public void showBanner2()
	//{
	//	bannerView2.Show();
	//}

	//public void hideBanner2()
	//{
	//	bannerView2.Hide();
	//}

	//public void initAdmobRect(string admobID)
	//{
	//	AdSize adSize = new AdSize(240, 190);
	//	MediumRect = new BannerView(admobID, adSize, 0, 50);
	//	AdRequest request = new AdRequest.Builder().Build();
	//	MediumRect.LoadAd(request);
	//	hideRectBanner();
	//}

	//public void showRectBanner()
	//{
	//	MediumRect.Show();
	//}

	//public void hideRectBanner()
	//{
	//	MediumRect.Hide();
	//}

	//public void HideAdmobInterstitial()
	//{
	//	showAdmobInsterstitial = false;
	//}

	//public void RequestRewardBasedVideo(string rewardedID)
	//{
	//	rewardedVideoID = rewardedID;
	//	rewardBasedVideo = RewardBasedVideoAd.Instance;
	//	rewardBasedVideo.OnAdLoaded += HandleRewardBasedVideoLoaded;
	//	rewardBasedVideo.OnAdFailedToLoad += HandleRewardBasedVideoFailedToLoad;
	//	rewardBasedVideo.OnAdOpening += HandleRewardBasedVideoOpened;
	//	rewardBasedVideo.OnAdStarted += HandleRewardBasedVideoStarted;
	//	rewardBasedVideo.OnAdRewarded += HandleRewardBasedVideoRewarded;
	//	rewardBasedVideo.OnAdClosed += HandleRewardBasedVideoClosed;
	//	rewardBasedVideo.LoadAd(createAdRequest(), rewardedID);
	//}

	//private AdRequest createAdRequest()
	//{
	//	return new AdRequest.Builder().Build();
	//}

	//public void ShowRewardedUnityADS()
	//{
	//	if (Advertisement.IsReady())
	//	{
	//		showRewardedUnity();
	//	}
	//	else if (rewardBasedVideo.IsLoaded())
	//	{
	//		ShowRewardBasedVideo();
	//	}
	//}

	//private void videoNotAvailableFtn()
	//{
	//	MonoBehaviour.print("video not available");
	//}

	//public void ShowRewardBasedVideo()
	//{
	//	if (rewardBasedVideo.IsLoaded())
	//	{
	//		rewardBasedVideo.Show();
	//		return;
	//	}
	//	RequestRewardBasedVideo(rewardedVideoID);
	//	MonoBehaviour.print("Reward based video ad is not ready yet.");
	//}

	//public void initAdmobInterstitial(string interstitialID)
	//{
	//	interstitial = new InterstitialAd(interstitialID);
	//	AdRequest request = new AdRequest.Builder().Build();
	//	interstitial.LoadAd(request);
	//	interstitial.OnAdClosed += admobClosed;
	//	interstitial.OnAdLoaded += delegate
	//	{
	//		if (showAdmobInsterstitial)
	//		{
	//			showAdmobInsterstitial = false;
	//			interstitial.Show();
	//		}
	//	};
	//}

	//private void admobClosed(object sender, EventArgs args)
	//{
	//	MonoBehaviour.print("interstitial closed.");
	//	requestInterstitial();
	//}

	//private void requestInterstitial()
	//{
	//	AdRequest request = new AdRequest.Builder().Build();
	//	interstitial.LoadAd(request);
	//}

	//public void ShowInterstitail()
	//{
	//	if (!interstitial.IsLoaded())
	//	{
	//		showAdmobInsterstitial = true;
	//		requestInterstitial();
	//	}
	//	else
	//	{
	//		interstitial.Show();
	//	}
	//}

	//public void InitUnityadd(string _unityid)
	//{
	//	if (!Advertisement.isInitialized)
	//	{
	//		Advertisement.Initialize(_unityid);
	//	}
	//}

	//public void ShowUnityADS()
	//{
	//	if (Advertisement.IsReady())
	//	{
	//		Advertisement.Show();
	//	}
	//}

	//public void InitHeyzap(string heyzapAD)
	//{
	//	HeyzapAds.Start(heyzapAD, 0);
	//	HZInterstitialAd.Fetch();
	//}

	//public void heyzapShow()
	//{
	//	HZInterstitialAd.Show();
	//	HZInterstitialAd.Fetch();
	//}

	//public void showTestSuite()
	//{
	//	HeyzapAds.ShowMediationTestSuite();
	//}

	//public void showHeyzapUnity()
	//{
	//	if (HZInterstitialAd.IsAvailable())
	//	{
	//		heyzapShow();
	//	}
	//	else
	//	{
	//		Advertisement.Show();
	//	}
	//}

	//public void showUnityHeyzap()
	//{
	//	if (Advertisement.IsReady())
	//	{
	//		Advertisement.Show();
	//	}
	//	else
	//	{
	//		heyzapShow();
	//	}
	//}

	//public void showUnityAdmob()
	//{
	//	if (Advertisement.IsReady())
	//	{
	//		Advertisement.Show();
	//	}
	//	else
	//	{
	//		ShowInterstitail();
	//	}
	//}

	//public void showUnity()
	//{
	//	if (Advertisement.IsReady())
	//	{
	//		Advertisement.Show();
	//	}
	//}

	//public void showHeyzap()
	//{
	//	if (HZInterstitialAd.IsAvailable())
	//	{
	//		heyzapShow();
	//	}
	//}

	//public void ShowAdmobHeyzap()
	//{
	//	if (interstitial.IsLoaded())
	//	{
	//		interstitial.Show();
	//	}
	//	else
	//	{
	//		heyzapShow();
	//	}
	//	requestInterstitial();
	//}

	//private void showRewardedUnity()
	//{
	//	if (Advertisement.IsReady())
	//	{
	//		Advertisement.Show("rewardedVideo", new ShowOptions
	//		{
	//			resultCallback = delegate(ShowResult result)
	//			{
	//				Debug.Log(result.ToString());
	//				if (result == ShowResult.Finished)
	//				{
	//					Debug.Log("Watched full Video . Result was :: " + result);
	//					PlayerPrefs.SetInt("SetText", 1);
	//					if (PlayerPrefs.GetInt("WatchToUnlock") == 1)
	//					{
	//						PlayerPrefs.SetInt("WatchToUnlock", 0);
	//						GameManagerU.instance.levelFailedPanel.SetActive(value: false);
	//						GameManagerU.instance.MoveOnWatchVideoToUnlockLvl();
	//					}
	//					else
	//					{
	//						for (int i = 0; i <= 1000; i++)
	//						{
	//							GameManagerU.instance.fuelImage.fillAmount += 0.05f * Time.deltaTime;
	//						}
	//					}
	//				}
	//				else
	//				{
	//					Debug.Log("No award given. Result was :: " + result);
	//				}
	//			}
	//		});
	//	}
	//	else
	//	{
	//		Debug.Log("UnityAD Failed to Fetch");
	//	}
	//}

	//public void HandleRewardBasedVideoLoaded(object sender, EventArgs args)
	//{
	//	Debug.Log("HandleRewardBasedVideoLoaded event received.");
	//}

	//public void HandleRewardBasedVideoFailedToLoad(object sender, AdFailedToLoadEventArgs args)
	//{
	//	Debug.Log("HandleRewardBasedVideoFailedToLoad event received with message: " + args.Message);
	//}

	//public void HandleRewardBasedVideoOpened(object sender, EventArgs args)
	//{
	//	Debug.Log("HandleRewardBasedVideoOpened event received");
	//}

	//public void HandleRewardBasedVideoStarted(object sender, EventArgs args)
	//{
	//	Debug.Log("HandleRewardBasedVideoStarted event received");
	//}

	//public void HandleRewardBasedVideoClosed(object sender, EventArgs args)
	//{
	//	Debug.Log("HandleRewardBasedVideoClosed event received");
	//	RequestRewardBasedVideo(rewardedVideoID);
	//}

	//public void HandleRewardBasedVideoRewarded(object sender, Reward args)
	//{
	//	string type = args.Type;
	//	Debug.Log("HandleRewardBasedVideoRewarded event received for " + args.Amount + " " + type);
	//	PlayerPrefs.SetInt("SetText", 1);
	//	if (PlayerPrefs.GetInt("WatchToUnlock") == 1)
	//	{
	//		PlayerPrefs.SetInt("WatchToUnlock", 0);
	//		GameManagerU.instance.levelFailedPanel.SetActive(value: false);
	//		GameManagerU.instance.MoveOnWatchVideoToUnlockLvl();
	//	}
	//	else
	//	{
	//		for (int i = 0; i <= 1000; i++)
	//		{
	//			GameManagerU.instance.fuelImage.fillAmount += 0.05f * Time.deltaTime;
	//		}
	//	}
	//}
}
