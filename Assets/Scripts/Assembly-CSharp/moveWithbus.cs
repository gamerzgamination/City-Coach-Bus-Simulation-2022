using UnityEngine;

public class moveWithbus : MonoBehaviour
{
	[SerializeField]
	private Transform bus;

	private void Start()
	{
		Invoke("AssignPlayer", 1f);
	}

	private void AssignPlayer()
	{
		bus = GameObject.FindGameObjectWithTag("Player").transform;
	}

	private void Update()
	{
		if (bus)
		{
			base.transform.position = new Vector3(bus.position.x, base.transform.position.y, bus.transform.position.z);
			base.transform.eulerAngles = new Vector3(base.transform.eulerAngles.x, bus.transform.eulerAngles.y, base.transform.eulerAngles.z);
		}
	}
}
