using UnityEngine;

[AddComponentMenu("BoneCracker Games/Realistic Car Controller/Camera/RCC_Camera")]
public class RCC_Camera : MonoBehaviour
{
	public enum CameraMode
	{
		TPS,
		FPS,
		WHEEL,
		FIXED
	}

	public Transform playerCar;

	private Rigidbody playerRigid;

	private Camera cam;

	public GameObject pivot;

	private GameObject boundCenter;

	public CameraMode cameraMode;

	public float distance = 6f;

	public float height = 2f;

	private float heightDamping = 5f;

	private float rotationDamping = 3f;

	public float targetFieldOfView = 60f;

	public float minimumFOV = 55f;

	public float maximumFOV = 70f;

	public float maximumTilt = 15f;

	private float tiltAngle;

	internal int cameraSwitchCount;

	private RCCHoodCamera hoodCam;

	private RCCWheelCamera wheelCam;

	private RCC_MainFixedCamera fixedCam;

	private Vector3 targetPosition = Vector3.zero;

	private Vector3 pastFollowerPosition;

	private Vector3 pastTargetPosition = Vector3.zero;

	private float speed;

	public float maxShakeAmount = 0.01f;

	private Vector3 localVector;

	private Vector3 collisionPos;

	private Quaternion collisionRot;

	public static RCC_Camera instance;

	private float index;

	public Transform _playerCar
	{
		get
		{
			return playerCar;
		}
		set
		{
			playerCar = value;
			GetPlayerCar();
		}
	}

	private void Awake()
	{
		cam = GetComponentInChildren<Camera>();
	}

	public void Start()
	{
		instance = this;
		//playerCar = GameObject.FindGameObjectWithTag("Player").transform;
		if (!playerCar)
        {
			SetPlayerCar(Toolbox.GameplayController.SelectedVehiclePrefab);
        }

		//if (playerCar.gameObject.name == "bus3test")
		//{
		//	distance = 18f;
		//	height = 9f;
		//}
		//else if (playerCar.gameObject.name == "bus2" || playerCar.gameObject.name == "bus1")
		//{
		//	distance = 17f;
		//	height = 5.5f;
		//}
		//else
		//{
		//	distance = 15f;
		//	height = 5f;
		//}
	}

	private void GetPlayerCar()
	{
		if (!playerCar)
		{
			SetPlayerCar(Toolbox.GameplayController.SelectedVehiclePrefab);
		}
		if ((bool)playerCar)
		{
			playerRigid = playerCar.GetComponent<Rigidbody>();
			hoodCam = playerCar.GetComponentInChildren<RCCHoodCamera>();
			wheelCam = playerCar.GetComponentInChildren<RCCWheelCamera>();
			fixedCam = Object.FindObjectOfType<RCC_MainFixedCamera>();
			base.transform.position = playerCar.transform.position;
			base.transform.rotation = playerCar.transform.rotation * Quaternion.Euler(10f, 0f, 0f);
		}
	}

	public void SetPlayerCar(GameObject player)
	{
		_playerCar = player.transform;
	}

	private void Update()
	{
		if (!playerCar || !playerRigid)
		{
			GetPlayerCar();
			return;
		}
		speed = Mathf.Lerp(speed, playerRigid.velocity.magnitude * 3.6f, Time.deltaTime * 0.5f);
		if (index > 0f)
		{
			index -= Time.deltaTime * 5f;
		}
		if (cameraMode == CameraMode.TPS)
		{
		}
		cam.fieldOfView = targetFieldOfView;
	}

	private void LateUpdate()
	{
		if (!playerCar || !playerRigid || !playerCar.gameObject.activeSelf)
		{
			return;
		}
		if (Input.GetKeyDown(RCC_Settings.Instance.changeCameraKB))
		{
			ChangeCamera();
		}
		switch (cameraSwitchCount)
		{
		case 0:
			cameraMode = CameraMode.TPS;
			break;
		case 1:
			cameraMode = CameraMode.FPS;
			break;
		case 2:
			cameraMode = CameraMode.WHEEL;
			break;
		case 3:
			cameraMode = CameraMode.FIXED;
			break;
		}
		pastFollowerPosition = base.transform.position;
		pastTargetPosition = targetPosition;
		switch (cameraMode)
		{
		case CameraMode.TPS:
			TPS();
				Toolbox.HUDListner.set_statusInteriorbus(false);
			break;
		case CameraMode.FPS:
			if ((bool)hoodCam)
			{
				FPS();
					Toolbox.HUDListner.set_statusInteriorbus(false);
				}
				else
			{
				cameraSwitchCount++;
				ChangeCamera();
			}
			break;
		case CameraMode.WHEEL:
			if ((bool)wheelCam)
			{
				WHEEL();
					Toolbox.HUDListner.set_statusInteriorbus(true);
				}
				else
			{
				cameraSwitchCount++;
				ChangeCamera();
			}
			break;
		case CameraMode.FIXED:
			if ((bool)fixedCam)
			{
				FIXED();
				break;
			}
			cameraSwitchCount++;
			ChangeCamera();
			break;
		}
	}

	public void ChangeCamera()
	{
		cameraSwitchCount++;
		if (cameraSwitchCount >= 4)
		{
			cameraSwitchCount = 0;
		}
		if ((bool)fixedCam)
		{
			fixedCam.canTrackNow = false;
		}
	}

	private void FPS()
	{
		if (base.transform.parent != hoodCam)
		{
			base.transform.SetParent(hoodCam.transform, worldPositionStays: false);
			base.transform.position = hoodCam.transform.position;
			base.transform.rotation = hoodCam.transform.rotation;
			targetFieldOfView = 70f;
		}
	}

