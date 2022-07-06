using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class lerp_cam_main : MonoBehaviour
{
	public float transitionDuration = 3.5f;

	public List<Transform> target;

	public List<GameObject> horsePnl;

	public List<GameObject> horses;

	public Transform initialPos;

	public GameObject lerpCam;

	public static bool isLerp;

	private float t_ = 6f;

	public static int i;

	private float time;

	private float time1;

	public GameObject btnPlay;

	public GameObject btnBuy;

	public static lerp_cam_main Instance;

	public GameObject notCoins;

	public void ChangeIndex()
	{
		i = 0;
	}

	private void Start()
	{
		LerpNext();
		Instance = this;
		ChangeIndex();
	}

	private void Update()
	{
		if (isLerp)
		{
			isLerp = false;
			StartCoroutine(Transition());
		}
	}

	private IEnumerator Transition()
	{
		float t = 0f;
		while (t < 2f)
		{
			t += Time.deltaTime * (Time.timeScale / transitionDuration);
			lerpCam.transform.position = Vector3.Lerp(initialPos.position, target[i].position, t * Time.deltaTime);
			lerpCam.transform.rotation = Quaternion.Lerp(initialPos.rotation, target[i].rotation, t * Time.deltaTime);
			yield return 0;
		}
		isLerp = false;
	}

	public void LerpNext()
	{
		isLerp = true;
		if (i < target.Count - 1)
		{
			i++;
		}
		else
		{
			i = 0;
		}
	}

	public void LerpPreviouse()
	{
		isLerp = true;
		if (i > 0)
		{
			i--;
		}
		else
		{
			i = target.Count - 1;
		}
	}

	public void Buy()
	{
	}

	public void ResetPanals()
	{
		foreach (GameObject item in horsePnl)
		{
			item.SetActive(value: false);
		}
		horsePnl[0].SetActive(value: true);
	}

	public void ResetPnl()
	{
	}

	public void Armor()
	{
		if (!horses[i].transform.GetChild(0).transform.GetChild(0).gameObject.activeSelf)
		{
			horses[i].transform.GetChild(0).transform.GetChild(0).gameObject.SetActive(value: true);
		}
		else
		{
			horses[i].transform.GetChild(0).transform.GetChild(0).gameObject.SetActive(value: false);
		}
	}

	public void Pluse(string btn)
	{
		if (PlayerPrefs.GetInt("score") >= 500)
		{
			EventSystem.current.currentSelectedGameObject.GetComponentInChildren<Slider>().value += 5f;
			int value = (int)EventSystem.current.currentSelectedGameObject.GetComponentInChildren<Slider>().value;
			PlayerPrefs.SetInt(btn + i, value);
			PlayerPrefs.SetInt("max" + btn + i, value);
			PlayerPrefs.SetInt("score", PlayerPrefs.GetInt("score") - 500);
		}
		else
		{
			notCoins.SetActive(value: true);
			Invoke("ResetPnl", 1f);
		}
		MonoBehaviour.print(PlayerPrefs.GetInt("speed" + i));
	}
}
