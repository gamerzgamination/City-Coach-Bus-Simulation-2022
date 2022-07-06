using UnityEngine;

public class miniMap : MonoBehaviour
{
	public Transform Player;

	private void Start()
	{
		if (!Player)
			Player = Toolbox.GameplayController.SelectedVehiclePrefab.transform;
		//Invoke("AssignPlayer", 1f);
	}

	private void AssignPlayer()
	{
		Player = GameObject.FindGameObjectWithTag("Player").transform;
	}

	private void LateUpdate()
	{
		if (!Player)
			Player = Toolbox.GameplayController.SelectedVehiclePrefab.transform;

		if ((bool)Player)
		{
			Vector3 position = Player.position;
			position.y = base.transform.position.y;
			base.transform.position = position;
			base.transform.rotation = Quaternion.Euler(90f, Player.eulerAngles.y, 0f);
		}
	}
}
