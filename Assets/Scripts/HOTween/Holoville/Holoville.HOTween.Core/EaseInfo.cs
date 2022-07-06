//using Holoville.HOTween.Core.Easing;

//namespace Holoville.HOTween.Core;

public class EaseInfo
{
	public TweenDelegate.EaseFunc ease;

	public TweenDelegate.EaseFunc inverseEase;

	private EaseInfo(TweenDelegate.EaseFunc p_ease, TweenDelegate.EaseFunc p_inverseEase)
	{
		ease = p_ease;
		inverseEase = p_inverseEase;
	}

	internal static EaseInfo GetEaseInfo(EaseType p_easeType)
	{
		switch (p_easeType)
		{
			case EaseType.EaseInSine:
			 return	new EaseInfo(Sine.EaseIn, Sine.EaseOut);
				break;
			case EaseType.EaseOutSine:
				return new EaseInfo(Sine.EaseOut, Sine.EaseIn);
				break;
			case EaseType.EaseInOutSine:
				return new EaseInfo(Sine.EaseInOut, null);
				break;
			case EaseType.EaseInQuad:
				return new EaseInfo(Quad.EaseIn, Quad.EaseOut);
				break;
			case EaseType.EaseOutQuad:
				return new EaseInfo(Quad.EaseOut, Quad.EaseIn);
				break;
			case EaseType.EaseInOutQuad:
				return new EaseInfo(Quad.EaseInOut, null);
				break;
			case EaseType.EaseInCubic:
				return new EaseInfo(Cubic.EaseIn, Cubic.EaseOut);
				break;
			case EaseType.EaseOutCubic:
				return new EaseInfo(Cubic.EaseOut, Cubic.EaseIn);
				break;
			case EaseType.EaseInOutCubic:
				return new EaseInfo(Cubic.EaseInOut, null);
				break;
			case EaseType.EaseInQuart:
				return new EaseInfo(Quart.EaseIn, Quart.EaseOut);
				break;
			case EaseType.EaseOutQuart:
				return new EaseInfo(Quart.EaseOut, Quart.EaseIn);
				break;
			case EaseType.EaseInOutQuart:
				return new EaseInfo(Quart.EaseInOut, null);
				break;
			case EaseType.EaseInQuint:
				return new EaseInfo(Quint.EaseIn, Quint.EaseOut);
				break;
			case EaseType.EaseOutQuint:
				return new EaseInfo(Quint.EaseOut, Quint.EaseIn);
				break;
			case EaseType.EaseInOutQuint:
				return new EaseInfo(Quint.EaseInOut, null);
				break;
			case EaseType.EaseInExpo:
				return new EaseInfo(Expo.EaseIn, Expo.EaseOut);
				break;
			case EaseType.EaseOutExpo:
				return new EaseInfo(Expo.EaseOut, Expo.EaseIn);
				break;
			case EaseType.EaseInOutExpo:
				return new EaseInfo(Expo.EaseInOut, null);
				break;
			case EaseType.EaseInCirc:
				return new EaseInfo(Circ.EaseIn, Circ.EaseOut);
				break;
			case EaseType.EaseOutCirc:
				return new EaseInfo(Circ.EaseOut, Circ.EaseIn);
				break;
			case EaseType.EaseInOutCirc:
				return new EaseInfo(Circ.EaseInOut, null);
				break;
			case EaseType.EaseInElastic:
				return new EaseInfo(Elastic.EaseIn, Elastic.EaseOut);
				break;
			case EaseType.EaseOutElastic:
				return new EaseInfo(Elastic.EaseOut, Elastic.EaseIn);
				break;
			case EaseType.EaseInOutElastic:
				return new EaseInfo(Elastic.EaseInOut, null);
				break;
			case EaseType.EaseInBack:
				return new EaseInfo(Back.EaseIn, Back.EaseOut);
				break;
			case EaseType.EaseOutBack:
				return new EaseInfo(Back.EaseOut, Back.EaseIn);
				break;
			case EaseType.EaseInOutBack:
				return new EaseInfo(Back.EaseInOut, null);
				break;
			case EaseType.EaseInBounce:
				return new EaseInfo(Bounce.EaseIn, Bounce.EaseOut);
				break;
			case EaseType.EaseOutBounce:
				return new EaseInfo(Bounce.EaseOut, Bounce.EaseIn);
				break;
			case EaseType.EaseInOutBounce:
				return new EaseInfo(Bounce.EaseInOut, null);
				break;
			case EaseType.EaseInStrong:
				return new EaseInfo(Strong.EaseIn, Strong.EaseOut);
				break;
			case EaseType.EaseOutStrong:
				return new EaseInfo(Strong.EaseOut, Strong.EaseIn);
				break;
			case EaseType.EaseInOutStrong:
				return new EaseInfo(Strong.EaseInOut, null);
                break;
            default:
				return new EaseInfo(Linear.EaseNone, null);
				break;

		}
        //return p_easeType switch
        //{
        //	EaseType.EaseInSine => new EaseInfo(Sine.EaseIn, Sine.EaseOut), 
        //	EaseType. => new EaseInfo(Sine.EaseOut, Sine.EaseIn), 
        //	EaseType.EaseInOutSine => new EaseInfo(Sine.EaseInOut, null), 
        //	EaseType.EaseInQuad => new EaseInfo(Quad.EaseIn, Quad.EaseOut), 
        //	EaseType.EaseOutQuad => new EaseInfo(Quad.EaseOut, Quad.EaseIn), 
        //	EaseType.EaseInOutQuad => new EaseInfo(Quad.EaseInOut, null), 
        //	EaseType.EaseInCubic => new EaseInfo(Cubic.EaseIn, Cubic.EaseOut), 
        //	EaseType.EaseOutCubic => new EaseInfo(Cubic.EaseOut, Cubic.EaseIn), 
        //	EaseType.EaseInOutCubic => new EaseInfo(Cubic.EaseInOut, null), 
        //	EaseType.EaseInQuart => new EaseInfo(Quart.EaseIn, Quart.EaseOut), 
        //	EaseType.EaseOutQuart => new EaseInfo(Quart.EaseOut, Quart.EaseIn), 
        //	EaseType.EaseInOutQuart => new EaseInfo(Quart.EaseInOut, null), 
        //	EaseType.EaseInQuint => new EaseInfo(Quint.EaseIn, Quint.EaseOut), 
        //	EaseType.EaseOutQuint => new EaseInfo(Quint.EaseOut, Quint.EaseIn), 
        //	EaseType.EaseInOutQuint => new EaseInfo(Quint.EaseInOut, null), 
        //	EaseType.EaseInExpo => new EaseInfo(Expo.EaseIn, Expo.EaseOut), 
        //	EaseType.EaseOutExpo => new EaseInfo(Expo.EaseOut, Expo.EaseIn), 
        //	EaseType.EaseInOutExpo => new EaseInfo(Expo.EaseInOut, null), 
        //	EaseType.EaseInCirc => new EaseInfo(Circ.EaseIn, Circ.EaseOut), 
        //	EaseType.EaseOutCirc => new EaseInfo(Circ.EaseOut, Circ.EaseIn), 
        //	EaseType.EaseInOutCirc => new EaseInfo(Circ.EaseInOut, null), 
        //	EaseType.EaseInElastic => new EaseInfo(Elastic.EaseIn, Elastic.EaseOut), 
        //	EaseType.EaseOutElastic => new EaseInfo(Elastic.EaseOut, Elastic.EaseIn), 
        //	EaseType.EaseInOutElastic => new EaseInfo(Elastic.EaseInOut, null), 
        //	EaseType.EaseInBack => new EaseInfo(Back.EaseIn, Back.EaseOut), 
        //	EaseType.EaseOutBack => new EaseInfo(Back.EaseOut, Back.EaseIn), 
        //	EaseType.EaseInOutBack => new EaseInfo(Back.EaseInOut, null), 
        //	EaseType.EaseInBounce => new EaseInfo(Bounce.EaseIn, Bounce.EaseOut), 
        //	EaseType.EaseOutBounce => new EaseInfo(Bounce.EaseOut, Bounce.EaseIn), 
        //	EaseType.EaseInOutBounce => new EaseInfo(Bounce.EaseInOut, null), 
        //	EaseType.EaseInStrong => new EaseInfo(Strong.EaseIn, Strong.EaseOut), 
        //	EaseType.EaseOutStrong => new EaseInfo(Strong.EaseOut, Strong.EaseIn), 
        //	EaseType.EaseInOutStrong => new EaseInfo(Strong.EaseInOut, null), 
        //	_ => new EaseInfo(Linear.EaseNone, null), 
        //};
    }
}
