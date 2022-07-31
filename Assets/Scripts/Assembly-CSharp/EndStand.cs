using UnityEngine;

public class EndStand : MonoBehaviour
{
    public GameObject pasngerdrop;


    public static GameManagerU instance;



    public void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == "Player")
        {
            Toolbox.GameplayController.Selectedvehiclerigidbody.isKinematic = true;
            Invoke("droppasanger", 4f);
            Invoke("statrtplayer", 6f);
            Invoke("CompleteLevell", 8f);
            //Debug.Log("enddddd");
        }
    }

    public void droppasanger()
    {
        pasngerdrop.gameObject.SetActive(true);
        for (int i = 0; i < pasngerdrop.transform.childCount; i++)
        {
            pasngerdrop.transform.GetChild(i).GetComponent<Animation>().enabled = true;
            pasngerdrop.transform.GetChild(i).GetComponent<Passengers>().enabled = true;
        }
    }

    public void statrtplayer()
    {
        Toolbox.GameplayController.Selectedvehiclerigidbody.isKinematic = false;
    }

    public void CompleteLevell()
    {
        //GameManagerU.instance.showlevelComplete();
        if (!Toolbox.GameplayController.Lvelcongrats)
        {
            Toolbox.Soundmanager.PlaySound(Toolbox.Soundmanager.levelComplete);
            Toolbox.GameplayController.StartCoroutine(Toolbox.GameplayController.LevelComplete_Delay(3f));
        }
    }

    public void showfadecam()
    {
        Toolbox.HUDListner.set_StatusFade(true);
        StartCoroutine(Toolbox.HUDListner.FadeLoadingScreen(1, 3));
        Invoke("offfadecam", 3f);
    }

    public void offfadecam()
    {
        Toolbox.HUDListner.set_StatusFade(false);
    }
}
