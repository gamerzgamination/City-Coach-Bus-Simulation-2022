using UnityEngine;

public class EndStand : MonoBehaviour
{
	public GameObject pasngerdrop;

	public GameObject fadecamera;

	public static GameManagerU instance;

	

	public void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.tag == "Player")
		{
			Toolbox.GameplayController.Selectedvehiclerigidbody.isKinematic = true;
			Invoke("droppasanger", 4f);
			Invoke("statrtplayer", 6f);
			Invoke("CompleteLevell", 8f);
			//Debug.Log("enddddd");
		}
	}

	public void droppasanger()
	{
		pasngerdrop.gameObject.SetActive(true);
	}

	public void statrtplayer()
	{
		Toolbox.GameplayController.Selectedvehiclerigidbody.isKinematic = false;
	}

	public void CompleteLevell()
	{
		//GameManagerU.instance.showlevelComplete();
		Toolbox.Soundmanager.PlaySound(Toolbox.Soundmanager.levelComplete);
		Toolbox.GameplayController.StartCoroutine(Toolbox.GameplayController.LevelComplete_Delay(3f));
	}

	public void blackcam()
	{
		fadecamera.SetActive(value: true);
	}
}
