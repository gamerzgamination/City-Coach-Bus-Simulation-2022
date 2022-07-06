using UnityEngine;

[AddComponentMenu("BoneCracker Games/Realistic Car Controller/UI/Dashboard Inputs")]
public class RCC_DashboardInputs : MonoBehaviour
{
    public RCC_CarControllerV3 currentCarController;

    public GameObject RPMNeedle;

    public GameObject KMHNeedle;

    public GameObject turboGauge;

    public GameObject NOSGauge;

    public GameObject BoostNeedle;

    public GameObject NoSNeedle;

    private float RPMNeedleRotation;

    private float KMHNeedleRotation;

    private float BoostNeedleRotation;

    private float NoSNeedleRotation;

    public float RPM;

    public float KMH;

    internal int direction = 1;

    internal float Gear;

    internal bool NGear;

    internal bool ABS;

    internal bool ESP;

    internal bool Park;

    internal bool Headlights;

    internal RCC_CarControllerV3.IndicatorsOn indicators;


    private void OnEnable()
    {
        if (Toolbox.GameplayController.SelectedVehiclePrefab.GetComponent<RCC_CarControllerV3>())
            currentCarController = Toolbox.GameplayController.SelectedVehiclePrefab.GetComponent<RCC_CarControllerV3>();

    }

    private void Update()
    {
        if (RCC_Settings.Instance.uiType == RCC_Settings.UIType.None)
        {
            base.gameObject.SetActive(value: false);
            base.enabled = false;
        }
        else
        {
            GetValues();
        }
    }

    public void GetVehicle(RCC_CarControllerV3 rcc)
    {
        currentCarController = rcc;
        RCC_UIDashboardButton[] array = Object.FindObjectsOfType<RCC_UIDashboardButton>();
        RCC_UIDashboardButton[] array2 = array;
        foreach (RCC_UIDashboardButton rCC_UIDashboardButton in array2)
        {
            rCC_UIDashboardButton.Check();
        }
    }

    private void GetValues()
    {
        if (!currentCarController || !currentCarController.canControl || currentCarController.AIController)
        {
            return;
        }
        if ((bool)NOSGauge)
        {
            if (currentCarController.useNOS)
            {
                if (!NOSGauge.activeSelf)
                {
                    NOSGauge.SetActive(value: true);
                }
            }
            else if (NOSGauge.activeSelf)
            {
                NOSGauge.SetActive(value: false);
            }
        }
        if ((bool)turboGauge)
        {
            if (currentCarController.useTurbo)
            {
                if (!turboGauge.activeSelf)
                {
                    turboGauge.SetActive(value: true);
                }
            }
            else if (turboGauge.activeSelf)
            {
                turboGauge.SetActive(value: false);
            }
        }
        RPM = currentCarController.engineRPM;
        KMH = currentCarController.speed;
        direction = currentCarController.direction;
        Gear = currentCarController.currentGear;
        NGear = currentCarController.changingGear;
        ABS = currentCarController.ABSAct;
        ESP = currentCarController.ESPAct;
        Park = currentCarController.handbrakeInput > 0.1f;
        Headlights = currentCarController.lowBeamHeadLightsOn || currentCarController.highBeamHeadLightsOn;
        indicators = currentCarController.indicatorsOn;
        if ((bool)RPMNeedle)
        {
            RPMNeedleRotation = currentCarController.engineRPM / 50f;
            RPMNeedle.transform.eulerAngles = new Vector3(RPMNeedle.transform.eulerAngles.x, RPMNeedle.transform.eulerAngles.y, 0f - RPMNeedleRotation);
        }
        if ((bool)KMHNeedle)
        {
            if (RCC_Settings.Instance.units == RCC_Settings.Units.KMH)
            {
                KMHNeedleRotation = currentCarController.speed;
            }
            else
            {
                KMHNeedleRotation = currentCarController.speed * 0.62f;
            }
            KMHNeedle.transform.eulerAngles = new Vector3(KMHNeedle.transform.eulerAngles.x, KMHNeedle.transform.eulerAngles.y, 0f - KMHNeedleRotation);
        }
        if ((bool)BoostNeedle)
        {
            BoostNeedleRotation = currentCarController.turboBoost / 30f * 270f;
            BoostNeedle.transform.eulerAngles = new Vector3(BoostNeedle.transform.eulerAngles.x, BoostNeedle.transform.eulerAngles.y, 0f - BoostNeedleRotation);
        }
        if ((bool)NoSNeedle)
        {
            NoSNeedleRotation = currentCarController.NoS / 100f * 270f;
            NoSNeedle.transform.eulerAngles = new Vector3(NoSNeedle.transform.eulerAngles.x, NoSNeedle.transform.eulerAngles.y, 0f - NoSNeedleRotation);
        }
    }
}
