using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("BoneCracker Games/Realistic Car Controller/Realistic Car Controller V3")]
[RequireComponent(typeof(Rigidbody))]
public class RCC_CarControllerV3 : MonoBehaviour
{
	public enum WheelType
	{
		FWD,
		RWD,
		AWD,
		BIASED
	}

	public enum IndicatorsOn
	{
		Off,
		Right,
		Left,
		All
	}

	private struct originalMeshVerts
	{
		public Vector3[] meshVerts;
	}

	public static RCC_CarControllerV3 instance;

	private Rigidbody rigid;

	internal bool sleepingRigid;

	public bool AIController;

	public Transform FrontLeftWheelTransform;

	public Transform FrontRightWheelTransform;

	public Transform RearLeftWheelTransform;

	public Transform RearRightWheelTransform;

	public RCC_WheelCollider FrontLeftWheelCollider;

	public RCC_WheelCollider FrontRightWheelCollider;

	public RCC_WheelCollider RearLeftWheelCollider;

	public RCC_WheelCollider RearRightWheelCollider;

	private RCC_WheelCollider FrontLeftRCCWheelCollider;

	private RCC_WheelCollider FrontRightRCCWheelCollider;

	internal RCC_WheelCollider[] allWheelColliders;

	public Transform[] ExtraRearWheelsTransform;

	public RCC_WheelCollider[] ExtraRearWheelsCollider;

	public bool applyEngineTorqueToExtraRearWheelColliders = true;

	public Transform SteeringWheel;

	public WheelType _wheelTypeChoise = WheelType.RWD;

	[Range(0f, 100f)]
	public float biasedWheelTorque = 100f;

	public Transform COM;

	public bool canControl = true;

	public bool engineRunning;

	public bool semiAutomaticGear;

	public bool automaticClutch = true;

	private bool canGoReverseNow;

	public AnimationCurve[] engineTorqueCurve;

	public float[] gearSpeed;

	public float engineTorque = 3000f;

	public float maxEngineRPM = 7000f;

	public float minEngineRPM = 1000f;

	[Range(0.75f, 2f)]
	public float engineInertia = 1f;

	public bool useRevLimiter = true;

	public bool useExhaustFlame = true;

	public float steerAngle = 40f;

	public float highspeedsteerAngle = 15f;

	public float highspeedsteerAngleAtspeed = 100f;

	public float antiRollFrontHorizontal = 5000f;

	public float antiRollRearHorizontal = 5000f;

	public float antiRollVertical = 500f;

	public float downForce = 25f;

	public float speed;

	public float brake = 2500f;

	private float defMaxSpeed;

	public float maxspeed = 220f;

	private float resetTime;

	private float orgSteerAngle;

	public float fuelInput = 1f;

	public int currentGear;

	public int totalGears = 6;

	[Range(0f, 0.5f)]
	public float gearShiftingDelay = 0.35f;

	public bool changingGear;

	public int direction = 1;

	public bool autoGenerateGearCurves = true;

	public bool autoGenerateTargetSpeedsForChangingGear = true;

	private bool engineStarting;

	private AudioSource engineStartSound;

	public AudioClip engineStartClip;

	internal AudioSource engineSoundOn;

	public AudioClip engineClipOn;

	private AudioSource engineSoundOff;

	public AudioClip engineClipOff;

	private AudioSource engineSoundIdle;

	public AudioClip engineClipIdle;

	private AudioSource gearShiftingSound;

	private AudioSource crashSound;

	private AudioSource reversingSound;

	private AudioSource windSound;

	private AudioSource brakeSound;

	private AudioSource NOSSound;

	private AudioSource turboSound;

	private AudioSource blowSound;

	[Range(0.25f, 1f)]
	public float minEngineSoundPitch = 0.75f;

	[Range(1.25f, 2f)]
	public float maxEngineSoundPitch = 1.75f;

	[Range(0f, 1f)]
	public float minEngineSoundVolume = 0.05f;

	[Range(0f, 1f)]
	public float maxEngineSoundVolume = 0.85f;

	private GameObject allAudioSources;

	private GameObject allContactParticles;

	[HideInInspector]
	public float gasInput;

	[HideInInspector]
	public float brakeInput;

	[HideInInspector]
	public float steerInput;

	[HideInInspector]
	public float clutchInput;

	[HideInInspector]
	public float handbrakeInput;

	[HideInInspector]
	public float boostInput = 1f;

	[HideInInspector]
	public bool cutGas;

	[HideInInspector]
	public float idleInput;

	internal float engineRPM;

	internal float rawEngineRPM;

	public GameObject chassis;

	public bool lowBeamHeadLightsOn;

	public bool highBeamHeadLightsOn;

	public IndicatorsOn indicatorsOn;

	public float indicatorTimer;

	public bool useDamage = true;

	public MeshFilter[] deformableMeshFilters;

	public float randomizeVertices = 1f;

	public float damageRadius = 0.5f;

	private float minimumVertDistanceForDamagedMesh = 0.002f;

	private Vector3[] colliderVerts;

	private originalMeshVerts[] originalMeshData;

	[HideInInspector]
	public bool sleep = true;

	public float maximumDamage = 0.5f;

	private float minimumCollisionForce = 5f;

	public float damageMultiplier = 1f;

	public int maximumContactSparkle = 5;

	private List<ParticleSystem> contactSparkeList = new List<ParticleSystem>();

	public bool repairNow;

	private Vector3 localVector;

	private Quaternion rot = Quaternion.identity;

	private float oldRotation;

	public bool ABS = true;

	public bool TCS = true;

	public bool ESP = true;

	public bool steeringHelper = true;

	public bool tractionHelper = true;

	public bool ABSAct;

	public bool TCSAct;

	public bool ESPAct;

	[Range(0.05f, 0.5f)]
	public float ABSThreshold = 0.35f;

	[Range(0.05f, 0.5f)]
	public float TCSThreshold = 0.25f;

	[Range(0f, 1f)]
	public float TCSStrength = 1f;

	[Range(0.05f, 0.5f)]
	public float ESPThreshold = 0.25f;

	[Range(0.1f, 1f)]
	public float ESPStrength = 0.5f;

	[Range(0f, 1f)]
	public float steerHelperStrength = 0.1f;

	[Range(0f, 1f)]
	public float tractionHelperStrength = 0.1f;

	public bool overSteering;

	public bool underSteering;

	internal float driftAngle;

	internal bool driftingNow;

	private bool applyCounterSteering;

	public float frontCamber;

	public float rearCamber;

	public float frontSlip;

	public float rearSlip;

	private float angle;

	private float angularVelo;

	public float turboBoost;

	public float NoS = 100f;

	private float NoSConsumption = 25f;

	private float NoSRegenerateTime = 10f;

	public bool useNOS;

	public bool useTurbo;

	private RCC_Settings RCCSettings => RCC_Settings.Instance;

	public bool runEngineAtAwake => RCCSettings.runEngineAtAwake;

	public bool autoReverse => RCCSettings.autoReverse;

	public bool automaticGear => RCCSettings.useAutomaticGear;

	private AudioClip[] gearShiftingClips => RCCSettings.gearShiftingClips;

	private AudioClip[] crashClips => RCCSettings.crashClips;

	private AudioClip reversingClip => RCCSettings.reversingClip;

	private AudioClip windClip => RCCSettings.windClip;

	private AudioClip brakeClip => RCCSettings.brakeClip;

	private AudioClip NOSClip => RCCSettings.NOSClip;

	private AudioClip turboClip => RCCSettings.turboClip;

	private AudioClip blowClip => RCCSettings.turboClip;

	internal float _gasInput
	{
		get
		{
			if (fuelInput <= 0.25f)
			{
				return 0f;
			}
			if (!automaticGear || semiAutomaticGear)
			{
				if (!changingGear && !cutGas)
				{
					return Mathf.Clamp01(gasInput);
				}
				return 0f;
			}
			if (!changingGear && !cutGas)
			{
				return (direction != 1) ? Mathf.Clamp01(brakeInput) : Mathf.Clamp01(gasInput);
			}
			return 0f;
		}
		set
		{
			gasInput = value;
		}
	}

	internal float _brakeInput
	{
		get
		{
			if (!automaticGear || semiAutomaticGear)
			{
				return Mathf.Clamp01(brakeInput);
			}
			if (!cutGas)
			{
				return (direction != 1) ? Mathf.Clamp01(gasInput) : Mathf.Clamp01(brakeInput);
			}
			return 0f;
		}
		set
		{
			brakeInput = value;
		}
	}

	internal float _boostInput
	{
		get
		{
			if (useNOS && NoS > 5f && _gasInput >= 0.5f)
			{
				return boostInput;
			}
			return 1f;
		}
		set
		{
			boostInput = value;
		}
	}

	public GameObject contactSparkle => RCCSettings.contactParticles;

