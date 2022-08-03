//using Cinemachine;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// This script will hold everything that is needed to be global only in Game scene
/// </summary>
public class GameplayController : MonoBehaviour
{

    public GameObject Rcccamera;
    public GameObject MapCamera;
    public bl_MiniMap[] miniMAP;
    public AudioSource GearShiftingsound;
    public AudioSource ReverseSound;
    public List<GameObject> BusesList;
    public GameObject SelectedVehiclePrefab;
    private bool lvelcongrats = false;
    private bool levelComplete = false;
    private bool levelFail = false;
    private bool isRevived = false;
    private int lives = 3;
    private Rigidbody selectedvehiclerigidbody;
    private RCC_CarControllerV3 selectedvehicleRCCV3;
    private Transform vehiclespawnpoint;
    private bool gametutorial = false;
    //private GameObject endcamera;

    public bool LevelComplete { get => levelComplete; set => levelComplete = value; }
    public bool LevelFail { get => levelFail; set => levelFail = value; }
    public bool IsRevived { get => isRevived; set => isRevived = value; }
    public int Lives { get => lives; set => lives = value; }
    public Transform Vehiclespawnpoint { get => vehiclespawnpoint; set => vehiclespawnpoint = value; }
    public Rigidbody Selectedvehiclerigidbody { get => selectedvehiclerigidbody; set => selectedvehiclerigidbody = value; }
    public bool Gametutorial { get => gametutorial; set => gametutorial = value; }
    public bool Lvelcongrats { get => lvelcongrats; set => lvelcongrats = value; }
    public RCC_CarControllerV3 SelectedvehicleRCCV3 { get => selectedvehicleRCCV3; set => selectedvehicleRCCV3 = value; }

    void Awake()
    {

        Toolbox.Set_GameplayScript(this);
        Time.timeScale = 1;
        GearShiftingsound.volume = Toolbox.DB.Prefs.MusicVolume;
        ReverseSound.volume = Toolbox.DB.Prefs.MusicVolume;
        SelectedVehiclePrefab = BusesList[Toolbox.DB.Prefs.LastSelectedVehicle];
        LevelComplete = false;
        levelFail = false;
        IsRevived = false;
        Lvelcongrats = false;

    }

    void Start()
    {

        Toolbox.Soundmanager.PlayMusic_Game();
        Toolbox.GameManager.FBAnalytic_EventLevel_Started(Toolbox.GameManager.Get_CurGameModeName(), Toolbox.DB.Prefs.LastSelectedchapter_of_gamemode, Toolbox.DB.Prefs.Get_LastSelectedLevelOfCurrentGameMode());
        Toolbox.GameManager.Analytics_ProgressionEvent_Start(Toolbox.GameManager.Get_CurGameModeName(), Toolbox.DB.Prefs.LastSelectedchapter_of_gamemode, Toolbox.DB.Prefs.Get_LastSelectedLevelOfCurrentGameMode());
        Toolbox.Soundmanager.PlaySound(Toolbox.Soundmanager.CarLock);
        //if (Toolbox.DB.Prefs.LastSelectedGameMode == 0)
        //    RCC_Settings.Instance.behaviorSelectedIndex = 4;
        //else
        //    RCC_Settings.Instance.behaviorSelectedIndex = 5;

    }

    public void spawnvehicle()
    {
        SelectedVehiclePrefab.transform.position = Vehiclespawnpoint.position;
        SelectedVehiclePrefab.transform.rotation = Vehiclespawnpoint.rotation;
        SelectedVehiclePrefab.SetActive(true);
        selectedvehiclerigidbody = SelectedVehiclePrefab.GetComponent<Rigidbody>();
        selectedvehicleRCCV3 = SelectedVehiclePrefab.GetComponent<RCC_CarControllerV3>();
        Rcccamera.SetActive(true);
        // MapCamera.SetActive(true);
        for (int i = 0; i < miniMAP.Length; i++)
        {
            miniMAP[i].SetTarget(SelectedVehiclePrefab);
        }
        HUD_Status(true);
        if (Gametutorial)
            Toolbox.HUDListner.Tutorial.SetActive(true);
    }

    public void HUD_Status(bool _val)
    {
        Toolbox.HUDListner.handleplayerhud(_val);
        Toolbox.HUDListner.Set_PlayerControls(_val);
        Toolbox.HUDListner.pauseBtn.gameObject.SetActive(_val);
    }
    int index = 0;

    public void Set_EndcameraStatus()
    {

    }

    public IEnumerator LevelComplete_Delay(float delay)
    {
       
        Lvelcongrats = true;
        HUD_Status(false);
        selectedvehiclerigidbody.drag = 10f;
        Set_EndcameraStatus();
        yield return new WaitForSeconds(1f);
        Toolbox.HUDListner.Missioncompletetext.SetActive(true);
        yield return new WaitForSeconds(delay + 1f);
        Toolbox.HUDListner.Missioncompletetext.SetActive(false);
        LevelCompleteHandling();
        selectedvehiclerigidbody.drag = 0.01f;
        StopCoroutine(LevelComplete_Delay(0.1f));
    }
    public void LevelCompleteHandling()
    {

        if (LevelComplete || LevelFail)
            return;

        LevelComplete = true;
        SelectedVehiclePrefab.SetActive(false);
        //HUD_Status(false);
        if ((!Toolbox.DB.Prefs.AppRated && Toolbox.DB.Prefs.Get_LastSelectedLevelOfCurrentGameMode() == 2) || (!Toolbox.DB.Prefs.AppRated && Toolbox.DB.Prefs.Get_LastSelectedLevelOfCurrentGameMode() == 5))
        {
            Toolbox.HUDListner.RateUs_Panel.SetActive(true);
        }

        else
        {
            Toolbox.HUDListner.CompletePanel.SetActive(true);
        }
    }
    public void LevelFail_Delay(float delay)
    {
        if (Lvelcongrats)
            return;
        if (Toolbox.HUDListner.MissionFailtext)
            Toolbox.HUDListner.MissionFailtext.SetActive(true);
        Invoke("LevelFailHandling", delay);
    }
    public void LevelFailHandling()
    {

        if (LevelComplete || LevelFail || Lvelcongrats)
            return;

        if (Toolbox.HUDListner.MissionFailtext)
            Toolbox.HUDListner.MissionFailtext.SetActive(false);
        LevelFail = true;
        Toolbox.Soundmanager.PlaySound(Toolbox.Soundmanager.levelFail);
        HUD_Status(false);
        Toolbox.HUDListner.FailPanel.SetActive(true);
    }

    public void CR_Revive()
    {
        HUD_Status(false);
        Toolbox.HUDListner.RevivePanel.SetActive(true);
        Toolbox.GameManager.Reviveplayer = true;

    }

    IEnumerator CR_ReviveAfterDelay()
    {

        yield return new WaitForSeconds(1);
        HUD_Status(false);
        Toolbox.HUDListner.RevivePanel.SetActive(true);
    }

    public void RevivePlayer()
    {

        if (LevelComplete || LevelFail)
            return;
        Time.timeScale = 1;
        LevelFail = false;
        IsRevived = true;
        HUD_Status(true);
        Toolbox.GameManager.FBAnalytic_EventDesign(Toolbox.GameManager.Get_CurGameModeName() + "_" + Toolbox.DB.Prefs.Get_LastSelectedLevelOfCurrentGameMode());

    }

}
