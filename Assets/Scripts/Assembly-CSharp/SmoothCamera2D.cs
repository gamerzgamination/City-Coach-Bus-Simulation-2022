using UnityEngine;

public class SmoothCamera2D : MonoBehaviour
{
	public static SmoothCamera2D instance;

	public float dampTime = 0.15f;

	private Vector3 velocity = Vector3.zero;

	public Transform target;

	public float x;

	public float y;

	public float z = 0.5f;

	private int index;

	private void Start()
	{
		index = PlayerPrefs.GetInt("Ind");
		instance = this;
		base.gameObject.transform.parent = null;
	}

	private void Update()
	{
		if ((bool)target)
		{
			Vector3 vector = target.position - GetComponent<Camera>().ViewportToWorldPoint(new Vector3(x, y, z));
			Vector3 vector2 = base.transform.position + vector;
			base.transform.position = Vector3.SmoothDamp(base.transform.position, vector2, ref velocity, dampTime);
		}
	}
}