	private void Awake()
	{
		Time.fixedDeltaTime = RCCSettings.fixedTimeStep;
		rigid = GetComponent<Rigidbody>();
		rigid.maxAngularVelocity = RCCSettings.maxAngularVelocity;
		rigid.drag = 0.05f;
		rigid.angularDrag = 0.5f;
		allWheelColliders = GetComponentsInChildren<RCC_WheelCollider>();
		FrontLeftRCCWheelCollider = FrontLeftWheelCollider.GetComponent<RCC_WheelCollider>();
		FrontRightRCCWheelCollider = FrontRightWheelCollider.GetComponent<RCC_WheelCollider>();
		FrontLeftWheelCollider.wheelModel = FrontLeftWheelTransform;
		FrontRightWheelCollider.wheelModel = FrontRightWheelTransform;
		RearLeftWheelCollider.wheelModel = RearLeftWheelTransform;
		RearRightWheelCollider.wheelModel = RearRightWheelTransform;
		for (int i = 0; i < ExtraRearWheelsCollider.Length; i++)
		{
			ExtraRearWheelsCollider[i].wheelModel = ExtraRearWheelsTransform[i];
		}
		orgSteerAngle = steerAngle;
		allAudioSources = new GameObject("All Audio Sources");
		allAudioSources.transform.SetParent(base.transform, worldPositionStays: false);
		allContactParticles = new GameObject("All Contact Particles");
		allContactParticles.transform.SetParent(base.transform, worldPositionStays: false);
		switch (RCCSettings.behaviorType)
		{
		case RCC_Settings.BehaviorType.SemiArcade:
			steeringHelper = true;
			tractionHelper = true;
			ABS = false;
			ESP = false;
			TCS = false;
			steerHelperStrength = Mathf.Clamp(steerHelperStrength, 0.25f, 1f);
			tractionHelperStrength = Mathf.Clamp(tractionHelperStrength, 0.25f, 1f);
			antiRollFrontHorizontal = Mathf.Clamp(antiRollFrontHorizontal, 10000f, float.PositiveInfinity);
			antiRollRearHorizontal = Mathf.Clamp(antiRollRearHorizontal, 10000f, float.PositiveInfinity);
			break;
		case RCC_Settings.BehaviorType.Drift:
			steeringHelper = false;
			tractionHelper = false;
			ABS = false;
			ESP = false;
			TCS = false;
			highspeedsteerAngle = Mathf.Clamp(highspeedsteerAngle, 40f, 50f);
			highspeedsteerAngleAtspeed = Mathf.Clamp(highspeedsteerAngleAtspeed, 100f, maxspeed);
			applyCounterSteering = true;
			engineTorque = Mathf.Clamp(engineTorque, 5000f, float.PositiveInfinity);
			antiRollFrontHorizontal = Mathf.Clamp(antiRollFrontHorizontal, 3500f, float.PositiveInfinity);
			antiRollRearHorizontal = Mathf.Clamp(antiRollRearHorizontal, 3500f, float.PositiveInfinity);
			gearShiftingDelay = Mathf.Clamp(gearShiftingDelay, 0f, 0.15f);
			break;
		case RCC_Settings.BehaviorType.Fun:
			steeringHelper = false;
			tractionHelper = false;
			ABS = false;
			ESP = false;
			TCS = false;
			highspeedsteerAngle = Mathf.Clamp(highspeedsteerAngle, 30f, 50f);
			highspeedsteerAngleAtspeed = Mathf.Clamp(highspeedsteerAngleAtspeed, 100f, maxspeed);
			antiRollFrontHorizontal = Mathf.Clamp(antiRollFrontHorizontal, 50000f, float.PositiveInfinity);
			antiRollRearHorizontal = Mathf.Clamp(antiRollRearHorizontal, 50000f, float.PositiveInfinity);
			gearShiftingDelay = Mathf.Clamp(gearShiftingDelay, 0f, 0.1f);
			break;
		case RCC_Settings.BehaviorType.Racing:
			steeringHelper = true;
			tractionHelper = true;
			steerHelperStrength = Mathf.Clamp(steerHelperStrength, 0.25f, 1f);
			tractionHelperStrength = Mathf.Clamp(tractionHelperStrength, 0.25f, 1f);
			antiRollFrontHorizontal = Mathf.Clamp(antiRollFrontHorizontal, 10000f, float.PositiveInfinity);
			antiRollRearHorizontal = Mathf.Clamp(antiRollRearHorizontal, 10000f, float.PositiveInfinity);
			break;
		case RCC_Settings.BehaviorType.Simulator:
			antiRollFrontHorizontal = Mathf.Clamp(antiRollFrontHorizontal, 2500f, float.PositiveInfinity);
			antiRollRearHorizontal = Mathf.Clamp(antiRollRearHorizontal, 2500f, float.PositiveInfinity);
			break;
		}
	}

	private void Start()
	{
		instance = this;
		engineRunning = true;
		if ((bool)GetComponent<RCC_AICarController>())
		{
			AIController = true;
		}
		if (autoGenerateGearCurves)
		{
			TorqueCurve();
		}
		SoundsInitialize();
		if (useDamage)
		{
			DamageInit();
		}
		if (runEngineAtAwake)
		{
			KillOrStartEngine();
		}
		ChassisJoint();
		rigid.centerOfMass = base.transform.InverseTransformPoint(COM.transform.position);
		//if (canControl)
		//{
		//	if (RCC_Settings.Instance.controllerType == RCC_Settings.ControllerType.Mobile)
		//	{
		//		UnityEngine.Object.FindObjectOfType<RCC_MobileButtons>().GetVehicles();
		//	}
		//	if ((bool)UnityEngine.Object.FindObjectOfType<RCC_DashboardInputs>())
		//	{
		//		UnityEngine.Object.FindObjectOfType<RCC_DashboardInputs>().GetVehicle(this);
		//	}
		//}
	}

	private void OnEnable()
	{
		StartCoroutine("ReEnable");
	}

	private IEnumerator ReEnable()
	{
		if (!chassis.GetComponentInParent<ConfigurableJoint>())
		{
			yield return null;
		}
		GameObject _joint = chassis.GetComponentInParent<ConfigurableJoint>().gameObject;
		_joint.SetActive(value: false);
		yield return new WaitForFixedUpdate();
		_joint.SetActive(value: true);
		rigid.centerOfMass = base.transform.InverseTransformPoint(COM.transform.position);
		changingGear = false;
	}

	public void CreateWheelColliders()
	{
		List<Transform> list = new List<Transform>();
		list.Add(FrontLeftWheelTransform);
		list.Add(FrontRightWheelTransform);
		list.Add(RearLeftWheelTransform);
		list.Add(RearRightWheelTransform);
		if (list != null && list[0] == null)
		{
			Debug.LogError("You haven't choose your Wheel Models. Please select all of your Wheel Models before creating Wheel Colliders. Script needs to know their sizes and positions, aye?");
			return;
		}
		base.transform.rotation = Quaternion.identity;
		GameObject gameObject = new GameObject("Wheel Colliders");
		gameObject.transform.SetParent(base.transform, worldPositionStays: false);
		gameObject.transform.localRotation = Quaternion.identity;
		gameObject.transform.localPosition = Vector3.zero;
		gameObject.transform.localScale = Vector3.one;
		foreach (Transform item in list)
		{
			GameObject gameObject2 = new GameObject(item.transform.name);
			gameObject2.transform.position = item.transform.position;
			gameObject2.transform.rotation = base.transform.rotation;
			gameObject2.transform.name = item.transform.name;
			gameObject2.transform.SetParent(gameObject.transform);
			gameObject2.transform.localScale = Vector3.one;
			gameObject2.AddComponent<WheelCollider>();
			Bounds bounds = default(Bounds);
			Renderer[] componentsInChildren = item.GetComponentsInChildren<Renderer>();
			Renderer[] array = componentsInChildren;
			foreach (Renderer renderer in array)
			{
				if (renderer != GetComponent<Renderer>() && renderer.bounds.size.z > bounds.size.z)
				{
					bounds = renderer.bounds;
				}
			}
			gameObject2.GetComponent<WheelCollider>().radius = bounds.extents.y / base.transform.localScale.y;
			gameObject2.AddComponent<RCC_WheelCollider>();
			JointSpring suspensionSpring = gameObject2.GetComponent<WheelCollider>().suspensionSpring;
			suspensionSpring.spring = 40000f;
			suspensionSpring.damper = 2000f;
			suspensionSpring.targetPosition = 0.4f;
			gameObject2.GetComponent<WheelCollider>().suspensionSpring = suspensionSpring;
			gameObject2.GetComponent<WheelCollider>().suspensionDistance = 0.2f;
			gameObject2.GetComponent<WheelCollider>().forceAppPointDistance = 0.1f;
			gameObject2.GetComponent<WheelCollider>().mass = 40f;
			gameObject2.GetComponent<WheelCollider>().wheelDampingRate = 1f;
			WheelFrictionCurve sidewaysFriction = gameObject2.GetComponent<WheelCollider>().sidewaysFriction;
			WheelFrictionCurve forwardFriction = gameObject2.GetComponent<WheelCollider>().forwardFriction;
			gameObject2.transform.localPosition = new Vector3(gameObject2.transform.localPosition.x, gameObject2.transform.localPosition.y + gameObject2.GetComponent<WheelCollider>().suspensionDistance, gameObject2.transform.localPosition.z);
			forwardFriction.extremumSlip = 0.2f;
			forwardFriction.extremumValue = 1f;
			forwardFriction.asymptoteSlip = 0.8f;
			forwardFriction.asymptoteValue = 0.75f;
			forwardFriction.stiffness = 1.5f;
			sidewaysFriction.extremumSlip = 0.25f;
			sidewaysFriction.extremumValue = 1f;
			sidewaysFriction.asymptoteSlip = 0.5f;
			sidewaysFriction.asymptoteValue = 0.75f;
			sidewaysFriction.stiffness = 1.5f;
			gameObject2.GetComponent<WheelCollider>().sidewaysFriction = sidewaysFriction;
			gameObject2.GetComponent<WheelCollider>().forwardFriction = forwardFriction;
		}
		RCC_WheelCollider[] array2 = new RCC_WheelCollider[list.Count];
		array2 = GetComponentsInChildren<RCC_WheelCollider>();
		FrontLeftWheelCollider = array2[0];
		FrontRightWheelCollider = array2[1];
		RearLeftWheelCollider = array2[2];
		RearRightWheelCollider = array2[3];
	}

