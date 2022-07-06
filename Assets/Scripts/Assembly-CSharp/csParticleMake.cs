using System;
using UnityEngine;

public class csParticleMake : MonoBehaviour
{
	public Transform[] Particles;

	public int ParticleMakeNumber = 1;

	public int Radious = 1;

	private float StandardAngle;

	private float MakeAngle;

	private void Awake()
	{
		StandardAngle = (float)(360 / ParticleMakeNumber) * ((float)Math.PI / 180f);
		MakeAngle = StandardAngle;
		int num = 0;
		for (int i = 0; i < ParticleMakeNumber; i++)
		{
			Transform original;
			if (Particles.Length > 1)
			{
				if (num >= Particles.Length)
				{
					num = 0;
				}
				original = Particles[num];
				num++;
			}
			else
			{
				original = Particles[0];
			}
			Transform transform = UnityEngine.Object.Instantiate(original, base.transform.position, base.transform.rotation);
			transform.transform.parent = base.transform;
			transform.transform.position = new Vector3(transform.position.x + Mathf.Cos(MakeAngle) * (float)Radious, transform.position.y, transform.position.z + Mathf.Sin(MakeAngle) * (float)Radious);
			MakeAngle += StandardAngle;
		}
	}

	private void ColorSubmit()
	{
	}
}
