﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DistanceGizmo : MonoBehaviour
{
    public float radius;
    private void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawWireSphere(transform.position, radius);
    }
}
