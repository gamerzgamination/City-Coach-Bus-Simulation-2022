using UnityEngine;

public class SwithCamras : MonoBehaviour
{
	public GameObject current_car;

	public GameManagerU gamemanger;

	public int respCount;

	public bool respunbool;

	private void Start()
	{
		respunbool = true;
		Invoke("FindPlayer", 0.3f);
	}

	private void FindPlayer()
	{
		current_car = GameObject.FindGameObjectWithTag("Player");
	}

	public void switch_Camera()
	{
		current_car.GetComponent<Camera_Manager>().switch_camera();
	}

	public void truebool()
	{
		respunbool = true;
	}

	public void AgainTrue()
	{
		current_car.GetComponent<Rigidbody>().isKinematic = false;
	}
}