	private void SoundsInitialize()
	{
		engineSoundOn = RCC_CreateAudioSource.NewAudioSource(base.gameObject, "Engine Sound On AudioSource", 5f, 100f, 0f, engineClipOn, loop: true, playNow: true, destroyAfterFinished: false);
		engineSoundOff = RCC_CreateAudioSource.NewAudioSource(base.gameObject, "Engine Sound Off AudioSource", 5f, 100f, 0f, engineClipOff, loop: true, playNow: true, destroyAfterFinished: false);
		engineSoundIdle = RCC_CreateAudioSource.NewAudioSource(base.gameObject, "Engine Sound Idle AudioSource", 5f, 100f, 0f, engineClipIdle, loop: true, playNow: true, destroyAfterFinished: false);
		reversingSound = RCC_CreateAudioSource.NewAudioSource(base.gameObject, "Reverse Sound AudioSource", 5f, 10f, 0f, reversingClip, loop: true, playNow: false, destroyAfterFinished: false);
		windSound = RCC_CreateAudioSource.NewAudioSource(base.gameObject, "Wind Sound AudioSource", 5f, 10f, 0f, windClip, loop: true, playNow: true, destroyAfterFinished: false);
		brakeSound = RCC_CreateAudioSource.NewAudioSource(base.gameObject, "Brake Sound AudioSource", 5f, 10f, 0f, brakeClip, loop: true, playNow: true, destroyAfterFinished: false);
		if (useNOS)
		{
			NOSSound = RCC_CreateAudioSource.NewAudioSource(base.gameObject, "NOS Sound AudioSource", 5f, 10f, 1f, NOSClip, loop: true, playNow: false, destroyAfterFinished: false);
		}
		if (useNOS || useTurbo)
		{
			blowSound = RCC_CreateAudioSource.NewAudioSource(base.gameObject, "NOS Blow", 3f, 10f, 1f, null, loop: false, playNow: false, destroyAfterFinished: false);
		}
		if (useTurbo)
		{
			turboSound = RCC_CreateAudioSource.NewAudioSource(base.gameObject, "Turbo Sound AudioSource", 0.1f, 0.5f, 0f, turboClip, loop: true, playNow: true, destroyAfterFinished: false);
			RCC_CreateAudioSource.NewHighPassFilter(turboSound, 10000f, 10);
		}
	}

	public void KillOrStartEngine()
	{
		if (engineRunning && !engineStarting)
		{
			engineRunning = false;
			Toolbox.HUDListner.set_statusEngine(false);
			fuelInput = 0f;
		}
		else if (!engineStarting)
		{
			StartCoroutine("StartEngine");
		}
	}

	public IEnumerator StartEngine()
	{
		engineRunning = false;
		engineStarting = true;
		Toolbox.HUDListner.set_statusEngine(true); 
		engineStartSound = RCC_CreateAudioSource.NewAudioSource(base.gameObject, "Engine Start AudioSource", 5f, 10f, 1f, engineStartClip, loop: false, playNow: true, destroyAfterFinished: true);
		if (engineStartSound.isPlaying)
		{
			engineStartSound.Play();
		}
		yield return new WaitForSeconds(1f);
		engineRunning = true;
		fuelInput = 1f;
		yield return new WaitForSeconds(1f);
		engineStarting = false;
	}

	private void ChassisJoint()
	{
		GameObject gameObject = new GameObject("Colliders");
		gameObject.transform.SetParent(base.transform, worldPositionStays: false);
		Transform[] componentsInChildren = chassis.GetComponentsInChildren<Transform>();
		Transform[] array = componentsInChildren;
		foreach (Transform transform in array)
		{
			if (!transform.gameObject.activeSelf || !transform.GetComponent<Collider>())
			{
				continue;
			}
			GameObject gameObject2 = UnityEngine.Object.Instantiate(transform.gameObject, transform.transform.position, transform.transform.rotation);
			gameObject2.transform.SetParent(gameObject.transform, worldPositionStays: true);
			gameObject2.transform.localScale = transform.lossyScale;
			Component[] components = gameObject2.GetComponents(typeof(Component));
			Component[] array2 = components;
			foreach (Component component in array2)
			{
				if (!(component is Transform) && !(component is Collider))
				{
					UnityEngine.Object.Destroy(component);
				}
			}
		}
		GameObject gameObject3 = (GameObject)UnityEngine.Object.Instantiate(Resources.Load("RCCAssets/Chassis Joint", typeof(GameObject)), Vector3.zero, Quaternion.identity);
		gameObject3.transform.SetParent(base.transform, worldPositionStays: false);
		gameObject3.GetComponent<ConfigurableJoint>().connectedBody = rigid;
		chassis.transform.SetParent(gameObject3.transform, worldPositionStays: false);
		Collider[] componentsInChildren2 = chassis.GetComponentsInChildren<Collider>();
		Collider[] array3 = componentsInChildren2;
		foreach (Collider obj in array3)
		{
			UnityEngine.Object.Destroy(obj);
		}
		RCC_Settings.BehaviorType behaviorType = RCCSettings.behaviorType;
		if (behaviorType == RCC_Settings.BehaviorType.Fun)
		{
			SoftJointLimit softJointLimit = default(SoftJointLimit);
			softJointLimit.limit = -10f;
			gameObject3.GetComponent<ConfigurableJoint>().lowAngularXLimit = softJointLimit;
			softJointLimit.limit = 10f;
			gameObject3.GetComponent<ConfigurableJoint>().linearLimit = softJointLimit;
			gameObject3.GetComponent<ConfigurableJoint>().highAngularXLimit = softJointLimit;
			gameObject3.GetComponent<ConfigurableJoint>().angularYLimit = softJointLimit;
			gameObject3.GetComponent<ConfigurableJoint>().angularZLimit = softJointLimit;
			JointDrive jointDrive = default(JointDrive);
			jointDrive.positionSpring = 300f;
			jointDrive.positionDamper = 5f;
			jointDrive.maximumForce = gameObject3.GetComponent<ConfigurableJoint>().xDrive.maximumForce;
			gameObject3.GetComponent<ConfigurableJoint>().xDrive = jointDrive;
			gameObject3.GetComponent<ConfigurableJoint>().yDrive = jointDrive;
			gameObject3.GetComponent<ConfigurableJoint>().zDrive = jointDrive;
			gameObject3.GetComponent<ConfigurableJoint>().angularXDrive = jointDrive;
			gameObject3.GetComponent<ConfigurableJoint>().angularYZDrive = jointDrive;
			gameObject3.GetComponent<Rigidbody>().centerOfMass = base.transform.InverseTransformPoint(new Vector3(gameObject3.transform.position.x, gameObject3.transform.position.y + 1f, gameObject3.transform.position.z));
		}
	}

	private void DamageInit()
	{
		if (deformableMeshFilters.Length == 0)
		{
			MeshFilter[] componentsInChildren = GetComponentsInChildren<MeshFilter>();
			List<MeshFilter> list = new List<MeshFilter>();
			MeshFilter[] array = componentsInChildren;
			foreach (MeshFilter meshFilter in array)
			{
				if (!meshFilter.transform.IsChildOf(FrontLeftWheelTransform) && !meshFilter.transform.IsChildOf(FrontRightWheelTransform) && !meshFilter.transform.IsChildOf(RearLeftWheelTransform) && !meshFilter.transform.IsChildOf(RearRightWheelTransform))
				{
					list.Add(meshFilter);
				}
			}
			deformableMeshFilters = list.ToArray();
		}
		LoadOriginalMeshData();
		if ((bool)contactSparkle)
		{
			for (int j = 0; j < maximumContactSparkle; j++)
			{
				GameObject gameObject = UnityEngine.Object.Instantiate(contactSparkle, base.transform.position, Quaternion.identity);
				gameObject.transform.SetParent(allContactParticles.transform);
				contactSparkeList.Add(gameObject.GetComponent<ParticleSystem>());
				ParticleSystem.EmissionModule emission = gameObject.GetComponent<ParticleSystem>().emission;
				emission.enabled = false;
			}
		}
	}

	private void LoadOriginalMeshData()
	{
		originalMeshData = new originalMeshVerts[deformableMeshFilters.Length];
		for (int i = 0; i < deformableMeshFilters.Length; i++)
		{
			originalMeshData[i].meshVerts = deformableMeshFilters[i].mesh.vertices;
		}
	}

