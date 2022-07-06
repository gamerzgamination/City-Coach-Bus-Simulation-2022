using UnityEngine;

public class test : MonoBehaviour
{
	public GameObject des;

	private void Start()
	{
		base.gameObject.GetComponent<Animation>().Play("mixamo.com");
	}

	private void Update()
	{
		if (GameManagerU.femaleTalkingBool)
		{
			Invoke("Playthis", 2f);
		}
	}

	private void Playthis()
	{
		base.gameObject.GetComponent<Animation>().CrossFade("walk");
		base.gameObject.transform.LookAt(des.transform.position);
		base.gameObject.transform.LookAt(des.transform);
		base.gameObject.transform.position = Vector3.MoveTowards(base.gameObject.transform.position, des.transform.position, Time.deltaTime * 1f);
		GameManagerU.femaleTalkingBool = false;
	}
}
