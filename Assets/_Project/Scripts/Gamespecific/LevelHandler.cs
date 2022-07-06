
using UnityEngine;

public class LevelHandler : MonoBehaviour
{
    public Transform vehicleSpawnPoint;
    //public GameObject EndCamera;

    private void Start()
    {
        LevelStartHandling();
    }
    public void LevelStartHandling()
    {
        SpawnVehicle();
    }
    private void SpawnVehicle()
    {
        Toolbox.GameplayController.Vehiclespawnpoint = vehicleSpawnPoint;
        
        Toolbox.GameplayController.spawnvehicle();
    }

}
