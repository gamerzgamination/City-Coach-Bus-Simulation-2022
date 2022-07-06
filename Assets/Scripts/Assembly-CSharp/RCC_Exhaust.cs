using UnityEngine;

[AddComponentMenu("BoneCracker Games/Realistic Car Controller/Misc/Exhaust")]
public class RCC_Exhaust : MonoBehaviour
{
	private RCC_CarControllerV3 carController;

	private ParticleSystem particle;

	private ParticleSystem.EmissionModule emission;

	private ParticleSystem.MinMaxCurve emissionRate;

	public ParticleSystem flame;

	private ParticleSystem.EmissionModule subEmission;

	private ParticleSystem.MinMaxCurve subEmissionRate;

	private Light flameLight;

	public float flameTime;

	private AudioSource flameSource;

	public Color flameColor = Color.red;

	public Color boostFlameColor = Color.blue;

	private void Start()
	{
		carController = GetComponentInParent<RCC_CarControllerV3>();
		particle = GetComponent<ParticleSystem>();
		emission = particle.emission;
		if ((bool)flame)
		{
			subEmission = flame.emission;
			flameLight = flame.GetComponentInChildren<Light>();
			flameSource = RCC_CreateAudioSource.NewAudioSource(base.gameObject, "Exhaust Flame AudioSource", 10f, 50f, 10f, RCC_Settings.Instance.exhaustFlameClips[0], loop: false, playNow: false, destroyAfterFinished: false);
		}
	}

	private void Update()
	{
		if (!carController || !particle)
		{
			return;
		}
		if (carController.engineRunning)
		{
			if (carController.speed < 150f)
			{
				if (!emission.enabled)
				{
					emission.enabled = true;
				}
				if (carController._gasInput > 0.05f)
				{
					emissionRate.constantMax = 50f;
					emission.rate = emissionRate;
					particle.startSpeed = 5f;
					particle.startSize = 8f;
				}
				else
				{
					emissionRate.constantMax = 5f;
					emission.rate = emissionRate;
					particle.startSpeed = 0.5f;
					particle.startSize = 4f;
				}
			}
			else if (emission.enabled)
			{
				emission.enabled = false;
			}
			if (carController._gasInput >= 0.25f)
			{
				flameTime = 0f;
			}
			if ((carController.useExhaustFlame && carController.engineRPM >= 5000f && carController.engineRPM <= 5500f && carController._gasInput <= 0.25f && flameTime <= 0.5f) || carController._boostInput >= 1.5f)
			{
				flameTime += Time.deltaTime;
				subEmission.enabled = true;
				if ((bool)flameLight)
				{
					flameLight.intensity = flameSource.pitch * 3f * Random.Range(0.25f, 1f);
				}
				if (carController._boostInput >= 1.5f && (bool)flame)
				{
					flame.startColor = boostFlameColor;
					flameLight.color = flame.startColor;
				}
				else
				{
					flame.startColor = flameColor;
					flameLight.color = flame.startColor;
				}
				if (!flameSource.isPlaying)
				{
					flameSource.clip = RCC_Settings.Instance.exhaustFlameClips[Random.Range(0, RCC_Settings.Instance.exhaustFlameClips.Length)];
					flameSource.Play();
				}
			}
			else
			{
				subEmission.enabled = false;
				if ((bool)flameLight)
				{
					flameLight.intensity = 0f;
				}
				if (flameSource.isPlaying)
				{
					flameSource.Stop();
				}
			}
		}
		else
		{
			if (emission.enabled)
			{
				emission.enabled = false;
			}
			subEmission.enabled = false;
			if ((bool)flameLight)
			{
				flameLight.intensity = 0f;
			}
			if (flameSource.isPlaying)
			{
				flameSource.Stop();
			}
		}
	}
}