	private void Damage()
	{
		if (sleep || !repairNow)
		{
			return;
		}
		sleep = true;
		for (int i = 0; i < deformableMeshFilters.Length; i++)
		{
			Vector3[] vertices = deformableMeshFilters[i].mesh.vertices;
			if (originalMeshData == null)
			{
				LoadOriginalMeshData();
			}
			for (int j = 0; j < vertices.Length; j++)
			{
				vertices[j] += (originalMeshData[i].meshVerts[j] - vertices[j]) * (Time.deltaTime * 2f);
				if ((originalMeshData[i].meshVerts[j] - vertices[j]).magnitude >= minimumVertDistanceForDamagedMesh)
				{
					sleep = false;
				}
			}
			deformableMeshFilters[i].mesh.vertices = vertices;
			deformableMeshFilters[i].mesh.RecalculateNormals();
			deformableMeshFilters[i].mesh.RecalculateBounds();
		}
		if (sleep)
		{
			repairNow = false;
		}
	}

	private void DeformMesh(Mesh mesh, Vector3[] originalMesh, Collision collision, float cos, Transform meshTransform, Quaternion rot)
	{
		Vector3[] vertices = mesh.vertices;
		ContactPoint[] contacts = collision.contacts;
		foreach (ContactPoint contactPoint in contacts)
		{
			Vector3 vector = meshTransform.InverseTransformPoint(contactPoint.point);
			for (int j = 0; j < vertices.Length; j++)
			{
				if ((vector - vertices[j]).magnitude < damageRadius)
				{
					vertices[j] += rot * (localVector * (damageRadius - (vector - vertices[j]).magnitude) / damageRadius * cos + UnityEngine.Random.onUnitSphere * (randomizeVertices / 500f));
					if (maximumDamage > 0f && (vertices[j] - originalMesh[j]).magnitude > maximumDamage)
					{
						ref Vector3 reference = ref vertices[j];
						reference = originalMesh[j] + (vertices[j] - originalMesh[j]).normalized * maximumDamage;
					}
				}
			}
		}
		mesh.vertices = vertices;
		mesh.RecalculateBounds();
	}

	private void CollisionParticles(Vector3 contactPoint)
	{
		for (int i = 0; i < contactSparkeList.Count && !contactSparkeList[i].isPlaying; i++)
		{
			contactSparkeList[i].transform.position = contactPoint;
			ParticleSystem.EmissionModule emission = contactSparkeList[i].emission;
			emission.enabled = true;
			contactSparkeList[i].Play();
		}
	}

	private void Update()
	{
		if (canControl)
		{
			if (!AIController)
			{
				Inputs();
			}
			GearBox();
			Clutch();
		}
		else if (AIController)
		{
		}
		um_UmairIndicators();
		Turbo();
		Sounds();
		ResetCar();
		if (useDamage)
		{
			Damage();
		}
		indicatorTimer += Time.deltaTime;
	}

	public void um_UmairIndicators()
	{
		if (steerInput > 0.5f)
		{
			if (indicatorsOn != IndicatorsOn.Right)
			{
				indicatorsOn = IndicatorsOn.Right;
			}
		}
		else if (steerInput < -0.5f)
		{
			if (indicatorsOn != IndicatorsOn.Left)
			{
				indicatorsOn = IndicatorsOn.Left;
			}
		}
		else
		{
			indicatorsOn = IndicatorsOn.Off;
		}
	}

	private void Inputs()
	{
		if (RCCSettings.controllerType != 0)
		{
			return;
		}
		gasInput = Input.GetAxis(RCCSettings.verticalInput);
		brakeInput = Mathf.Clamp01(0f - Input.GetAxis(RCCSettings.verticalInput));
		handbrakeInput = ((!Input.GetKey(RCCSettings.handbrakeKB)) ? 0f : 1f);
		steerInput = Input.GetAxis(RCCSettings.horizontalInput);
		boostInput = ((!Input.GetKey(RCCSettings.boostKB)) ? 1f : 2.5f);
		if (Input.GetKeyDown(RCCSettings.lowBeamHeadlightsKB))
		{
			lowBeamHeadLightsOn = !lowBeamHeadLightsOn;
		}
		if (Input.GetKeyDown(RCCSettings.highBeamHeadlightsKB))
		{
			highBeamHeadLightsOn = true;
		}
		else if (Input.GetKeyUp(RCCSettings.highBeamHeadlightsKB))
		{
			highBeamHeadLightsOn = false;
		}
		if (Input.GetKeyDown(RCCSettings.startEngineKB))
		{
			KillOrStartEngine();
		}
		if (Input.GetKeyDown(RCCSettings.rightIndicatorKB))
		{
			if (indicatorsOn != IndicatorsOn.Right)
			{
				indicatorsOn = IndicatorsOn.Right;
			}
			else
			{
				indicatorsOn = IndicatorsOn.Off;
			}
		}
		if (Input.GetKeyDown(RCCSettings.leftIndicatorKB))
		{
			if (indicatorsOn != IndicatorsOn.Left)
			{
				indicatorsOn = IndicatorsOn.Left;
			}
			else
			{
				indicatorsOn = IndicatorsOn.Off;
			}
		}
		if (Input.GetKeyDown(RCCSettings.hazardIndicatorKB))
		{
			if (indicatorsOn != IndicatorsOn.All)
			{
				indicatorsOn = IndicatorsOn.Off;
				indicatorsOn = IndicatorsOn.All;
			}
			else
			{
				indicatorsOn = IndicatorsOn.Off;
			}
		}
		if (automaticGear)
		{
			return;
		}
		if (currentGear < totalGears - 1 && !changingGear && Input.GetKeyDown(RCCSettings.shiftGearUp))
		{
			if (direction != -1)
			{
				StartCoroutine("ChangingGear", currentGear + 1);
			}
			else
			{
				StartCoroutine("ChangingGear", 0);
			}
		}
		if (currentGear >= 0 && Input.GetKeyDown(RCCSettings.shiftGearDown))
		{
			StartCoroutine("ChangingGear", currentGear - 1);
		}
	}

	private void FixedUpdate()
	{
		Engine();
		Braking();
		AntiRollBars();
		DriftVariables();
		RevLimiter();
		NOS();
		ApplySteering(FrontLeftWheelCollider);
		ApplySteering(FrontRightWheelCollider);
		if (steeringHelper)
		{
			SteerHelper();
		}
		if (tractionHelper)
		{
			TractionHelper();
		}
		if (ESP)
		{
			ESPCheck(rigid.angularVelocity.y, FrontLeftWheelCollider.steerAngle);
		}
		if (autoGenerateGearCurves)
		{
			TorqueCurve();
		}
		if (RCCSettings.behaviorType == RCC_Settings.BehaviorType.Drift && RearLeftWheelCollider.isGrounded)
		{
			rigid.angularVelocity = new Vector3(rigid.angularVelocity.x, rigid.angularVelocity.y + (float)direction * steerInput / 30f, rigid.angularVelocity.z);
		}
		if ((RCCSettings.behaviorType == RCC_Settings.BehaviorType.SemiArcade || RCCSettings.behaviorType == RCC_Settings.BehaviorType.Fun) && RearLeftWheelCollider.isGrounded)
		{
			rigid.angularVelocity = new Vector3(rigid.angularVelocity.x, (float)direction * (steerInput * Mathf.Lerp(0f, 2f, speed / 20f)), rigid.angularVelocity.z);
		}
	}

