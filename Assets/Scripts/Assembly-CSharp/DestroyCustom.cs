using UnityEngine;

public class DestroyCustom : MonoBehaviour
{
	private void Update()
	{
		if (!(Application.loadedLevelName == "Menu"))
		{
			Object.Destroy(base.gameObject);
		}
	}
}
