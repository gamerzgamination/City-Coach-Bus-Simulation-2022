using UnityEngine;

public class Passengers : MonoBehaviour
{
	public GameObject des;

	public static Passengers instance;

	private void Start()
	{
		instance = this;
	}

	private void Update()
	{
		base.gameObject.transform.LookAt(des.transform.position);
		base.gameObject.transform.LookAt(des.transform);
		base.gameObject.transform.position = Vector3.MoveTowards(base.gameObject.transform.position, des.transform.position, Time.deltaTime * 1f);
	}
}
