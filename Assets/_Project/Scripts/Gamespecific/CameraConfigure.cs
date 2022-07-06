using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraConfigure : MonoBehaviour
{
    public float distance = 10f;

    public float height = 5f;
    // Start is called before the first frame update
    void Start()
    {
        SetCameraSettings();
    }

	public void SetCameraSettings()
	{
		//Toolbox.GameplayController.Rcccamera.GetComponent<RCC_Camera>

        if (Toolbox.GameplayController.Rcccamera.GetComponent<RCC_Camera>())
        {
            Toolbox.GameplayController.Rcccamera.GetComponent<RCC_Camera>().distance = distance;
            Toolbox.GameplayController.Rcccamera.GetComponent<RCC_Camera>().height = height;
        }
    }
}
