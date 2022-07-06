using UnityEngine;

public class um_EnvirementManager : MonoBehaviour
{
	public enum um_EName
	{
		Snow,
		Forest
	}

	public um_EName EnvirementName;

	[Header("Materials")]
	public Material SnowSkyBox;

	public Material ForestSkyBox;

	public Material RoadSides;

	public Material Road;

	[Header("Texrtures")]
	public Texture SnowTexture;

	public Texture SnowRoadTexture;

	public Texture ForestRoadTexture;

	public Texture ForestSideTexture;

	[Header("Objects")]
	public GameObject SnowEnvirementEelemets;

	public GameObject SnowFall;

	public GameObject ForestEnvirementElements;

	private void Start()
	{
		SnowFall.SetActive(value: false);
		RenderSettings.skybox = SnowSkyBox;
	}

	private void Update()
	{
		if (EnvirementName == um_EName.Snow)
		{
			SnowEnvirement();
			ForestEnvirementElements.SetActive(value: false);
		}
		else
		{
			ForestEnvirement();
			hideSnowEniverment();
		}
	}

	private void OnDisable()
	{
		MonoBehaviour.print("script was removed");
	}

	private void SnowEnvirement()
	{
		SnowFall.SetActive(value: true);
		Road.mainTexture = SnowRoadTexture;
		Road.color = new Color(0.55f, 0.55f, 0.55f, 1f);
		RoadSides.mainTexture = SnowTexture;
		SnowEnvirementEelemets.SetActive(value: true);
	}

	private void hideSnowEniverment()
	{
		SnowFall.SetActive(value: false);
		SnowEnvirementEelemets.SetActive(value: false);
	}

	private void ForestEnvirement()
	{
		Road.mainTexture = ForestRoadTexture;
		Road.color = new Color(0.4f, 0.4f, 0.4f, 1f);
		RoadSides.mainTexture = ForestSideTexture;
		ForestEnvirementElements.SetActive(value: true);
	}
}
