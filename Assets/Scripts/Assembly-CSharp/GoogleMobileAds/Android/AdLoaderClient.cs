using UnityEngine;
using GoogleMobileAds.Api;

namespace GoogleMobileAds.Android
{
	public class AdLoaderClient : AndroidJavaProxy
	{
		public AdLoaderClient(AdLoader unityAdLoader) : base(default(string))
		{
		}

	}
}
