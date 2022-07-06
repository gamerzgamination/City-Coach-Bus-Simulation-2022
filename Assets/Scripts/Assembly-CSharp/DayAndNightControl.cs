using UnityEngine;

public class DayAndNightControl : MonoBehaviour
{
	private Mesh mesh;

	public GameObject StarDome;

	public int currentDay;

	public string DayState;

	public Light directionalLight;

	public float SecondsInAFullDay = 120f;

	[Range(0f, 1f)]
	public float currentTime;

	[HideInInspector]
	public float timeMultiplier = 1f;

	private float lightIntensity;

	private Material starMat;

	private void Start()
	{
		lightIntensity = directionalLight.intensity;
		starMat = StarDome.GetComponent<MeshRenderer>().material;
	}

	private void Update()
	{
		UpdateLight();
		CheckTimeOfDay();
		currentTime += Time.deltaTime / SecondsInAFullDay * timeMultiplier;
		if (currentTime >= 1f)
		{
			currentTime = 0f;
			currentDay++;
		}
	}

	private void UpdateLight()
	{
		StarDome.transform.Rotate(new Vector3(0f, 0f, 2f * Time.deltaTime));
		directionalLight.transform.localRotation = Quaternion.Euler(currentTime * 360f - 90f, 170f, 0f);
		float num = 1f;
		if (currentTime <= 0.23f || currentTime >= 0.75f)
		{
			num = 0f;
			starMat.color = new Color(1f, 1f, 1f, Mathf.Lerp(1f, 0f, Time.deltaTime));
		}
		else if (currentTime <= 0.25f)
		{
			num = Mathf.Clamp01((currentTime - 0.23f) * 50f);
			starMat.color = new Color(1f, 1f, 1f, Mathf.Lerp(0f, 1f, Time.deltaTime));
		}
		else if (currentTime <= 0.73f)
		{
			num = Mathf.Clamp01(1f - (currentTime - 0.73f) * 50f);
		}
		directionalLight.intensity = lightIntensity * num;
	}

	private void CheckTimeOfDay()
	{
		if (currentTime < 0.25f || currentTime > 1f)
		{
			DayState = "Midnight";
		}
		if (currentTime > 0.25f)
		{
			DayState = "Morning";
		}
		if (currentTime > 0.25f && currentTime < 0.5f)
		{
			DayState = "Mid Noon";
		}
		if (currentTime > 0.5f && currentTime < 0.75f)
		{
			DayState = "Evening";
		}
		if (currentTime > 0.75f && currentTime < 1f)
		{
			DayState = "Night";
		}
	}

	private void OnGUI()
	{
		GUI.Box(new Rect(15f, 15f, 100f, 25f), "Day: " + currentDay);
		GUI.Box(new Rect(40f, 40f, 200f, 30f), string.Empty + DayState);
	}
}
