using UnityEngine;
using UnityEngine.UI;
public class csDemoScenceControl : MonoBehaviour
{
	public GameObject[] AllEffect;

	private int i;

	public Text Text;

	public Transform mg;

	private GameObject MakedObject;

	public bool isIngredientScene;

	public bool isExampleScene;

	private csColorChangerinSampleScene cs;

	private void Start()
	{
		i = 1;
		MakedObject = Object.Instantiate(AllEffect[i - 1], AllEffect[i - 1].transform.position, Quaternion.identity);
		Text.text = "(" + i + "/" + AllEffect.Length + ") " + AllEffect[i - 1].name;
	}

	private void Update()
	{
		if ((bool)mg)
		{
			cs = mg.GetComponent<csColorChangerinSampleScene>();
		}
		if (Input.GetKeyDown(KeyCode.X))
		{
			if (i - 1 <= AllEffect.Length - 2)
			{
				i++;
			}
			else
			{
				i = 1;
			}
			Object.Destroy(MakedObject);
			MakedObject = Object.Instantiate(AllEffect[i - 1], AllEffect[i - 1].transform.position, AllEffect[i - 1].transform.rotation);
			Text.text = "(" + i + "/" + AllEffect.Length + ") " + AllEffect[i - 1].name;
			if (isIngredientScene)
			{
				if (cs.Saved)
				{
					cs.ChangeColor(cs.SaveColor);
				}
				if (i >= 415 && i <= 425)
				{
					Text.text = "(NEW)" + Text.text;
				}
			}
			if (isExampleScene && i >= 30 && i <= 35)
			{
				Text.text = "(NEW)" + Text.text;
			}
		}
		else if (Input.GetKeyDown(KeyCode.Z))
		{
			if (i - 1 > 0)
			{
				i--;
			}
			else
			{
				i = AllEffect.Length;
			}
			Object.Destroy(MakedObject);
			MakedObject = Object.Instantiate(AllEffect[i - 1], AllEffect[i - 1].transform.position, AllEffect[i - 1].transform.rotation);
			Text.text = "(" + i + "/" + AllEffect.Length + ") " + AllEffect[i - 1].name;
			if (isIngredientScene)
			{
				if (cs.Saved)
				{
					cs.ChangeColor(cs.SaveColor);
				}
				if (i >= 415 && i <= 425)
				{
					Text.text = "(NEW)" + Text.text;
				}
			}
			if (isExampleScene && i >= 30 && i <= 35)
			{
				Text.text = "(NEW)" + Text.text;
			}
		}
		else
		{
			if (!Input.GetKeyDown(KeyCode.C))
			{
				return;
			}
			Object.Destroy(MakedObject);
			MakedObject = Object.Instantiate(AllEffect[i - 1], AllEffect[i - 1].transform.position, AllEffect[i - 1].transform.rotation);
			Text.text = "(" + i + "/" + AllEffect.Length + ") " + AllEffect[i - 1].name;
			if (isIngredientScene)
			{
				if (cs.Saved)
				{
					cs.ChangeColor(cs.SaveColor);
				}
				if (i >= 415 && i <= 425)
				{
					Text.text = "(NEW)" + Text.text;
				}
			}
			if (isExampleScene && i >= 30 && i <= 35)
			{
				Text.text = "(NEW)" + Text.text;
			}
		}
	}
}
