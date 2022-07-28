using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class modebtnListner : MonoBehaviour
{
    public GameObject lockObj;
   
    public void Lock_Status(bool _val)
    {

        lockObj.SetActive(_val);
    }
    #region ButtonListners

    public void OnPress_chapterButton(GameObject _buttonTransform)
    {
        Toolbox.Soundmanager.PlaySound(Toolbox.Soundmanager.GameUIclicks);
        this.GetComponentInParent<ModeSelectionListner>().OnPress_ModeButton(_buttonTransform);
    }

    public void OnPress_ChapterLockButton()
    {
        Toolbox.Soundmanager.PlaySound(Toolbox.Soundmanager.GameUIclicks);

        Toolbox.UIManager.ModeLockPopup.SetActive(true);
        Toolbox.UIManager.ModeLockPopup.GetComponent<MessageListner>().UpdateTxt("This Mode is currently locked. Play atleast " + (Constants.mode2UnlockAfterLevels) + " levels of current chapter to unlock the glory of this chapter", "MODELOCKED");
    }

    public void OnPress_ChapterLock_ComingSoon()
    {
        Toolbox.Soundmanager.PlaySound(Toolbox.Soundmanager.GameUIclicks);
        Toolbox.UIManager.ModeLockPopup.SetActive(true);
        Toolbox.UIManager.ModeLockPopup.GetComponent<MessageListner>().UpdateTxt("This Mode is currently locked. Coming Soon" , "LOCKED");
    }
    #endregion

}
