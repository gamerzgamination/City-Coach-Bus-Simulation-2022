using UnityEngine;

public class BackTrigger : MonoBehaviour
{
	private void Start()
	{
	}

	private void Update()
	{
	}

	private void OnTriggerStay(Collider other)
	{
		if (other.gameObject.tag == "car1")
		{
			other.gameObject.GetComponent<hoMove>().Pause();
			WheelRotation[] componentsInChildren = other.GetComponentsInChildren<WheelRotation>();
			WheelRotation[] array = componentsInChildren;
			foreach (WheelRotation wheelRotation in array)
			{
				wheelRotation.enabled = false;
			}
		}
	}

	private void OnTriggerExit(Collider other)
	{
		if (other.gameObject.tag == "car1")
		{
			other.GetComponent<hoMove>().Resume();
			WheelRotation[] componentsInChildren = other.GetComponentsInChildren<WheelRotation>();
			WheelRotation[] array = componentsInChildren;
			foreach (WheelRotation wheelRotation in array)
			{
				wheelRotation.enabled = true;
			}
		}
	}
}