	private void Engine()
	{
		speed = rigid.velocity.magnitude * 3.6f;
		steerAngle = Mathf.Lerp(orgSteerAngle, highspeedsteerAngle, speed / highspeedsteerAngleAtspeed);
		if ((bool)SteeringWheel)
		{
			SteeringWheel.transform.rotation = base.transform.rotation * Quaternion.Euler(20f, 0f, FrontLeftWheelCollider.steerAngle * -6f);
		}
		if (rigid.velocity.magnitude < 0.01f && Mathf.Abs(steerInput) < 0.01f && Mathf.Abs(_gasInput) < 0.01f && Mathf.Abs(rigid.angularVelocity.magnitude) < 0.01f)
		{
			sleepingRigid = true;
		}
		else
		{
			sleepingRigid = false;
		}
		rawEngineRPM = Mathf.Clamp(Mathf.MoveTowards(rawEngineRPM, maxEngineRPM * 1.1f * Mathf.Clamp01(Mathf.Lerp(0f, 1f, (1f - clutchInput) * ((RearLeftWheelCollider.wheelRPMToSpeed + RearRightWheelCollider.wheelRPMToSpeed) * (float)direction / 2f / gearSpeed[currentGear])) + (_gasInput * clutchInput + idleInput) * fuelInput), engineInertia * 100f), 0f, maxEngineRPM * 1.1f);
		engineRPM = Mathf.Lerp(engineRPM, rawEngineRPM, Mathf.Lerp(Time.fixedDeltaTime * 5f, Time.fixedDeltaTime * 50f, rawEngineRPM / maxEngineRPM));
		if (autoReverse)
		{
			canGoReverseNow = true;
		}
		else if (_brakeInput < 0.1f && speed < 5f)
		{
			canGoReverseNow = true;
		}
		else if (_brakeInput > 0f && base.transform.InverseTransformDirection(rigid.velocity).z > 1f)
		{
			canGoReverseNow = false;
		}
		switch (_wheelTypeChoise)
		{
		case WheelType.FWD:
			ApplyMotorTorque(FrontLeftWheelCollider, engineTorque);
			ApplyMotorTorque(FrontRightWheelCollider, engineTorque);
			break;
		case WheelType.RWD:
			ApplyMotorTorque(RearLeftWheelCollider, engineTorque);
			ApplyMotorTorque(RearRightWheelCollider, engineTorque);
			break;
		case WheelType.AWD:
			ApplyMotorTorque(FrontLeftWheelCollider, engineTorque / 2f);
			ApplyMotorTorque(FrontRightWheelCollider, engineTorque / 2f);
			ApplyMotorTorque(RearLeftWheelCollider, engineTorque / 2f);
			ApplyMotorTorque(RearRightWheelCollider, engineTorque / 2f);
			break;
		case WheelType.BIASED:
			ApplyMotorTorque(FrontLeftWheelCollider, engineTorque * (100f - biasedWheelTorque) / 100f);
			ApplyMotorTorque(FrontRightWheelCollider, engineTorque * (100f - biasedWheelTorque) / 100f);
			ApplyMotorTorque(RearLeftWheelCollider, engineTorque * biasedWheelTorque / 100f);
			ApplyMotorTorque(RearRightWheelCollider, engineTorque * biasedWheelTorque / 100f);
			break;
		}
		if (ExtraRearWheelsCollider.Length > 0 && applyEngineTorqueToExtraRearWheelColliders)
		{
			for (int i = 0; i < ExtraRearWheelsCollider.Length; i++)
			{
				ApplyMotorTorque(ExtraRearWheelsCollider[i], engineTorque);
			}
		}
	}

	private void Sounds()
	{
		windSound.volume = Mathf.Lerp(0f, RCCSettings.maxWindSoundVolume, speed / 300f);
		windSound.pitch = UnityEngine.Random.Range(0.9f, 1f);
		if (direction == 1)
		{
			brakeSound.volume = Mathf.Lerp(0f, RCCSettings.maxBrakeSoundVolume, Mathf.Clamp01((FrontLeftWheelCollider.wheelCollider.brakeTorque + FrontRightWheelCollider.wheelCollider.brakeTorque) / (brake * 2f)) * Mathf.Lerp(0f, 1f, FrontLeftWheelCollider.rpm / 50f));
		}
		else
		{
			brakeSound.volume = 0f;
		}
	}

	private void ApplyMotorTorque(RCC_WheelCollider wc, float torque)
	{
		if (TCS)
		{
			wc.wheelCollider.GetGroundHit(out var hit);
			if (Mathf.Abs(wc.rpm) >= 100f)
			{
				if (hit.forwardSlip > 0.25f)
				{
					TCSAct = true;
					torque -= Mathf.Clamp(torque * hit.forwardSlip * TCSStrength, 0f, engineTorque);
				}
				else
				{
					TCSAct = false;
					torque += Mathf.Clamp(torque * hit.forwardSlip * TCSStrength, 0f - engineTorque, 0f);
				}
			}
			else
			{
				TCSAct = false;
			}
		}
		if (OverTorque())
		{
			torque = 0f;
		}
		wc.wheelCollider.motorTorque = torque * (1f - clutchInput) * _boostInput * _gasInput * (engineTorqueCurve[currentGear].Evaluate(wc.wheelRPMToSpeed * (float)direction) * (float)direction);
		ApplyEngineSound(wc.wheelCollider.motorTorque);
	}

	private void ESPCheck(float velocity, float steering)
	{
		FrontLeftWheelCollider.wheelCollider.GetGroundHit(out var hit);
		FrontRightWheelCollider.wheelCollider.GetGroundHit(out var hit2);
		frontSlip = hit.sidewaysSlip + hit2.sidewaysSlip;
		RearLeftWheelCollider.wheelCollider.GetGroundHit(out var hit3);
		RearRightWheelCollider.wheelCollider.GetGroundHit(out var hit4);
		rearSlip = hit3.sidewaysSlip + hit4.sidewaysSlip;
		if (Mathf.Abs(frontSlip) >= ESPThreshold)
		{
			overSteering = true;
		}
		else
		{
			overSteering = false;
		}
		if (Mathf.Abs(rearSlip) >= ESPThreshold && !overSteering)
		{
			underSteering = true;
		}
		else
		{
			underSteering = false;
		}
		if (underSteering || overSteering)
		{
			ESPAct = true;
		}
		else
		{
			ESPAct = false;
		}
		if (!(Mathf.Abs(frontSlip) < ESPThreshold) && !(Math.Abs(rearSlip) < ESPThreshold))
		{
			if (underSteering)
			{
				ApplyBrakeTorque(RearLeftWheelCollider, brake * ESPStrength * Mathf.Clamp(frontSlip, 0f, float.PositiveInfinity));
				ApplyBrakeTorque(RearRightWheelCollider, brake * ESPStrength * Mathf.Clamp(0f - frontSlip, 0f, float.PositiveInfinity));
			}
			if (overSteering)
			{
				ApplyBrakeTorque(FrontLeftWheelCollider, brake * ESPStrength * Mathf.Clamp(0f - rearSlip, 0f, float.PositiveInfinity));
				ApplyBrakeTorque(FrontRightWheelCollider, brake * ESPStrength * Mathf.Clamp(rearSlip, 0f, float.PositiveInfinity));
			}
		}
	}

	private void ApplyBrakeTorque(RCC_WheelCollider wc, float brake)
	{
		if (ABS && handbrakeInput <= 0.1f)
		{
			wc.wheelCollider.GetGroundHit(out var hit);
			if (Mathf.Abs(hit.forwardSlip) * Mathf.Clamp01(brake) >= ABSThreshold)
			{
				ABSAct = true;
				brake = 0f;
			}
			else
			{
				ABSAct = false;
			}
		}
		wc.wheelCollider.brakeTorque = brake;
	}

	private void ApplySteering(RCC_WheelCollider wc)
	{
		if (applyCounterSteering)
		{
			wc.wheelCollider.steerAngle = Mathf.Clamp(steerAngle * (steerInput + driftAngle), 0f - steerAngle, steerAngle);
		}
		else
		{
			wc.wheelCollider.steerAngle = Mathf.Clamp(steerAngle * steerInput, 0f - steerAngle, steerAngle);
		}
	}

	private void ApplyEngineSound(float input)
	{
		if (!engineRunning)
		{
			engineSoundOn.pitch = Mathf.Lerp(engineSoundOn.pitch, 0f, Time.deltaTime * 50f);
			engineSoundOff.pitch = Mathf.Lerp(engineSoundOff.pitch, 0f, Time.deltaTime * 50f);
			engineSoundIdle.pitch = Mathf.Lerp(engineSoundOff.pitch, 0f, Time.deltaTime * 50f);
			if (engineSoundOn.pitch <= 0.1f && engineSoundOff.pitch <= 0.1f && engineSoundIdle.pitch <= 0.1f)
			{
				engineSoundOn.Stop();
				engineSoundOff.Stop();
				engineSoundIdle.Stop();
				return;
			}
		}
		else
		{
			if (!engineSoundOn.isPlaying)
			{
				engineSoundOn.Play();
			}
			if (!engineSoundOff.isPlaying)
			{
				engineSoundOff.Play();
			}
			if (!engineSoundIdle.isPlaying)
			{
				engineSoundIdle.Play();
			}
		}
		if ((bool)engineSoundOn)
		{
			engineSoundOn.volume = _gasInput;
			engineSoundOn.pitch = Mathf.Lerp(engineSoundOn.pitch, Mathf.Lerp(minEngineSoundPitch, maxEngineSoundPitch, engineRPM / 7000f), Time.deltaTime * 50f);
		}
		if ((bool)engineSoundOff)
		{
			engineSoundOff.volume = 1f - _gasInput - engineSoundIdle.volume;
			engineSoundOff.pitch = Mathf.Lerp(engineSoundOff.pitch, Mathf.Lerp(minEngineSoundPitch, maxEngineSoundPitch, engineRPM / 7000f), Time.deltaTime * 50f);
		}
		if ((bool)engineSoundIdle)
		{
			engineSoundIdle.volume = Mathf.Lerp(1f, 0f, engineRPM / (maxEngineRPM / 2f));
			engineSoundIdle.pitch = Mathf.Lerp(engineSoundIdle.pitch, Mathf.Lerp(minEngineSoundPitch, maxEngineSoundPitch, engineRPM / 7000f), Time.deltaTime * 50f);
		}
	}

	public void OffBusSounds()
	{
		engineSoundOn.Stop();
		engineSoundOff.Stop();
		engineSoundIdle.Stop();
	}

