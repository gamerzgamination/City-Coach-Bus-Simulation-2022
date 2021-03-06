using UnityEngine;

[AddComponentMenu("BoneCracker Games/Realistic Car Controller/Light/Light")]
public class RCC_Light : MonoBehaviour
{
	public enum LightType
	{
		HeadLight,
		BrakeLight,
		ReverseLight,
		Indicator
	}

	private RCC_CarControllerV3 carController;

	private Light _light;

	private Projector projector;

	public LightType lightType;

	private RCC_CarControllerV3.IndicatorsOn indicatorsOn;

	private AudioSource indicatorSound;

	public AudioClip indicatorClip => RCC_Settings.Instance.indicatorClip;

	private void Start()
	{
		carController = GetComponentInParent<RCC_CarControllerV3>();
		_light = GetComponent<Light>();
		_light.enabled = true;
		if (RCC_Settings.Instance.useLightProjectorForLightingEffect)
		{
			projector = GetComponent<Projector>();
			if (projector == null)
			{
				projector = Object.Instantiate(RCC_Settings.Instance.projector, base.transform.position, base.transform.rotation).GetComponent<Projector>();
				projector.transform.SetParent(base.transform, worldPositionStays: true);
			}
			projector.ignoreLayers = RCC_Settings.Instance.projectorIgnoreLayer;
			if (lightType != 0)
			{
				projector.transform.localRotation = Quaternion.Euler(20f, (!(base.transform.localPosition.z > 0f)) ? 180f : 0f, 0f);
			}
			Material material = new Material(projector.material);
			projector.material = material;
		}
		if (RCC_Settings.Instance.useLightsAsVertexLights)
		{
			_light.renderMode = LightRenderMode.ForceVertex;
			_light.cullingMask = 0;
		}
		else
		{
			_light.renderMode = LightRenderMode.ForcePixel;
		}
		if (lightType == LightType.Indicator)
		{
			if (!carController.transform.Find("All Audio Sources/Indicator Sound AudioSource"))
			{
				indicatorSound = RCC_CreateAudioSource.NewAudioSource(carController.gameObject, "Indicator Sound AudioSource", 3f, 10f, 1f, indicatorClip, loop: false, playNow: false, destroyAfterFinished: false);
			}
			else
			{
				indicatorSound = carController.transform.Find("All Audio Sources/Indicator Sound AudioSource").GetComponent<AudioSource>();
			}
		}
	}

	private void Update()
	{
		if (RCC_Settings.Instance.useLightProjectorForLightingEffect)
		{
			Projectors();
		}
		switch (lightType)
		{
		case LightType.HeadLight:
			if (!carController.lowBeamHeadLightsOn && !carController.highBeamHeadLightsOn)
			{
				Lighting(0f);
			}
			if (carController.lowBeamHeadLightsOn && !carController.highBeamHeadLightsOn)
			{
				Lighting(0.6f, 50f, 90f);
				base.transform.localEulerAngles = new Vector3(10f, 0f, 0f);
			}
			else if (carController.highBeamHeadLightsOn)
			{
				Lighting(1f, 200f, 45f);
				base.transform.localEulerAngles = new Vector3(0f, 0f, 0f);
			}
			break;
		case LightType.BrakeLight:
			Lighting(carController.lowBeamHeadLightsOn ? Mathf.Clamp(carController._brakeInput * 10f, 0.3f, 1f) : Mathf.Clamp01(carController._brakeInput * 10f));
			break;
		case LightType.ReverseLight:
			Lighting((carController.direction != -1) ? 0f : 1f);
			break;
		case LightType.Indicator:
			indicatorsOn = carController.indicatorsOn;
			Indicators();
			break;
		}
	}

	private void Lighting(float input)
	{
		_light.intensity = input;
	}

	private void Lighting(float input, float range, float spotAngle)
	{
		_light.intensity = input;
		_light.range = range;
		_light.spotAngle = spotAngle;
	}

	private void Indicators()
	{
		switch (indicatorsOn)
		{
		case RCC_CarControllerV3.IndicatorsOn.Left:
			if (base.transform.localPosition.x > 0f)
			{
				_light.intensity = 0f;
				break;
			}
			if (carController.indicatorTimer >= 0.5f)
			{
				_light.intensity = 0f;
				if (indicatorSound.isPlaying)
				{
					indicatorSound.Stop();
				}
			}
			else
			{
				_light.intensity = 1f;
				if (!indicatorSound.isPlaying && carController.indicatorTimer <= 0.05f)
				{
					indicatorSound.Play();
				}
			}
			if (carController.indicatorTimer >= 1f)
			{
				carController.indicatorTimer = 0f;
			}
			break;
		case RCC_CarControllerV3.IndicatorsOn.Right:
			if (base.transform.localPosition.x < 0f)
			{
				_light.intensity = 0f;
				break;
			}
			if (carController.indicatorTimer >= 0.5f)
			{
				_light.intensity = 0f;
				if (indicatorSound.isPlaying)
				{
					indicatorSound.Stop();
				}
			}
			else
			{
				_light.intensity = 1f;
				if (!indicatorSound.isPlaying && carController.indicatorTimer <= 0.05f)
				{
					indicatorSound.Play();
				}
			}
			if (carController.indicatorTimer >= 1f)
			{
				carController.indicatorTimer = 0f;
			}
			break;
		case RCC_CarControllerV3.IndicatorsOn.All:
			if (carController.indicatorTimer >= 0.5f)
			{
				_light.intensity = 0f;
				if (indicatorSound.isPlaying)
				{
					indicatorSound.Stop();
				}
			}
			else
			{
				_light.intensity = 1f;
				if (!indicatorSound.isPlaying && carController.indicatorTimer <= 0.05f)
				{
					indicatorSound.Play();
				}
			}
			if (carController.indicatorTimer >= 1f)
			{
				carController.indicatorTimer = 0f;
			}
			break;
		case RCC_CarControllerV3.IndicatorsOn.Off:
			_light.intensity = 0f;
			carController.indicatorTimer = 0f;
			break;
		}
	}

	private void Projectors()
	{
		if (!_light.enabled)
		{
			projector.enabled = false;
			return;
		}
		projector.enabled = true;
		projector.material.color = _light.color * _light.intensity;
		projector.farClipPlane = Mathf.Lerp(10f, 40f, (_light.range - 50f) / 150f);
		projector.fieldOfView = Mathf.Lerp(40f, 30f, (_light.range - 50f) / 150f);
	}
}
