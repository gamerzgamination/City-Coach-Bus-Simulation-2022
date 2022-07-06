using UnityEngine;

public class AAA : MonoBehaviour
{
	private void Start()
	{
		Invoke("Up", 3f);
	}

	private void Up()
	{
		Application.LoadLevel(1);
	}
}
