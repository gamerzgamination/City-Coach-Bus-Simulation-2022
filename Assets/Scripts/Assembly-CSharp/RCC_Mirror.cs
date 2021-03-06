using UnityEngine;

[AddComponentMenu("BoneCracker Games/Realistic Car Controller/Misc/Mirror")]
public class RCC_Mirror : MonoBehaviour
{
	private Camera cam;

	private RCC_CarControllerV3 carController;

	private void InvertCamera()
	{
		cam = GetComponent<Camera>();
		cam.ResetWorldToCameraMatrix();
		cam.ResetProjectionMatrix();
		cam.projectionMatrix *= Matrix4x4.Scale(new Vector3(-1f, 1f, 1f));
		carController = GetComponentInParent<RCC_CarControllerV3>();
	}

	private void OnPreRender()
	{
		GL.invertCulling = true;
	}

	private void OnPostRender()
	{
		GL.invertCulling = false;
	}

	private void Update()
	{
		if (!cam)
		{
			InvertCamera();
		}
		else
		{
			cam.enabled = carController.canControl;
		}
	}
}
