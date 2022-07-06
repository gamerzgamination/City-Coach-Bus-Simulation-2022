using UnityEngine;

public class AudioController : MonoBehaviour
{
	public AudioSource BackGroundMusic;

	private AudioSource[] Audios;

	private void Start()
	{
		if (PlayerPrefs.HasKey("IsMusicAuio") || !PlayerPrefs.HasKey("IsSoundAuio"))
		{
		}
		checkAudio();
	}

	private void Update()
	{
		checkAudio();
	}

	private void checkAudio()
	{
		if (PlayerPrefs.GetInt("IsMusicAuio") == 1 && Time.timeScale == 1f)
		{
			BackGroundMusic.mute = false;
		}
		else
		{
			BackGroundMusic.mute = true;
		}
		if (PlayerPrefs.GetInt("IsSoundAuio") == 1 && Time.timeScale == 1f)
		{
			SetVolumeMute(isMute: false);
		}
		else
		{
			SetVolumeMute();
		}
	}

	private void SetVolumeMute(bool isMute = true)
	{
		Audios = Object.FindObjectsOfType<AudioSource>();
		for (int i = 0; i < Audios.Length; i++)
		{
			if (Audios[i] != BackGroundMusic)
			{
				Audios[i].mute = isMute;
			}
		}
	}
}