	private void Braking()
	{
		if (handbrakeInput > 0.1f)
		{
			ApplyBrakeTorque(RearLeftWheelCollider, brake * 1.5f * handbrakeInput);
			ApplyBrakeTorque(RearRightWheelCollider, brake * 1.5f * handbrakeInput);
			return;
		}
		ApplyBrakeTorque(FrontLeftWheelCollider, brake * Mathf.Clamp(_brakeInput, 0f, 1f));
		ApplyBrakeTorque(FrontRightWheelCollider, brake * Mathf.Clamp(_brakeInput, 0f, 1f));
		ApplyBrakeTorque(RearLeftWheelCollider, brake * Mathf.Clamp(_brakeInput, 0f, 1f) / 2f);
		ApplyBrakeTorque(RearRightWheelCollider, brake * Mathf.Clamp(_brakeInput, 0f, 1f) / 2f);
	}

	private void AntiRollBars()
	{
		float num = 1f;
		float num2 = 1f;
		WheelHit hit;
		bool groundHit = FrontLeftWheelCollider.wheelCollider.GetGroundHit(out hit);
		if (groundHit)
		{
			num = (0f - FrontLeftWheelCollider.transform.InverseTransformPoint(hit.point).y - FrontLeftWheelCollider.wheelCollider.radius) / FrontLeftWheelCollider.wheelCollider.suspensionDistance;
		}
		bool groundHit2 = FrontRightWheelCollider.wheelCollider.GetGroundHit(out hit);
		if (groundHit2)
		{
			num2 = (0f - FrontRightWheelCollider.transform.InverseTransformPoint(hit.point).y - FrontRightWheelCollider.wheelCollider.radius) / FrontRightWheelCollider.wheelCollider.suspensionDistance;
		}
		float num3 = (num - num2) * antiRollFrontHorizontal;
		if (groundHit)
		{
			rigid.AddForceAtPosition(FrontLeftWheelCollider.transform.up * (0f - num3), FrontLeftWheelCollider.transform.position);
		}
		if (groundHit2)
		{
			rigid.AddForceAtPosition(FrontRightWheelCollider.transform.up * num3, FrontRightWheelCollider.transform.position);
		}
		float num4 = 1f;
		float num5 = 1f;
		WheelHit hit2;
		bool groundHit3 = RearLeftWheelCollider.wheelCollider.GetGroundHit(out hit2);
		if (groundHit3)
		{
			num4 = (0f - RearLeftWheelCollider.transform.InverseTransformPoint(hit2.point).y - RearLeftWheelCollider.wheelCollider.radius) / RearLeftWheelCollider.wheelCollider.suspensionDistance;
		}
		bool groundHit4 = RearRightWheelCollider.wheelCollider.GetGroundHit(out hit2);
		if (groundHit4)
		{
			num5 = (0f - RearRightWheelCollider.transform.InverseTransformPoint(hit2.point).y - RearRightWheelCollider.wheelCollider.radius) / RearRightWheelCollider.wheelCollider.suspensionDistance;
		}
		float num6 = (num4 - num5) * antiRollRearHorizontal;
		if (groundHit3)
		{
			rigid.AddForceAtPosition(RearLeftWheelCollider.transform.up * (0f - num6), RearLeftWheelCollider.transform.position);
		}
		if (groundHit4)
		{
			rigid.AddForceAtPosition(RearRightWheelCollider.transform.up * num6, RearRightWheelCollider.transform.position);
		}
		float num7 = (num - num4) * antiRollVertical;
		if (groundHit)
		{
			rigid.AddForceAtPosition(FrontLeftWheelCollider.transform.up * (0f - num7), FrontLeftWheelCollider.transform.position);
		}
		if (groundHit3)
		{
			rigid.AddForceAtPosition(RearLeftWheelCollider.transform.up * num7, RearLeftWheelCollider.transform.position);
		}
		float num8 = (num2 - num5) * antiRollVertical;
		if (groundHit2)
		{
			rigid.AddForceAtPosition(FrontRightWheelCollider.transform.up * (0f - num8), FrontRightWheelCollider.transform.position);
		}
		if (groundHit4)
		{
			rigid.AddForceAtPosition(RearRightWheelCollider.transform.up * num8, RearRightWheelCollider.transform.position);
		}
	}

	private void SteerHelper()
	{
		for (int i = 0; i < allWheelColliders.Length; i++)
		{
			allWheelColliders[i].wheelCollider.GetGroundHit(out var hit);
			if (hit.normal == Vector3.zero)
			{
				return;
			}
		}
		if (Mathf.Abs(oldRotation - base.transform.eulerAngles.y) < 10f)
		{
			float num = (base.transform.eulerAngles.y - oldRotation) * steerHelperStrength;
			Quaternion quaternion = Quaternion.AngleAxis(num, Vector3.up);
			rigid.velocity = quaternion * rigid.velocity;
		}
		oldRotation = base.transform.eulerAngles.y;
	}

	private void TractionHelper()
	{
		Vector3 velocity = rigid.velocity;
		velocity -= base.transform.up * Vector3.Dot(velocity, base.transform.up);
		velocity.Normalize();
		angle = 0f - Mathf.Asin(Vector3.Dot(Vector3.Cross(base.transform.forward, velocity), base.transform.up));
		angularVelo = rigid.angularVelocity.y;
		if (angle * FrontLeftWheelCollider.steerAngle < 0f)
		{
			FrontLeftRCCWheelCollider.tractionHelpedSidewaysStiffness = 1f - Mathf.Clamp01(tractionHelperStrength * Mathf.Abs(angularVelo));
		}
		else
		{
			FrontLeftRCCWheelCollider.tractionHelpedSidewaysStiffness = 1f;
		}
		if (angle * FrontRightWheelCollider.steerAngle < 0f)
		{
			FrontRightRCCWheelCollider.tractionHelpedSidewaysStiffness = 1f - Mathf.Clamp01(tractionHelperStrength * Mathf.Abs(angularVelo));
		}
		else
		{
			FrontRightRCCWheelCollider.tractionHelpedSidewaysStiffness = 1f;
		}
	}

	private void Clutch()
	{
		if (speed <= 10f && !cutGas)
		{
			clutchInput = Mathf.Lerp(clutchInput, Mathf.Lerp(1f, Mathf.Lerp(0.2f, 0f, (RearLeftWheelCollider.wheelRPMToSpeed + RearRightWheelCollider.wheelRPMToSpeed) / 2f / 10f), Mathf.Abs(_gasInput)), Time.deltaTime * 50f);
		}
		else if (!cutGas)
		{
			if (changingGear)
			{
				clutchInput = Mathf.Lerp(clutchInput, 1f, Time.deltaTime * 10f);
			}
			else
			{
				clutchInput = Mathf.Lerp(clutchInput, 0f, Time.deltaTime * 10f);
			}
		}
		if (cutGas || handbrakeInput >= 0.1f)
		{
			clutchInput = 1f;
		}
		clutchInput = Mathf.Clamp01(clutchInput);
	}

	private void GearBox()
	{
		if (engineRunning)
		{
			idleInput = Mathf.Lerp(1f, 0f, engineRPM / minEngineRPM);
		}
		else
		{
			idleInput = 0f;
		}
		if (!AIController)
		{
			if (brakeInput > 0.9f && base.transform.InverseTransformDirection(rigid.velocity).z < 1f && canGoReverseNow && automaticGear && !semiAutomaticGear && !changingGear && direction != -1)
			{
				StartCoroutine("ChangingGear", -1);
			}
			else if (brakeInput < 0.1f && base.transform.InverseTransformDirection(rigid.velocity).z > -1f && direction == -1 && !changingGear && automaticGear && !semiAutomaticGear)
			{
				StartCoroutine("ChangingGear", 0);
			}
		}
		if (automaticGear)
		{
			if (currentGear < totalGears - 1 && !changingGear && speed >= gearSpeed[currentGear] * 0.7f && FrontLeftWheelCollider.rpm > 0f)
			{
				if (!semiAutomaticGear)
				{
					StartCoroutine("ChangingGear", currentGear + 1);
				}
				else if (semiAutomaticGear && direction != -1)
				{
					StartCoroutine("ChangingGear", currentGear + 1);
				}
			}
			if (currentGear > 0 && !changingGear && speed < gearSpeed[currentGear - 1] * 0.5f && direction != -1)
			{
				StartCoroutine("ChangingGear", currentGear - 1);
			}
		}
		if (direction == -1)
		{
			if (!reversingSound.isPlaying)
			{
				reversingSound.Play();
			}
			reversingSound.volume = Mathf.Lerp(0f, 1f, speed / 60f);
			reversingSound.pitch = reversingSound.volume;
		}
		else
		{
			if (reversingSound.isPlaying)
			{
				reversingSound.Stop();
			}
			reversingSound.volume = 0f;
			reversingSound.pitch = 0f;
		}
	}

	internal IEnumerator ChangingGear(int gear)
	{
		changingGear = true;
		if (RCCSettings.useTelemetry)
		{
			MonoBehaviour.print("Shifted to: " + gear);
		}
		if (gearShiftingClips.Length > 0)
		{
			gearShiftingSound = RCC_CreateAudioSource.NewAudioSource(base.gameObject, "Gear Shifting AudioSource", 5f, 5f, RCCSettings.maxGearShiftingSoundVolume, gearShiftingClips[UnityEngine.Random.Range(0, gearShiftingClips.Length)], loop: false, playNow: true, destroyAfterFinished: true);
			if (!gearShiftingSound.isPlaying)
			{
				gearShiftingSound.Play();
			}
		}
		yield return new WaitForSeconds(gearShiftingDelay);
		if (gear == -1)
		{
			currentGear = 0;
			direction = -1;
		}
		else
		{
			currentGear = gear;
			direction = 1;
		}
		changingGear = false;
	}

