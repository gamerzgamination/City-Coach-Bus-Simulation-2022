using UnityEngine;

public class Camera_Manager : MonoBehaviour
{
	public Camera[] player_Cameras;

	public static int camera_NO = 1;

	private GameObject PlayerG;

	private void Start()
	{
		PlayerG = GameObject.FindGameObjectWithTag("Glass");
		camera_NO = 1;
		Invoke("Get_MainCamera", 0.3f);
	}

	private void Update()
	{
	}

	private void Get_MainCamera()
	{
		player_Cameras[0] = GameObject.FindGameObjectWithTag("MainCamera").GetComponent<Camera>();
	}

	public void switch_camera()
	{
		if (camera_NO >= player_Cameras.Length)
		{
			camera_NO = 0;
		}
		Camera[] array = player_Cameras;
		foreach (Camera camera in array)
		{
			if (camera == player_Cameras[camera_NO])
			{
				camera.enabled = true;
			}
			else
			{
				camera.enabled = false;
			}
		}
		camera_NO++;
		if (camera_NO == 2)
		{
			if (RCC_Camera.instance.playerCar.gameObject.name == "bus3")
			{
			}
			if (RCC_Camera.instance.playerCar.gameObject.name == "bus2")
			{
				PlayerG.GetComponent<MeshRenderer>().materials[1].shader = Shader.Find("Transparent/Diffuse");
			}
			if (RCC_Camera.instance.playerCar.gameObject.name == "bus1")
			{
				PlayerG.GetComponent<MeshRenderer>().materials[2].shader = Shader.Find("Transparent/Diffuse");
			}
		}
		else
		{
			if (RCC_Camera.instance.playerCar.gameObject.name == "bus3")
			{
			}
			if (RCC_Camera.instance.playerCar.gameObject.name == "bus2")
			{
				PlayerG.GetComponent<MeshRenderer>().materials[1].shader = Shader.Find("Legacy Shaders/Diffuse");
			}
			if (RCC_Camera.instance.playerCar.gameObject.name == "bus1")
			{
				PlayerG.GetComponent<MeshRenderer>().materials[2].shader = Shader.Find("Legacy Shaders/Diffuse");
			}
		}
	}
}
