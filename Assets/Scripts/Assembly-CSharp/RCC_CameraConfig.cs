using UnityEngine;

//[AddComponentMenu("BoneCracker Games/Realistic Car Controller/Camera/Camera Config")]
public class RCC_CameraConfig : MonoBehaviour
{
	public bool automatic = true;

	private Bounds combinedBounds;

	public float distance = 10f;

	public float height = 5f;

	private void Awake()
	{
		if (!automatic)
		{
			return;
		}
		//Quaternion rotation = base.transform.rotation;
		//base.transform.rotation = Quaternion.identity;
		//combinedBounds = GetComponentInChildren<Renderer>().bounds;
		//Renderer[] componentsInChildren = GetComponentsInChildren<Renderer>();
		//Renderer[] array = componentsInChildren;
		//foreach (Renderer renderer in array)
		//{
		//	if (renderer != GetComponent<Renderer>() && renderer.GetComponent<ParticleSystem>() == null)
		//	{
		//		combinedBounds.Encapsulate(renderer.bounds);
		//	}
		//}
		//base.transform.rotation = rotation;
		//distance = combinedBounds.size.z * 1.1f;
		//height = combinedBounds.size.z * 0.35f;
		SetCameraSettings();
	}

	public void SetCameraSettings()
	{
		
		//if ((bool))
		//{
		//	rCC_Camera.distance = distance;
		//	rCC_Camera.height = height;
		//}
	}
}