	private void RevLimiter()
	{
		if (useRevLimiter && engineRPM >= maxEngineRPM * 1.05f)
		{
			cutGas = true;
		}
		else if (engineRPM < maxEngineRPM)
		{
			cutGas = false;
		}
	}

	private void NOS()
	{
		if (!useNOS)
		{
			return;
		}
		if (boostInput > 1.5f && _gasInput >= 0.8f && NoS > 5f)
		{
			NoS -= NoSConsumption * Time.deltaTime;
			NoSRegenerateTime = 0f;
			if (!NOSSound.isPlaying)
			{
				NOSSound.Play();
			}
			return;
		}
		if (NoS < 100f && NoSRegenerateTime > 3f)
		{
			NoS += NoSConsumption / 1.5f * Time.deltaTime;
		}
		NoSRegenerateTime += Time.deltaTime;
		if (NOSSound.isPlaying)
		{
			NOSSound.Stop();
			blowSound.clip = RCCSettings.blowoutClip[UnityEngine.Random.Range(0, RCCSettings.blowoutClip.Length)];
			blowSound.Play();
		}
	}

	private void Turbo()
	{
		if (useTurbo)
		{
			turboBoost = Mathf.Lerp(turboBoost, Mathf.Clamp(Mathf.Pow(_gasInput, 10f) * 30f + Mathf.Pow(engineRPM / maxEngineRPM, 10f) * 30f, 0f, 30f), Time.deltaTime * 10f);
			if (turboBoost >= 25f && turboBoost < turboSound.volume * 30f && !blowSound.isPlaying)
			{
				blowSound.clip = RCCSettings.blowoutClip[UnityEngine.Random.Range(0, RCCSettings.blowoutClip.Length)];
				blowSound.Play();
			}
			turboSound.volume = Mathf.Lerp(turboSound.volume, turboBoost / 30f, Time.deltaTime * 5f);
			turboSound.pitch = Mathf.Lerp(Mathf.Clamp(turboSound.pitch, 2f, 3f), turboBoost / 30f * 2f, Time.deltaTime * 5f);
		}
	}

	private void DriftVariables()
	{
		RearRightWheelCollider.wheelCollider.GetGroundHit(out var hit);
		if (speed > 1f && driftingNow)
		{
			driftAngle = hit.sidewaysSlip * 1f;
		}
		else
		{
			driftAngle = 0f;
		}
		if (Mathf.Abs(hit.sidewaysSlip) > 0.25f)
		{
			driftingNow = true;
		}
		else
		{
			driftingNow = false;
		}
	}

	private void ResetCar()
	{
		if (speed < 5f && !rigid.isKinematic && base.transform.eulerAngles.z < 300f && base.transform.eulerAngles.z > 60f)
		{
			resetTime += Time.deltaTime;
			if (resetTime > 3f)
			{
				base.transform.rotation = Quaternion.identity;
				base.transform.position = new Vector3(base.transform.position.x, base.transform.position.y + 3f, base.transform.position.z);
				resetTime = 0f;
			}
		}
	}

	private void OnCollisionEnter(Collision collision)
	{
		if (collision.contacts.Length < 1 || collision.relativeVelocity.magnitude < minimumCollisionForce)
		{
			return;
		}
		if (crashClips.Length > 0 && collision.contacts[0].thisCollider.gameObject.transform != base.transform.parent)
		{
			crashSound = RCC_CreateAudioSource.NewAudioSource(base.gameObject, "Crash Sound AudioSource", 5f, 20f, RCCSettings.maxCrashSoundVolume, crashClips[UnityEngine.Random.Range(0, crashClips.Length)], loop: false, playNow: true, destroyAfterFinished: true);
			if (!crashSound.isPlaying)
			{
				crashSound.Play();
			}
		}
		if (useDamage)
		{
			CollisionParticles(collision.contacts[0].point);
			Vector3 relativeVelocity = collision.relativeVelocity;
			relativeVelocity *= 1f - Mathf.Abs(Vector3.Dot(base.transform.up, collision.contacts[0].normal));
			float num = Mathf.Abs(Vector3.Dot(collision.contacts[0].normal, relativeVelocity.normalized));
			if (relativeVelocity.magnitude * num >= minimumCollisionForce)
			{
				sleep = false;
				localVector = base.transform.InverseTransformDirection(relativeVelocity) * (damageMultiplier / 50f);
				if (originalMeshData == null)
				{
					LoadOriginalMeshData();
				}
				for (int i = 0; i < deformableMeshFilters.Length; i++)
				{
					DeformMesh(deformableMeshFilters[i].mesh, originalMeshData[i].meshVerts, collision, num, deformableMeshFilters[i].transform, rot);
				}
			}
		}
		if ((bool)UnityEngine.Object.FindObjectOfType<RCC_Camera>() && UnityEngine.Object.FindObjectOfType<RCC_Camera>().playerCar == base.transform)
		{
			UnityEngine.Object.FindObjectOfType<RCC_Camera>().Collision(collision);
		}
	}

