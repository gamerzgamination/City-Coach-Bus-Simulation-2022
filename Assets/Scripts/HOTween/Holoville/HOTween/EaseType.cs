using System;

//namespace Holoville.HOTween;

public enum EaseType
{
	Linear,
	EaseInSine,
	EaseOutSine,
	EaseInOutSine,
	EaseInQuad,
	EaseOutQuad,
	EaseInOutQuad,
	EaseInCubic,
	EaseOutCubic,
	EaseInOutCubic,
	EaseInQuart,
	EaseOutQuart,
	EaseInOutQuart,
	EaseInQuint,
	EaseOutQuint,
	EaseInOutQuint,
	EaseInExpo,
	EaseOutExpo,
	EaseInOutExpo,
	EaseInCirc,
	EaseOutCirc,
	EaseInOutCirc,
	EaseInElastic,
	EaseOutElastic,
	EaseInOutElastic,
	EaseInBack,
	EaseOutBack,
	EaseInOutBack,
	EaseInBounce,
	EaseOutBounce,
	EaseInOutBounce,
	AnimationCurve,
	[Obsolete("Use EaseInQuint instead.")]
	EaseInStrong,
	[Obsolete("Use EaseOutQuint instead.")]
	EaseOutStrong,
	[Obsolete("Use EaseInOutQuint instead.")]
	EaseInOutStrong
}
