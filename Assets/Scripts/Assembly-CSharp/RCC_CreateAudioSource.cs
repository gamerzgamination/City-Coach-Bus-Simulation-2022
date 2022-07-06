using UnityEngine;

public class RCC_CreateAudioSource : MonoBehaviour
{
	public static AudioSource NewAudioSource(GameObject go, string audioName, float minDistance, float maxDistance, float volume, AudioClip audioClip, bool loop, bool playNow, bool destroyAfterFinished)
	{
		GameObject gameObject = new GameObject(audioName);
		gameObject.transform.position = go.transform.position;
		gameObject.transform.rotation = go.transform.rotation;
		gameObject.transform.parent = go.transform;
		gameObject.AddComponent<AudioSource>();
		gameObject.GetComponent<AudioSource>().minDistance = minDistance;
		gameObject.GetComponent<AudioSource>().maxDistance = maxDistance;
		gameObject.GetComponent<AudioSource>().volume = volume;
		gameObject.GetComponent<AudioSource>().clip = audioClip;
		gameObject.GetComponent<AudioSource>().loop = loop;
		gameObject.GetComponent<AudioSource>().spatialBlend = 1f;
		if (playNow)
		{
			gameObject.GetComponent<AudioSource>().Play();
		}
		if (destroyAfterFinished)
		{
			if ((bool)audioClip)
			{
				Object.Destroy(gameObject, audioClip.length);
			}
			else
			{
				Object.Destroy(gameObject);
			}
		}
		if ((bool)go.transform.Find("All Audio Sources"))
		{
			gameObject.transform.SetParent(go.transform.Find("All Audio Sources"));
		}
		else
		{
			gameObject.transform.SetParent(go.transform, worldPositionStays: false);
		}
		return gameObject.GetComponent<AudioSource>();
	}

	public static void NewHighPassFilter(AudioSource source, float freq, int level)
	{
		if (!(source == null))
		{
			AudioHighPassFilter audioHighPassFilter = source.gameObject.AddComponent<AudioHighPassFilter>();
			audioHighPassFilter.cutoffFrequency = freq;
			audioHighPassFilter.highpassResonanceQ = level;
		}
	}
}