	private void OnGUI()
	{
		if (RCCSettings.useTelemetry && canControl)
		{
			GUI.skin.label.fontSize = 12;
			GUI.skin.box.fontSize = 12;
			GUI.backgroundColor = Color.gray;
			float num = (float)Screen.width / 2f;
			GUI.Box(new Rect((float)(Screen.width - 400) - num, 10f, 800f, 270f), string.Empty);
			GUI.Label(new Rect((float)(Screen.width - 390) - num, 10f, 400f, 150f), "Engine RPM : " + Mathf.CeilToInt(engineRPM));
			GUI.Label(new Rect((float)(Screen.width - 200) - num, 10f, 400f, 150f), "Engine Running : " + ((!engineRunning) ? "Stopped" : "Running").ToString());
			GUI.Label(new Rect((float)(Screen.width - 200) - num, 30f, 400f, 150f), "Engine Starter : " + ((!engineStarting) ? "Stopped" : "Starting").ToString());
			GUI.Label(new Rect((float)(Screen.width - 200) - num, 90f, 400f, 150f), "Engine Sound On Volume: " + engineSoundOn.volume.ToString("F1"));
			GUI.Label(new Rect((float)(Screen.width - 200) - num, 110f, 400f, 150f), "Engine Sound On Pitch: " + engineSoundOn.pitch.ToString("F1"));
			GUI.Label(new Rect((float)(Screen.width - 200) - num, 130f, 400f, 150f), "Engine Sound Off Volume: " + engineSoundOff.volume.ToString("F1"));
			GUI.Label(new Rect((float)(Screen.width - 200) - num, 150f, 400f, 150f), "Engine Sound Off Pitch: " + engineSoundOff.pitch.ToString("F1"));
			GUI.Label(new Rect((float)(Screen.width - 390) - num, 30f, 400f, 150f), "Speed " + ((RCCSettings.units != 0) ? "(MP/H)" : "(KM/H)") + Mathf.CeilToInt(speed));
			GUI.Label(new Rect((float)(Screen.width - 390) - num, 50f, 400f, 150f), "Steer Angle : " + Mathf.CeilToInt(FrontLeftWheelCollider.steerAngle));
			GUI.Label(new Rect((float)(Screen.width - 390) - num, 70f, 400f, 150f), "Automatic Shifting : " + ((!automaticGear) ? "Manual" : "Automatic").ToString());
			if (!changingGear)
			{
				GUI.Label(new Rect((float)(Screen.width - 390) - num, 90f, 400f, 150f), "Gear No : " + ((direction != 1) ? "R" : (currentGear + 1).ToString()));
			}
			else
			{
				GUI.Label(new Rect((float)(Screen.width - 390) - num, 90f, 400f, 150f), "Gear No : N");
			}
			GUI.Label(new Rect((float)(Screen.width - 390) - num, 230f, 400f, 150f), "Mobile Horizontal Tilt : " + Input.acceleration.x);
			GUI.Label(new Rect((float)(Screen.width - 390) - num, 250f, 400f, 150f), "Mobile Vertical Tilt : " + Input.acceleration.y);
			GUI.Label(new Rect((float)Screen.width - num, 10f, 400f, 150f), "Front Left Wheel RPM : " + Mathf.CeilToInt(FrontLeftWheelCollider.rpm));
			GUI.Label(new Rect((float)(Screen.width + 200) - num, 10f, 400f, 150f), "Front Right Wheel RPM : " + Mathf.CeilToInt(FrontRightWheelCollider.rpm));
			GUI.Label(new Rect((float)Screen.width - num, 30f, 400f, 150f), "Front Left Wheel Torque : " + Mathf.CeilToInt(FrontLeftWheelCollider.wheelCollider.motorTorque));
			GUI.Label(new Rect((float)(Screen.width + 200) - num, 30f, 400f, 150f), "Front Right Wheel Torque : " + Mathf.CeilToInt(FrontRightWheelCollider.wheelCollider.motorTorque));
			GUI.Label(new Rect((float)Screen.width - num, 50f, 400f, 150f), "Front Left Wheel brake : " + Mathf.CeilToInt(FrontLeftWheelCollider.wheelCollider.brakeTorque));
			GUI.Label(new Rect((float)(Screen.width + 200) - num, 50f, 400f, 150f), "Front Right Wheel brake : " + Mathf.CeilToInt(FrontRightWheelCollider.wheelCollider.brakeTorque));
			FrontLeftWheelCollider.wheelCollider.GetGroundHit(out var hit);
			GUI.Label(new Rect((float)(Screen.width - 200) - num, 210f, 400f, 150f), "WCSpeed: " + RearLeftWheelCollider.wheelRPMToSpeed);
			GUI.Label(new Rect((float)(Screen.width - 200) - num, 230f, 400f, 150f), "UnderSteer: " + overSteering);
			GUI.Label(new Rect((float)(Screen.width - 200) - num, 250f, 400f, 150f), "OverSteer: " + underSteering);
			if (FrontLeftWheelCollider.wheelCollider.GetGroundHit(out hit))
			{
				GUI.Label(new Rect((float)(Screen.width - 200) - num, 70f, 400f, 150f), "Ground Grip : " + FrontLeftWheelCollider.forwardFrictionCurve.stiffness);
			}
			GUI.Label(new Rect((float)Screen.width - num, 70f, 400f, 150f), "Front Left Wheel Force : " + Mathf.CeilToInt(hit.force));
			GUI.Label(new Rect((float)Screen.width - num, 90f, 400f, 150f), "Front Left Wheel Sideways Grip : " + (1f - Mathf.Abs(hit.sidewaysSlip)).ToString("F2"));
			GUI.Label(new Rect((float)Screen.width - num, 110f, 400f, 150f), "Front Left Wheel Forward Grip : " + (1f - Mathf.Abs(hit.forwardSlip)).ToString("F2"));
			FrontRightWheelCollider.wheelCollider.GetGroundHit(out hit);
			GUI.Label(new Rect((float)(Screen.width + 200) - num, 70f, 400f, 150f), "Front Right Wheel Force : " + Mathf.CeilToInt(hit.force));
			GUI.Label(new Rect((float)(Screen.width + 200) - num, 90f, 400f, 150f), "Front Right Wheel Sideways Grip : " + (1f - Mathf.Abs(hit.sidewaysSlip)).ToString("F2"));
			GUI.Label(new Rect((float)(Screen.width + 200) - num, 110f, 400f, 150f), "Front Right Wheel Forward Grip : " + (1f - Mathf.Abs(hit.forwardSlip)).ToString("F2"));
			GUI.Label(new Rect((float)(Screen.width - 390) - num, 170f, 400f, 150f), "ABS: " + ABS + ". Current State: " + ((!ABSAct) ? "Safe" : "Engaged").ToString());
			GUI.Label(new Rect((float)(Screen.width - 390) - num, 190f, 400f, 150f), "TCS: " + TCS + ". Current State: " + ((!TCSAct) ? "Safe" : "Engaged").ToString());
			GUI.Label(new Rect((float)(Screen.width - 390) - num, 210f, 400f, 150f), "ESP: " + ESP + ". Current State: " + ((!ESPAct) ? "Safe" : "Engaged").ToString());
			GUI.Label(new Rect((float)Screen.width - num, 150f, 400f, 150f), "Rear Left Wheel RPM : " + Mathf.CeilToInt(RearLeftWheelCollider.rpm));
			GUI.Label(new Rect((float)(Screen.width + 200) - num, 150f, 400f, 150f), "Rear Right Wheel RPM : " + Mathf.CeilToInt(RearRightWheelCollider.rpm));
			GUI.Label(new Rect((float)Screen.width - num, 170f, 400f, 150f), "Rear Left Wheel Torque : " + Mathf.CeilToInt(RearLeftWheelCollider.wheelCollider.motorTorque));
			GUI.Label(new Rect((float)(Screen.width + 200) - num, 170f, 400f, 150f), "Rear Right Wheel Torque : " + Mathf.CeilToInt(RearRightWheelCollider.wheelCollider.motorTorque));
			GUI.Label(new Rect((float)Screen.width - num, 190f, 400f, 150f), "Rear Left Wheel brake : " + Mathf.CeilToInt(RearLeftWheelCollider.wheelCollider.brakeTorque));
			GUI.Label(new Rect((float)(Screen.width + 200) - num, 190f, 400f, 150f), "Rear Right Wheel brake : " + Mathf.CeilToInt(RearRightWheelCollider.wheelCollider.brakeTorque));
			RearLeftWheelCollider.wheelCollider.GetGroundHit(out hit);
			GUI.Label(new Rect((float)Screen.width - num, 210f, 400f, 150f), "Rear Left Wheel Force : " + Mathf.CeilToInt(hit.force));
			GUI.Label(new Rect((float)Screen.width - num, 230f, 400f, 150f), "Rear Left Wheel Sideways Grip : " + (1f - Mathf.Abs(hit.sidewaysSlip)).ToString("F2"));
			GUI.Label(new Rect((float)Screen.width - num, 250f, 400f, 150f), "Rear Left Wheel Forward Grip : " + (1f - Mathf.Abs(hit.forwardSlip)).ToString("F2"));
			RearRightWheelCollider.wheelCollider.GetGroundHit(out hit);
			GUI.Label(new Rect((float)(Screen.width + 200) - num, 210f, 400f, 150f), "Rear Right Wheel Force : " + Mathf.CeilToInt(hit.force));
			GUI.Label(new Rect((float)(Screen.width + 200) - num, 230f, 400f, 150f), "Rear Right Wheel Sideways Grip : " + (1f - Mathf.Abs(hit.sidewaysSlip)).ToString("F2"));
			GUI.Label(new Rect((float)(Screen.width + 200) - num, 250f, 400f, 150f), "Rear Right Wheel Forward Grip : " + (1f - Mathf.Abs(hit.forwardSlip)).ToString("F2"));
			GUI.backgroundColor = Color.green;
			GUI.Button(new Rect((float)(Screen.width - 20) - num, 260f, 10f, Mathf.Clamp((0f - _gasInput) * 100f, -100f, 0f)), string.Empty);
			GUI.backgroundColor = Color.red;
			GUI.Button(new Rect((float)(Screen.width - 35) - num, 260f, 10f, Mathf.Clamp((0f - _brakeInput) * 100f, -100f, 0f)), string.Empty);
			GUI.backgroundColor = Color.blue;
			GUI.Button(new Rect((float)(Screen.width - 50) - num, 260f, 10f, Mathf.Clamp((0f - clutchInput) * 100f, -100f, 0f)), string.Empty);
		}
	}

	private bool OverTorque()
	{
		if (speed > maxspeed || !engineRunning)
		{
			return true;
		}
		return false;
	}

	private void OnDrawGizmos()
	{
	}

	public void TorqueCurve()
	{
		if (defMaxSpeed != maxspeed)
		{
			if (totalGears < 1)
			{
				Debug.LogError("You are trying to set your vehicle gear to 0 or below! Why you trying to do this???");
				totalGears = 1;
				return;
			}
			gearSpeed = new float[totalGears];
			engineTorqueCurve = new AnimationCurve[totalGears];
			currentGear = 0;
			for (int i = 0; i < engineTorqueCurve.Length; i++)
			{
				engineTorqueCurve[i] = new AnimationCurve(new Keyframe(0f, 1f));
			}
			for (int j = 0; j < totalGears; j++)
			{
				gearSpeed[j] = Mathf.Lerp(0f, maxspeed, (float)(j + 1) / (float)totalGears);
				if (j != 0)
				{
					engineTorqueCurve[j].MoveKey(0, new Keyframe(0f, Mathf.Lerp(0.25f, 0f, (float)(j + 1) / (float)totalGears)));
					engineTorqueCurve[j].AddKey(Mathf.Lerp(0f, maxspeed / 1f, (float)j / (float)totalGears), Mathf.Lerp(1f, 0.25f, (float)j / (float)totalGears));
					engineTorqueCurve[j].AddKey(gearSpeed[j], 0.1f);
					engineTorqueCurve[j].AddKey(gearSpeed[j] * 2f, -3f);
					engineTorqueCurve[j].postWrapMode = WrapMode.Once;
				}
				else
				{
					engineTorqueCurve[j].MoveKey(0, new Keyframe(0f, 1f));
					engineTorqueCurve[j].AddKey(Mathf.Lerp(0f, maxspeed / 1f, (float)(j + 1) / (float)totalGears), 1f);
					engineTorqueCurve[j].AddKey(Mathf.Lerp(25f, maxspeed / 1f, (float)(j + 1) / (float)totalGears), 0f);
					engineTorqueCurve[j].postWrapMode = WrapMode.Once;
				}
			}
		}
		defMaxSpeed = maxspeed;
	}

	private void OnDisable()
	{
		if (canControl && (bool)base.gameObject.GetComponentInChildren<RCC_Camera>())
		{
			base.gameObject.GetComponentInChildren<RCC_Camera>().transform.SetParent(null);
		}
	}
}
