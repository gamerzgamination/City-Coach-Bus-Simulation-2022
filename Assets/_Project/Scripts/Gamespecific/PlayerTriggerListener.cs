using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class PlayerTriggerListener : MonoBehaviour
{
    // [HideInInspector]
    public Transform Lastsavepoint;
    public int Totalcoins;
    public GameObject orbit_camera;


    public GameObject TollPlaza;

    public GameObject TollPlaza2;

    public GameObject SpeedLimitText;

    public GameObject OverSpeedText;

    public bool MotorWayStarted;

    public bool cashDeductCounter = true;

    public  bool RefuelBool;

    public GameObject RefuelCompleted;

    public  bool Refueling;

    //public GameObject GameCanvas;

    private void Start()
    {
    }

    private void OnCollisionEnter(Collision collision)
    {

        if (collision.gameObject.tag == "crash")
        {
            print("Name :" + collision.gameObject.name);
            Toolbox.Soundmanager.PlaySound(Toolbox.Soundmanager.CarHitAlarm);
           // collision.gameObject.GetComponent<MeshRenderer>().material = Toolbox.GameplayController.Redmaterial;
            GetComponent<Rigidbody>().isKinematic = true;
            Handheld.Vibrate();
            Toolbox.GameplayController.LevelFail_Delay(2f);
        }
        if (collision.gameObject.tag == "hurdl" || collision.gameObject.tag == "Barrier")
        {
            print("Name :" + collision.gameObject.name);
            Toolbox.Soundmanager.PlaySound(Toolbox.Soundmanager.CarHitAlarm);
          //  collision.gameObject.GetComponent<MeshRenderer>().material = Toolbox.GameplayController.Redmaterial;
            GetComponent<Rigidbody>().isKinematic = true;
            Handheld.Vibrate();
            Toolbox.GameplayController.LevelFail_Delay(2f);
        }
        if (collision.gameObject.tag == "Finish" || collision.gameObject.tag == "next" || collision.gameObject.tag == "Finish_Point" )
        {
            //orbit_camera.GetComponent<ob>().autoRotateOn = true;
            GetComponent<Rigidbody>().isKinematic = true;
            Toolbox.Soundmanager.PlaySound(Toolbox.Soundmanager.levelComplete);
            Toolbox.GameplayController.StartCoroutine(Toolbox.GameplayController.LevelComplete_Delay(3f));
        }
    }





    void OnTriggerEnter(Collider col)
    {



        if (col.gameObject.tag == "checkpoint")
        {

            Lastsavepoint = col.gameObject.transform;
            col.gameObject.SetActive(false);
        }
        if (col.gameObject.tag == "coins")
        {
            Totalcoins++;
            Toolbox.DB.Prefs.GoldCoins = Totalcoins;
            Toolbox.Soundmanager.PlaySound(Toolbox.Soundmanager.singleCoinsSound);
            col.gameObject.SetActive(false);
        }

       
        if (col.gameObject.tag == "Finish" || col.gameObject.tag == "next" || col.gameObject.tag == "Finish_Point")
        {
            //orbit_camera.GetComponent<ob>().autoRotateOn = true;
            GetComponent<Rigidbody>().isKinematic = true;
            Toolbox.Soundmanager.PlaySound(Toolbox.Soundmanager.levelComplete);
            Toolbox.GameplayController.StartCoroutine(Toolbox.GameplayController.LevelComplete_Delay(3f));
        }

        if (col.gameObject.tag == "people1")
        {
            GameManagerU.instance.GamePlayPanel.SetActive(value: false);
            Toolbox.HUDListner.WarningAlertMessage.SetActive(value: true);
            Invoke("ShowLevelFailed", 3f);
        }
        if (col.gameObject.tag == "tollplaza")
        {
            Invoke("OpenTollPlaza", 0.1f);
        }
        if (col.gameObject.tag == "tollplaza2")
        {
            Invoke("OpenTollPlaza2", 0.1f);
        }
        if (col.gameObject.tag == "speedLimit")
        {
            MotorWayStarted = true;
            StartCoroutine(ShowSpeedLimitText());
        }
        if (col.gameObject.tag == "motorwayExit")
        {
            MotorWayStarted = false;
        }
        if (col.gameObject.tag == "speedcheck" && RCC_CarControllerV3.instance.speed > 80f && PlayerPrefs.GetInt("TotalCash") > 500 && cashDeductCounter)
        {
            cashDeductCounter = false;
            PlayerPrefs.SetInt("TotalCash", PlayerPrefs.GetInt("TotalCash") - 500);
            PlayerPrefs.Save();
            if (!SpeedLimitText.activeInHierarchy && !OverSpeedText.activeInHierarchy)
            {
                StartCoroutine(ShowOverSpeedText());
            }
        }

        //if (col.gameObject.CompareTag("upwards"))
        //{
        //    print("Name :"+col.gameObject.name);
        //    col.gameObject.GetComponentInParent<Animator>().enabled = true;
        //    Toolbox.GameplayController.SelectedVehiclePrefab.transform.SetParent(col.gameObject.GetComponentInParent<Animator>().transform);
        //if (col.gameObject.CompareTag("gate"))
        //{
        //    col.gameObject.GetComponentInParent<Animator>().enabled = true;
        //}
    }

    private void OnTriggerStay(Collider col)
    {
        //if (LevelSelectionDemo.instance.currentLevel < 1)
        //{
        //	return;
        //}
        if (col.gameObject.gameObject.tag == "refuelpoint")
        {
            RefuelBool = true;
            GameManagerU.instance.fuelImage.fillAmount += 0.025f * Time.deltaTime;
            if (GameManagerU.instance.fuelImage.fillAmount >= 1f && !Refueling)
            {
                Refueling = true;
                StartCoroutine("ShowRefuelDone");
            }
        }
        if (col.gameObject.tag == "stand")
        {
            Toolbox.HUDListner.ParkingBar.fillAmount += 0.1f * Time.deltaTime;
        }
    }
    private void OnTriggerExit(Collider col)
    {
        if ( col.gameObject.gameObject.tag == "refuelpoint")
        {
            RefuelBool = false;
            Refueling = false;
        }
    }
    private IEnumerator ShowRefuelDone()
    {
        RefuelCompleted.SetActive(value: true);
        yield return new WaitForSeconds(3f);
        RefuelCompleted.SetActive(value: false);
    }

    private IEnumerator ShowSpeedLimitText()
    {
        SpeedLimitText.SetActive(value: true);
        yield return new WaitForSeconds(5f);
        SpeedLimitText.SetActive(value: false);
    }

    private IEnumerator ShowOverSpeedText()
    {
        OverSpeedText.SetActive(value: true);
        yield return new WaitForSeconds(3f);
        OverSpeedText.SetActive(value: false);
    }

    private void OpenTollPlaza()
    {
        TollPlaza.GetComponent<Animator>().enabled = true;
    }

    private void OpenTollPlaza2()
    {
        TollPlaza2.GetComponent<Animator>().enabled = true;
    }

    public void ShowLevelFailed()
    {
        GameManagerU.instance.showLevelFailed();
        Toolbox.HUDListner.WarningAlertMessage.SetActive(value: false);
    }


    public void set_StatusVehicleReset()
    {
        if (Lastsavepoint)
        {
            this.transform.position = Lastsavepoint.position;
            this.transform.rotation = Lastsavepoint.rotation;
            this.GetComponent<Rigidbody>().velocity = Vector3.zero;
            this.GetComponent<Rigidbody>().angularVelocity = Vector3.zero;
            //this.GetComponent<HandleTyreGrip>().enabled = false;
        }
        else
        {

        }

    }

    
}