	private void WHEEL()
	{
		if (base.transform.parent != wheelCam)
		{
			base.transform.SetParent(wheelCam.transform, worldPositionStays: false);
			base.transform.position = wheelCam.transform.position;
			base.transform.rotation = wheelCam.transform.rotation;
			targetFieldOfView = 60f;
		}
	}

	private void TPS()
	{
		if (base.transform.parent != null)
		{
			base.transform.SetParent(null);
		}
		if (targetPosition == Vector3.zero)
		{
			targetPosition = _playerCar.position;
			targetPosition -= base.transform.rotation * Vector3.forward * distance;
			base.transform.position = targetPosition;
			pastFollowerPosition = base.transform.position;
			pastTargetPosition = targetPosition;
		}
		targetFieldOfView = Mathf.Lerp(cam.fieldOfView, Mathf.Lerp(minimumFOV, maximumFOV, speed / 150f) + 5f * Mathf.Cos(1f * index), Time.deltaTime * 10f);
		tiltAngle = Mathf.Lerp(0f, maximumTilt * (float)(int)Mathf.Clamp(0f - playerCar.InverseTransformDirection(playerRigid.velocity).x, -1f, 1f), Mathf.Abs(playerCar.InverseTransformDirection(playerRigid.velocity).x) / 50f);
		float b = playerCar.eulerAngles.y + Mathf.Clamp(playerRigid.transform.InverseTransformDirection(playerRigid.velocity).z, -10f, 0f) * 18f;
		float b2 = playerCar.position.y + height;
		float y = targetPosition.y;
		float y2 = base.transform.eulerAngles.y;
		rotationDamping = Mathf.Lerp(1f, 5f, playerRigid.velocity.magnitude * 3.6f / 10f);
		y2 = Mathf.LerpAngle(y2, b, Time.deltaTime * rotationDamping);
		Quaternion quaternion = Quaternion.Euler(0f, y2, tiltAngle);
		y = Mathf.Lerp(y, b2, heightDamping * Time.deltaTime);
		targetPosition = playerCar.position;
		if (RCC_Settings.Instance.behaviorType != RCC_Settings.BehaviorType.Drift)
		{
			targetPosition -= quaternion * Vector3.forward * distance;
			targetPosition = new Vector3(targetPosition.x, y, targetPosition.z);
		}
		else
		{
			targetPosition -= base.transform.rotation * Vector3.forward * distance;
			targetPosition = new Vector3(targetPosition.x, y, targetPosition.z);
		}
		base.transform.position = SmoothApproach(pastFollowerPosition, pastTargetPosition, targetPosition, Mathf.Clamp(0.1f, speed, float.PositiveInfinity));
		pastFollowerPosition = base.transform.position;
		pastTargetPosition = targetPosition;
		base.transform.LookAt(new Vector3(playerCar.position.x, playerCar.position.y + 1f, playerCar.position.z));
		pivot.transform.localPosition = Vector3.Lerp(pivot.transform.localPosition, new Vector3(Random.insideUnitSphere.x / 2f, Random.insideUnitSphere.y, Random.insideUnitSphere.z) * speed * maxShakeAmount, Time.deltaTime * 1f);
		collisionPos = Vector3.Lerp(collisionPos, Vector3.zero, Time.deltaTime * 5f);
		collisionRot = Quaternion.Lerp(collisionRot, Quaternion.identity, Time.deltaTime * 5f);
		pivot.transform.localPosition = Vector3.Lerp(pivot.transform.localPosition, collisionPos, Time.deltaTime * 5f);
		pivot.transform.localRotation = Quaternion.Lerp(pivot.transform.localRotation, collisionRot, Time.deltaTime * 5f);
	}

	private void FIXED()
	{
		if (base.transform.parent != null)
		{
			base.transform.SetParent(null);
		}
		fixedCam.canTrackNow = true;
		fixedCam.player = playerCar;
	}

	private Vector3 SmoothApproach(Vector3 pastPosition, Vector3 pastTargetPosition, Vector3 targetPosition, float delta)
	{
		if (float.IsNaN(delta) || float.IsInfinity(delta) || pastPosition == Vector3.zero || pastTargetPosition == Vector3.zero || targetPosition == Vector3.zero)
		{
			return base.transform.position;
		}
		float num = Time.deltaTime * delta;
		Vector3 vector = (targetPosition - pastTargetPosition) / num;
		Vector3 vector2 = pastPosition - pastTargetPosition + vector;
		return targetPosition - vector + vector2 * Mathf.Exp(0f - num);
	}

	public void Collision(Collision collision)
	{
		if (base.enabled && cameraMode == CameraMode.TPS)
		{
			Vector3 relativeVelocity = collision.relativeVelocity;
			relativeVelocity *= 1f - Mathf.Abs(Vector3.Dot(base.transform.up, collision.contacts[0].normal));
			float num = Mathf.Abs(Vector3.Dot(collision.contacts[0].normal, relativeVelocity.normalized));
			if (relativeVelocity.magnitude * num >= 5f)
			{
				localVector = base.transform.InverseTransformDirection(relativeVelocity) / 50f;
				collisionPos -= localVector * 5f;
				collisionRot = Quaternion.Euler(new Vector3((0f - localVector.z) * 5f, 0f, (0f - localVector.x) * 50f));
				cam.fieldOfView -= Mathf.Clamp(collision.relativeVelocity.magnitude, 0f, 30f);
				index = Mathf.Clamp(collision.relativeVelocity.magnitude / 5f, 0f, 10f);
			}
		}
	}
}
