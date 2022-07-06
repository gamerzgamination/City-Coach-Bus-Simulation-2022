using UnityEngine;

[AddComponentMenu("BoneCracker Games/Realistic Car Controller/Camera/Fixed System/Child Camera")]
public class RCC_ChildFixedCamera : MonoBehaviour
{
	[HideInInspector]
	public Transform player;

	public float distance = 50f;

	private void Update()
	{
		if ((bool)player)
		{
			base.transform.LookAt(new Vector3(player.position.x, player.position.y, player.position.z));
		}
	}
}
