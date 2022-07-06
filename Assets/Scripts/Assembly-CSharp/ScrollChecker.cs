using UnityEngine;
using UnityEngine.UI;

public class ScrollChecker : MonoBehaviour
{
	public Scrollbar rect;

	public static ScrollChecker instance;

	private void Start()
	{
		instance = this;
		rect = GetComponent<Scrollbar>();
		if (PlayerPrefs.GetInt("levels") <= 5)
		{
			instance.rect.GetComponent<Scrollbar>().value = 0f;
		}
		else if (PlayerPrefs.GetInt("levels") > 5 && PlayerPrefs.GetInt("levels") <= 10)
		{
			instance.rect.GetComponent<Scrollbar>().value = 0.3266002f;
		}
		else if (PlayerPrefs.GetInt("levels") > 10 && PlayerPrefs.GetInt("levels") <= 15)
		{
			instance.rect.GetComponent<Scrollbar>().value = 0.6669168f;
		}
		else if (PlayerPrefs.GetInt("levels") > 15 && PlayerPrefs.GetInt("levels") <= 20)
		{
			instance.rect.GetComponent<Scrollbar>().value = 0.9964239f;
		}
	}

	private void Update()
	{
	}

	public void ListenerMethod(Vector2 value)
	{
		Debug.Log("ListenerMethod: " + value);
	}
}
