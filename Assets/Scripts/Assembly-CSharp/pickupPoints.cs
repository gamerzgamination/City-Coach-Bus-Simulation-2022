using UnityEngine;

public class pickupPoints : MonoBehaviour
{
	public GameObject StandPasengers;

	//public GameObject fadecamera;

	public GameObject currentpoint;

	public GameObject nextpoint;

	private void Start()
	{
		StandPasengers.gameObject.SetActive(true);
		for (int i = 0; i < StandPasengers.transform.childCount; i++)
		{
			StandPasengers.transform.GetChild(i).GetComponent<Animation>().enabled = false;
			StandPasengers.transform.GetChild(i).GetComponent<Passengers>().enabled = false;
		}

	}

	

	public void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.tag == "Player")
		{
			if (Toolbox.DB.Prefs.Get_LastSelectedLevelOfCurrentGameMode() == 19)
			{
				Invoke(nameof(showfadecam), 7f);
				Invoke(nameof(disablepasenger), 10f);
			}
			else
			{
				Invoke(nameof(showfadecam), 8f);
				Invoke(nameof(disablepasenger), 11f);
			}
			Toolbox.GameplayController.Selectedvehiclerigidbody.isKinematic = true;
			Invoke(nameof(EnablePassengers), 5f);
			Invoke(nameof(startplayer), 13f);
			if (Toolbox.DB.Prefs.Get_LastSelectedLevelOfCurrentGameMode() == 1)
			{
				Invoke(nameof(CompleteLevell), 13f);
			}
			if (Toolbox.DB.Prefs.Get_LastSelectedLevelOfCurrentGameMode() == 19 && base.gameObject.tag == "newtrigger")
			{
				//GameManagerU.femaleTalkingBool = true;
			}
		}
	}

	private void EnablePassengers()
	{
		for (int i = 0; i < StandPasengers.transform.childCount; i++)
		{
			StandPasengers.transform.GetChild(i).GetComponent<Animation>().enabled = true;
			StandPasengers.transform.GetChild(i).GetComponent<Passengers>().enabled = true;
		}
	}

	private void CompleteLevell()
	{
		Toolbox.GameplayController.LevelComplete_Delay(1f);
	}

	public void showfadecam()
	{
		Toolbox.HUDListner.set_StatusFade(true);
		StartCoroutine(Toolbox.HUDListner.FadeLoadingScreen(1,3));
		Invoke("offfadecam", 3f);
	}

	public void offfadecam()
	{
		Toolbox.HUDListner.set_StatusFade(false);
	}

	public void disablepasenger()
	{
		Toolbox.HUDListner.ParkingBar.fillAmount = 0f;
		StandPasengers.SetActive(value: false);
		currentpoint.SetActive(value: false);
		nextpoint.SetActive(value: true);
	}

	public void startplayer()
	{
		Toolbox.GameplayController.Selectedvehiclerigidbody.isKinematic = false;
	}
}
