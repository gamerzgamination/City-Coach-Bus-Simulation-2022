using UnityEngine;

//namespace UnityStandardAssets.Effects;

public class WaterHoseParticles : MonoBehaviour
{
	public static float lastSoundTime;

	public float force = 1f;

	private ParticleCollisionEvent[] m_CollisionEvents;

	private ParticleSystem m_ParticleSystem;

	private void Start()
	{
		m_ParticleSystem = GetComponent<ParticleSystem>();
	}

	private void OnParticleCollision(GameObject other)
	{
		m_CollisionEvents = new ParticleCollisionEvent[m_ParticleSystem.GetSafeCollisionEventSize()];
		int collisionEvents = m_ParticleSystem.GetCollisionEvents(other, m_CollisionEvents);
		for (int i = 0; i < collisionEvents; i++)
		{
			if (Time.time > lastSoundTime + 0.2f)
			{
				lastSoundTime = Time.time;
			}
			Component colliderComponent = m_CollisionEvents[i].colliderComponent;
			Rigidbody component = colliderComponent.GetComponent<Rigidbody>();
			if (component != null)
			{
				Vector3 velocity = m_CollisionEvents[i].velocity;
				component.AddForce(velocity * force, ForceMode.Impulse);
			}
			other.BroadcastMessage("Extinguish", SendMessageOptions.DontRequireReceiver);
		}
	}
}
