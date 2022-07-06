using UnityEngine;

public class busselection : MonoBehaviour
{
	public Material[] Colors;

	public MeshRenderer Body;

	private void Start()
	{
		Body.material = Colors[PlayerPrefs.GetInt("SelectedPlayer")];
	}
}
