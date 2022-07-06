using System;
using UnityEngine;

public class RuntimeExample : MonoBehaviour
{
	public GameObject walkerPrefab;

	public GameObject pathPrefab;

	public Transform position1;

	public Transform position2;

	public Transform position3;

	private GameObject walkerObj1;

	private GameObject newPath1;

	private iMove walkeriM1;

	private GameObject walkerObj2;

	private GameObject newPath2;

	private iMove walkeriM2;

	private void OnGUI()
	{
		Example1();
		Example2();
		GUI.Label(new Rect(10f, Screen.height - 30, Screen.width, 30f), "Example 3: UserInput - Press the left/right arrow key to move the capsule.");
	}

	private void Example1()
	{
		GUI.Label(new Rect(10f, 5f, 120f, 30f), "Example 1");
		if (!walkerObj1 && GUI.Button(new Rect(10f, 30f, 130f, 25f), "Instantiate Objects"))
		{
			walkerObj1 = UnityEngine.Object.Instantiate(walkerPrefab, position1.position, Quaternion.identity);
			walkerObj1.name = "Soldier@" + DateTime.Now.TimeOfDay;
			newPath1 = UnityEngine.Object.Instantiate(pathPrefab, position1.position, Quaternion.identity);
			newPath1.name = "RuntimePath@" + DateTime.Now.TimeOfDay;
			WaypointManager.AddPath(newPath1);
		}
		if ((bool)walkerObj1 && !walkeriM1 && GUI.Button(new Rect(140f, 30f, 130f, 25f), "Start Movement"))
		{
			walkeriM1 = walkerObj1.GetComponent<iMove>();
			walkeriM1.SetPath(WaypointManager.Paths[newPath1.name]);
		}
		if ((bool)newPath1 && GUI.Button(new Rect(10f, 30f, 130f, 25f), "Reposition Path"))
		{
			Transform transform = newPath1.transform;
			if (transform.position == position1.position)
			{
				transform.position = position2.position;
			}
			else
			{
				transform.position = position1.position;
			}
		}
		if ((bool)walkerObj1 && (bool)walkeriM1 && GUI.Button(new Rect(140f, 30f, 130f, 25f), "Reset Walker"))
		{
			walkeriM1.Reset();
			walkeriM1 = null;
		}
		if ((bool)walkerObj1 && (bool)walkeriM1 && GUI.Button(new Rect(270f, 30f, 100f, 25f), "Stop Walker"))
		{
			walkeriM1.Stop();
		}
		if ((bool)walkerObj1 && (bool)walkeriM1 && GUI.Button(new Rect(370f, 30f, 100f, 25f), "Continue Walk"))
		{
			walkeriM1.moveToPath = true;
			walkeriM1.StartMove();
		}
	}

	private void Example2()
	{
		GUI.Label(new Rect(10f, 60f, 120f, 30f), "Example 2");
		if (!walkerObj2 && GUI.Button(new Rect(10f, 85f, 130f, 25f), "Instantiate Objects"))
		{
			walkerObj2 = UnityEngine.Object.Instantiate(walkerPrefab, position3.position, Quaternion.identity);
			walkerObj2.name = "Soldier@" + DateTime.Now.TimeOfDay;
			newPath2 = UnityEngine.Object.Instantiate(pathPrefab, position3.position, Quaternion.identity);
			newPath2.name = "RuntimePath@" + DateTime.Now.TimeOfDay;
			WaypointManager.AddPath(newPath2);
		}
		if ((bool)walkerObj2 && !walkeriM2 && GUI.Button(new Rect(140f, 85f, 130f, 25f), "Start Movement"))
		{
			walkeriM2 = walkerObj2.GetComponent<iMove>();
			walkeriM2.SetPath(WaypointManager.Paths[newPath2.name]);
		}
		if ((bool)newPath1 && (bool)newPath2 && GUI.Button(new Rect(10f, 85f, 130f, 25f), "Switch Path"))
		{
			if (!walkeriM2)
			{
				walkeriM2 = walkerObj2.GetComponent<iMove>();
			}
			walkeriM2.moveToPath = true;
			if (walkeriM2.pathContainer == WaypointManager.Paths[newPath1.name])
			{
				walkeriM2.SetPath(WaypointManager.Paths[newPath2.name]);
			}
			else
			{
				walkeriM2.SetPath(WaypointManager.Paths[newPath1.name]);
			}
		}
	}
}
