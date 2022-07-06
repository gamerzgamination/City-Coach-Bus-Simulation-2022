using System.Collections;
using UnityEngine;

public class AnimControl : MonoBehaviour
{
	private Animator anim;

	private int temp;

	private bool abcd;

	private void Start()
	{
		anim = base.gameObject.GetComponent<Animator>();
		anim.GetComponent<Animator>().enabled = false;
	}

	public void SetReverse()
	{
		anim.SetBool("reverseAnim", value: true);
		abcd = false;
	}

	private void Update()
	{
	}

	private IEnumerator Abcde()
	{
		abcd = true;
		yield return new WaitForSecondsRealtime(3f);
		if (!anim.GetBool("reverseAnim"))
		{
			SetReverse();
			temp = 0;
		}
	}

	public void AnimPLay()
	{
		MonoBehaviour.print("OpenAnim");
		if (!abcd)
		{
			temp++;
			anim.GetComponent<Animator>().enabled = true;
			anim.SetBool("reverseAnim", value: false);
			StartCoroutine(Abcde());
			if (!anim.GetBool("reverseAnim") && temp > 1)
			{
				temp = 0;
				StopCoroutine(Abcde());
				SetReverse();
			}
		}
	}

	public void DisAbleAnim()
	{
		anim.GetComponent<Animator>().enabled = false;
	}
}
