using System.Collections;
using UnityEngine;

[AddComponentMenu("BoneCracker Games/Realistic Car Controller/Camera/Fixed System/Main Camera")]
public class RCC_MainFixedCamera : MonoBehaviour
{
	private Transform[] camPositions;

	private RCC_ChildFixedCamera[] childCams;

	private float[] childDistances;

	private RCC_Camera rccCamera;

	private float distance;

	internal Transform player;

	public float minimumFOV = 20f;

	public float maximumFOV = 60f;

	public bool canTrackNow;

	public bool drawGizmos = true;

	private void Start()
	{
		StartCoroutine(GetVariables());
	}

	private IEnumerator GetVariables()
	{
		yield return new WaitForSeconds(1f);
		childCams = GetComponentsInChildren<RCC_ChildFixedCamera>();
		rccCamera = Object.FindObjectOfType<RCC_Camera>();
		RCC_ChildFixedCamera[] array = childCams;
		foreach (RCC_ChildFixedCamera rCC_ChildFixedCamera in array)
		{
			rCC_ChildFixedCamera.enabled = false;
			rCC_ChildFixedCamera.player = player;
		}
		camPositions = new Transform[childCams.Length];
		childDistances = new float[childCams.Length];
		for (int j = 0; j < camPositions.Length; j++)
		{
			camPositions[j] = childCams[j].transform;
			childDistances[j] = childCams[j].distance;
		}
	}

	private void Act()
	{
		RCC_ChildFixedCamera[] array = childCams;
		foreach (RCC_ChildFixedCamera rCC_ChildFixedCamera in array)
		{
			rCC_ChildFixedCamera.enabled = false;
			rCC_ChildFixedCamera.player = player;
		}
	}

	private void Update()
	{
		if (!player)
		{
			return;
		}
		if (canTrackNow)
		{
			Tracking();
		}
		RCC_ChildFixedCamera[] array = childCams;
		foreach (RCC_ChildFixedCamera rCC_ChildFixedCamera in array)
		{
			if (rCC_ChildFixedCamera.player != player)
			{
				rCC_ChildFixedCamera.player = player;
			}
		}
	}

	private void Tracking()
	{
		bool flag = false;
		for (int i = 0; i < camPositions.Length; i++)
		{
			distance = Vector3.Distance(camPositions[i].position, player.transform.position);
			if (distance <= childDistances[i])
			{
				flag = true;
				if (!childCams[i].enabled)
				{
					childCams[i].enabled = true;
				}
				if (rccCamera.transform.parent != childCams[i].transform)
				{
					rccCamera.transform.SetParent(childCams[i].transform);
					rccCamera.transform.localPosition = Vector3.zero;
					rccCamera.transform.localRotation = Quaternion.identity;
				}
				rccCamera.targetFieldOfView = Mathf.Lerp(rccCamera.targetFieldOfView, Mathf.Lerp(maximumFOV, minimumFOV, Vector3.Distance(rccCamera.transform.position, player.transform.position) * 2f / childDistances[i]), Time.deltaTime * 3f);
			}
			else
			{
				if (childCams[i].enabled)
				{
					childCams[i].enabled = false;
				}
				if (rccCamera.transform.parent == childCams[i].transform)
				{
					canTrackNow = false;
					rccCamera.transform.SetParent(null);
					childCams[i].transform.rotation = Quaternion.identity;
					rccCamera.cameraSwitchCount = 10;
					rccCamera.ChangeCamera();
				}
			}
		}
		if (!flag && rccCamera.cameraSwitchCount == 3)
		{
			canTrackNow = false;
			rccCamera.transform.SetParent(null);
			rccCamera.cameraSwitchCount = 10;
			rccCamera.ChangeCamera();
		}
	}

	private void OnDrawGizmos()
	{
		if (drawGizmos)
		{
			childCams = GetComponentsInChildren<RCC_ChildFixedCamera>();
			camPositions = new Transform[childCams.Length];
			childDistances = new float[childCams.Length];
			for (int i = 0; i < camPositions.Length; i++)
			{
				camPositions[i] = childCams[i].transform;
				childDistances[i] = childCams[i].distance;
				Gizmos.matrix = camPositions[i].transform.localToWorldMatrix;
				Gizmos.color = new Color(1f, 0f, 0f, 0.5f);
				Gizmos.DrawCube(Vector3.zero, new Vector3(childDistances[i] * 2f, childDistances[i] / 2f, childDistances[i] * 2f));
			}
		}
	}
}
