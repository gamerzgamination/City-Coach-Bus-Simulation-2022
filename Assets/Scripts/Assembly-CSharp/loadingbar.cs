using UnityEngine;
using UnityEngine.UI;

public class loadingbar : MonoBehaviour
{
	public Image LoadingImage;

	private void Start()
	{
	}

	private void OnEnable()
	{
		LoadingImage.fillAmount = 0f;
	}

	private void Update()
	{
		LoadingImage.fillAmount += 0.1f * Time.deltaTime;
	}
}
