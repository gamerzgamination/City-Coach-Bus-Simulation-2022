using UnityEngine;
using UnityEngine.UI;

public class loadingImage : MonoBehaviour
{
	public Image LoadingImage;

	public static loadingImage instance;

	private void Start()
	{
		instance = this;
	}

	private void Update()
	{
		LoadingImage.fillAmount += 1f / 6f * Time.deltaTime;
	}

	public void LoadNextLevel()
	{
		Application.LoadLevel(Application.loadedLevel + 1);
	}
}
