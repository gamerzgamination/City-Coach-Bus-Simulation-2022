Shader "EWater/Reflective/EasyWater8_C2TDR" {
	Properties {
		_Color ("_Color", Vector) = (1,1,1,1)
		_Texture1 ("_Texture1", 2D) = "black" {}
		_Texture2 ("_Texture2", 2D) = "black" {}
		_MainTexSpeed ("_MainTexSpeed", Float) = 0
		_Texture2Speed ("_Texture2Speed", Float) = 0
		_DistortionMap ("_DistortionMap", 2D) = "black" {}
		_DistortionSpeed ("_DistortionSpeed", Float) = 0
		_DistortionPower ("_DistortionPower", Range(0, 0.04)) = 0
		_Reflection ("_Reflection", 2D) = "black" {}
		_ReflectPower ("_ReflectPower", Range(0, 1)) = 0
	}
	SubShader {
		LOD 150
		Tags { "IGNOREPROJECTOR" = "False" }
		Pass {
			Name "FORWARD"
			LOD 150
			Tags { "IGNOREPROJECTOR" = "False" "LIGHTMODE" = "FORWARDBASE" "SHADOWSUPPORT" = "true" }
			GpuProgramID 18843
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					lowp vec4 u_xlat10_0;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_5;
					vec2 u_xlat8;
					mediump float u_xlat16_8;
					lowp float u_xlat10_8;
					vec2 u_xlat10;
					float u_xlat12;
					mediump float u_xlat16_12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1 = max(u_xlat16_1, 0.0);
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat0.xyw = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat0.w = u_xlat0.z * 10.0;
					    u_xlat8.x = dot(u_xlat0.xyw, u_xlat0.xyw);
					    u_xlat8.x = inversesqrt(u_xlat8.x);
					    u_xlat0.xy = u_xlat0.xy * u_xlat8.xx + vec2(1.0, 1.0);
					    u_xlat8.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_8 = texture2D(_DistortionMap, u_xlat8.xy).x;
					    u_xlat16_8 = u_xlat10_8 + -0.5;
					    u_xlat16_12 = u_xlat16_8 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat10_0.xyw = texture2D(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyw = u_xlat10_0.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_8) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_8)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_3.xyz * u_xlat10_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
					    SV_Target0.xyz = u_xlat16_5.xyz * vec3(u_xlat16_1) + u_xlat0.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					lowp vec4 u_xlat10_0;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_5;
					vec2 u_xlat8;
					mediump float u_xlat16_8;
					lowp float u_xlat10_8;
					vec2 u_xlat10;
					float u_xlat12;
					mediump float u_xlat16_12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1 = max(u_xlat16_1, 0.0);
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat0.xyw = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat0.w = u_xlat0.z * 10.0;
					    u_xlat8.x = dot(u_xlat0.xyw, u_xlat0.xyw);
					    u_xlat8.x = inversesqrt(u_xlat8.x);
					    u_xlat0.xy = u_xlat0.xy * u_xlat8.xx + vec2(1.0, 1.0);
					    u_xlat8.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_8 = texture2D(_DistortionMap, u_xlat8.xy).x;
					    u_xlat16_8 = u_xlat10_8 + -0.5;
					    u_xlat16_12 = u_xlat16_8 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat10_0.xyw = texture2D(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyw = u_xlat10_0.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_8) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_8)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_3.xyz * u_xlat10_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
					    SV_Target0.xyz = u_xlat16_5.xyz * vec3(u_xlat16_1) + u_xlat0.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					lowp vec4 u_xlat10_0;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_5;
					vec2 u_xlat8;
					mediump float u_xlat16_8;
					lowp float u_xlat10_8;
					vec2 u_xlat10;
					float u_xlat12;
					mediump float u_xlat16_12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1 = max(u_xlat16_1, 0.0);
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat0.xyw = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat0.w = u_xlat0.z * 10.0;
					    u_xlat8.x = dot(u_xlat0.xyw, u_xlat0.xyw);
					    u_xlat8.x = inversesqrt(u_xlat8.x);
					    u_xlat0.xy = u_xlat0.xy * u_xlat8.xx + vec2(1.0, 1.0);
					    u_xlat8.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_8 = texture2D(_DistortionMap, u_xlat8.xy).x;
					    u_xlat16_8 = u_xlat10_8 + -0.5;
					    u_xlat16_12 = u_xlat16_8 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat10_0.xyw = texture2D(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyw = u_xlat10_0.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_8) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_8)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_3.xyz * u_xlat10_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
					    SV_Target0.xyz = u_xlat16_5.xyz * vec3(u_xlat16_1) + u_xlat0.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_5;
					vec2 u_xlat8;
					mediump float u_xlat16_8;
					vec2 u_xlat10;
					float u_xlat12;
					mediump float u_xlat16_12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1 = max(u_xlat16_1, 0.0);
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat0.xyw = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat0.w = u_xlat0.z * 10.0;
					    u_xlat8.x = dot(u_xlat0.xyw, u_xlat0.xyw);
					    u_xlat8.x = inversesqrt(u_xlat8.x);
					    u_xlat0.xy = u_xlat0.xy * u_xlat8.xx + vec2(1.0, 1.0);
					    u_xlat8.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_8 = texture(_DistortionMap, u_xlat8.xy).x;
					    u_xlat16_8 = u_xlat16_8 + -0.5;
					    u_xlat16_12 = u_xlat16_8 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat16_0.xyw = texture(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyw = u_xlat16_0.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_8) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_8)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
					    SV_Target0.xyz = u_xlat16_5.xyz * vec3(u_xlat16_1) + u_xlat0.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_5;
					vec2 u_xlat8;
					mediump float u_xlat16_8;
					vec2 u_xlat10;
					float u_xlat12;
					mediump float u_xlat16_12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1 = max(u_xlat16_1, 0.0);
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat0.xyw = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat0.w = u_xlat0.z * 10.0;
					    u_xlat8.x = dot(u_xlat0.xyw, u_xlat0.xyw);
					    u_xlat8.x = inversesqrt(u_xlat8.x);
					    u_xlat0.xy = u_xlat0.xy * u_xlat8.xx + vec2(1.0, 1.0);
					    u_xlat8.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_8 = texture(_DistortionMap, u_xlat8.xy).x;
					    u_xlat16_8 = u_xlat16_8 + -0.5;
					    u_xlat16_12 = u_xlat16_8 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat16_0.xyw = texture(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyw = u_xlat16_0.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_8) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_8)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
					    SV_Target0.xyz = u_xlat16_5.xyz * vec3(u_xlat16_1) + u_xlat0.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_5;
					vec2 u_xlat8;
					mediump float u_xlat16_8;
					vec2 u_xlat10;
					float u_xlat12;
					mediump float u_xlat16_12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1 = max(u_xlat16_1, 0.0);
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat0.xyw = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat0.w = u_xlat0.z * 10.0;
					    u_xlat8.x = dot(u_xlat0.xyw, u_xlat0.xyw);
					    u_xlat8.x = inversesqrt(u_xlat8.x);
					    u_xlat0.xy = u_xlat0.xy * u_xlat8.xx + vec2(1.0, 1.0);
					    u_xlat8.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_8 = texture(_DistortionMap, u_xlat8.xy).x;
					    u_xlat16_8 = u_xlat16_8 + -0.5;
					    u_xlat16_12 = u_xlat16_8 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat16_0.xyw = texture(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyw = u_xlat16_0.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_8) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_8)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
					    SV_Target0.xyz = u_xlat16_5.xyz * vec3(u_xlat16_1) + u_xlat0.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2 = vec4(u_xlat18) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat2.z;
					    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat2.yzwx * u_xlat2.xywz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_4.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD5.xyz = u_xlat1.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec3 u_xlat16_1;
					vec4 u_xlat2;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					lowp vec3 u_xlat10_4;
					mediump vec3 u_xlat16_5;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_0.x = texture2D(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0 = u_xlat10_0.x + -0.5;
					    u_xlat4.xy = vec2(u_xlat16_0) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat10_4.xyz = texture2D(_Texture1, u_xlat4.xy).xyz;
					    u_xlat2.xy = (-vec2(u_xlat16_0)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0 = u_xlat16_0 * _DistortionPower;
					    u_xlat16_0 = u_xlat16_0 * 5.0;
					    u_xlat2.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture2, u_xlat2.xy).xyz;
					    u_xlat16_4.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_4.xyz * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat16_4.xyz * vs_TEXCOORD5.xyz;
					    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
					    u_xlat2.x = vs_TEXCOORD2.w;
					    u_xlat2.y = vs_TEXCOORD3.w;
					    u_xlat2.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
					    u_xlat2.xyz = u_xlat4.yyy * vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * u_xlat4.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat4.zzz + u_xlat2.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat4.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat2.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + vec2(u_xlat16_0);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2 = vec4(u_xlat18) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat2.z;
					    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat2.yzwx * u_xlat2.xywz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_4.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD5.xyz = u_xlat1.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec3 u_xlat16_1;
					vec4 u_xlat2;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					lowp vec3 u_xlat10_4;
					mediump vec3 u_xlat16_5;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_0.x = texture2D(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0 = u_xlat10_0.x + -0.5;
					    u_xlat4.xy = vec2(u_xlat16_0) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat10_4.xyz = texture2D(_Texture1, u_xlat4.xy).xyz;
					    u_xlat2.xy = (-vec2(u_xlat16_0)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0 = u_xlat16_0 * _DistortionPower;
					    u_xlat16_0 = u_xlat16_0 * 5.0;
					    u_xlat2.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture2, u_xlat2.xy).xyz;
					    u_xlat16_4.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_4.xyz * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat16_4.xyz * vs_TEXCOORD5.xyz;
					    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
					    u_xlat2.x = vs_TEXCOORD2.w;
					    u_xlat2.y = vs_TEXCOORD3.w;
					    u_xlat2.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
					    u_xlat2.xyz = u_xlat4.yyy * vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * u_xlat4.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat4.zzz + u_xlat2.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat4.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat2.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + vec2(u_xlat16_0);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2 = vec4(u_xlat18) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat2.z;
					    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat2.yzwx * u_xlat2.xywz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_4.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD5.xyz = u_xlat1.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec3 u_xlat16_1;
					vec4 u_xlat2;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					lowp vec3 u_xlat10_4;
					mediump vec3 u_xlat16_5;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_0.x = texture2D(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0 = u_xlat10_0.x + -0.5;
					    u_xlat4.xy = vec2(u_xlat16_0) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat10_4.xyz = texture2D(_Texture1, u_xlat4.xy).xyz;
					    u_xlat2.xy = (-vec2(u_xlat16_0)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0 = u_xlat16_0 * _DistortionPower;
					    u_xlat16_0 = u_xlat16_0 * 5.0;
					    u_xlat2.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture2, u_xlat2.xy).xyz;
					    u_xlat16_4.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_4.xyz * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat16_4.xyz * vs_TEXCOORD5.xyz;
					    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
					    u_xlat2.x = vs_TEXCOORD2.w;
					    u_xlat2.y = vs_TEXCOORD3.w;
					    u_xlat2.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
					    u_xlat2.xyz = u_xlat4.yyy * vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * u_xlat4.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat4.zzz + u_xlat2.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat4.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat2.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + vec2(u_xlat16_0);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2 = vec4(u_xlat18) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat2.z;
					    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat2.yzwx * u_xlat2.xywz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_4.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD5.xyz = u_xlat1.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_0.x = texture(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0.x = u_xlat16_0.x + -0.5;
					    u_xlat4.xy = u_xlat16_0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat16_4.xyz = texture(_Texture1, u_xlat4.xy).xyz;
					    u_xlat2.xy = (-u_xlat16_0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0.x = u_xlat16_0.x * _DistortionPower;
					    u_xlat16_0.x = u_xlat16_0.x * 5.0;
					    u_xlat2.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture2, u_xlat2.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_4.xyz * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat16_4.xyz * vs_TEXCOORD5.xyz;
					    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
					    u_xlat2.x = vs_TEXCOORD2.w;
					    u_xlat2.y = vs_TEXCOORD3.w;
					    u_xlat2.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
					    u_xlat2.xyz = u_xlat4.yyy * vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * u_xlat4.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat4.zzz + u_xlat2.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat4.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat2.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + u_xlat16_0.xx;
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2 = vec4(u_xlat18) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat2.z;
					    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat2.yzwx * u_xlat2.xywz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_4.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD5.xyz = u_xlat1.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_0.x = texture(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0.x = u_xlat16_0.x + -0.5;
					    u_xlat4.xy = u_xlat16_0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat16_4.xyz = texture(_Texture1, u_xlat4.xy).xyz;
					    u_xlat2.xy = (-u_xlat16_0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0.x = u_xlat16_0.x * _DistortionPower;
					    u_xlat16_0.x = u_xlat16_0.x * 5.0;
					    u_xlat2.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture2, u_xlat2.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_4.xyz * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat16_4.xyz * vs_TEXCOORD5.xyz;
					    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
					    u_xlat2.x = vs_TEXCOORD2.w;
					    u_xlat2.y = vs_TEXCOORD3.w;
					    u_xlat2.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
					    u_xlat2.xyz = u_xlat4.yyy * vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * u_xlat4.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat4.zzz + u_xlat2.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat4.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat2.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + u_xlat16_0.xx;
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2 = vec4(u_xlat18) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat2.z;
					    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat2.yzwx * u_xlat2.xywz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_4.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD5.xyz = u_xlat1.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_0.x = texture(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0.x = u_xlat16_0.x + -0.5;
					    u_xlat4.xy = u_xlat16_0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat16_4.xyz = texture(_Texture1, u_xlat4.xy).xyz;
					    u_xlat2.xy = (-u_xlat16_0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0.x = u_xlat16_0.x * _DistortionPower;
					    u_xlat16_0.x = u_xlat16_0.x * 5.0;
					    u_xlat2.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture2, u_xlat2.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_4.xyz * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat16_4.xyz * vs_TEXCOORD5.xyz;
					    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
					    u_xlat2.x = vs_TEXCOORD2.w;
					    u_xlat2.y = vs_TEXCOORD3.w;
					    u_xlat2.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
					    u_xlat2.xyz = u_xlat4.yyy * vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * u_xlat4.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat4.zzz + u_xlat2.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat4.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat2.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + u_xlat16_0.xx;
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD7;
					varying highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat16) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.w = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat4.y;
					    vs_TEXCOORD4.w = u_xlat4.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD7;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					mediump float u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					vec2 u_xlat3;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_5;
					float u_xlat12;
					mediump float u_xlat16_12;
					lowp float u_xlat10_12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1 = max(u_xlat16_1, 0.0);
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat2.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat12 = u_xlat12 + (-u_xlat2.x);
					    u_xlat12 = unity_ShadowFadeCenterAndType.w * u_xlat12 + u_xlat2.x;
					    u_xlat12 = u_xlat12 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat2.x = texture2D(_ShadowMapTexture, vs_TEXCOORD7.xy).x;
					    u_xlatb2 = vs_TEXCOORD7.z<u_xlat2.x;
					    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat2.x = max(u_xlat2.x, _LightShadowData.x);
					    u_xlat16_5.x = (-u_xlat2.x) + 1.0;
					    u_xlat16_5.x = u_xlat12 * u_xlat16_5.x + u_xlat2.x;
					    u_xlat16_5.xyz = u_xlat16_5.xxx * _LightColor0.xyz;
					    u_xlat2.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_12 = texture2D(_DistortionMap, u_xlat2.xy).x;
					    u_xlat16_12 = u_xlat10_12 + -0.5;
					    u_xlat2.xy = vec2(u_xlat16_12) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat3.xy = (-vec2(u_xlat16_12)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_12 = u_xlat16_12 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat3.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat3.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat3.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
					    u_xlat2.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat0.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat2.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower);
					    SV_Target0.xyz = u_xlat16_5.xyz * vec3(u_xlat16_1) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD7;
					varying highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat16) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.w = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat4.y;
					    vs_TEXCOORD4.w = u_xlat4.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD7;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					mediump float u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					vec2 u_xlat3;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_5;
					float u_xlat12;
					mediump float u_xlat16_12;
					lowp float u_xlat10_12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1 = max(u_xlat16_1, 0.0);
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat2.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat12 = u_xlat12 + (-u_xlat2.x);
					    u_xlat12 = unity_ShadowFadeCenterAndType.w * u_xlat12 + u_xlat2.x;
					    u_xlat12 = u_xlat12 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat2.x = texture2D(_ShadowMapTexture, vs_TEXCOORD7.xy).x;
					    u_xlatb2 = vs_TEXCOORD7.z<u_xlat2.x;
					    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat2.x = max(u_xlat2.x, _LightShadowData.x);
					    u_xlat16_5.x = (-u_xlat2.x) + 1.0;
					    u_xlat16_5.x = u_xlat12 * u_xlat16_5.x + u_xlat2.x;
					    u_xlat16_5.xyz = u_xlat16_5.xxx * _LightColor0.xyz;
					    u_xlat2.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_12 = texture2D(_DistortionMap, u_xlat2.xy).x;
					    u_xlat16_12 = u_xlat10_12 + -0.5;
					    u_xlat2.xy = vec2(u_xlat16_12) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat3.xy = (-vec2(u_xlat16_12)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_12 = u_xlat16_12 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat3.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat3.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat3.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
					    u_xlat2.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat0.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat2.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower);
					    SV_Target0.xyz = u_xlat16_5.xyz * vec3(u_xlat16_1) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD7;
					varying highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat16) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.w = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat4.y;
					    vs_TEXCOORD4.w = u_xlat4.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD7;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					mediump float u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					vec2 u_xlat3;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_5;
					float u_xlat12;
					mediump float u_xlat16_12;
					lowp float u_xlat10_12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1 = max(u_xlat16_1, 0.0);
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat2.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat12 = u_xlat12 + (-u_xlat2.x);
					    u_xlat12 = unity_ShadowFadeCenterAndType.w * u_xlat12 + u_xlat2.x;
					    u_xlat12 = u_xlat12 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat2.x = texture2D(_ShadowMapTexture, vs_TEXCOORD7.xy).x;
					    u_xlatb2 = vs_TEXCOORD7.z<u_xlat2.x;
					    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat2.x = max(u_xlat2.x, _LightShadowData.x);
					    u_xlat16_5.x = (-u_xlat2.x) + 1.0;
					    u_xlat16_5.x = u_xlat12 * u_xlat16_5.x + u_xlat2.x;
					    u_xlat16_5.xyz = u_xlat16_5.xxx * _LightColor0.xyz;
					    u_xlat2.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_12 = texture2D(_DistortionMap, u_xlat2.xy).x;
					    u_xlat16_12 = u_xlat10_12 + -0.5;
					    u_xlat2.xy = vec2(u_xlat16_12) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat3.xy = (-vec2(u_xlat16_12)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_12 = u_xlat16_12 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat3.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat3.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat3.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
					    u_xlat2.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat0.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat2.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower);
					    SV_Target0.xyz = u_xlat16_5.xyz * vec3(u_xlat16_1) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD7;
					out highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					vec2 u_xlat3;
					mediump vec3 u_xlat16_3;
					mediump float u_xlat16_6;
					float u_xlat12;
					mediump float u_xlat16_12;
					float u_xlat13;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat12 = u_xlat12 + (-u_xlat1.x);
					    u_xlat12 = unity_ShadowFadeCenterAndType.w * u_xlat12 + u_xlat1.x;
					    u_xlat12 = u_xlat12 * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
					#else
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vs_TEXCOORD3.www * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.www + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD4.www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat1.xy,u_xlat1.z);
					    u_xlat16_1.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_1.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_6 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat12 * u_xlat16_6 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat1.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_12 = texture(_DistortionMap, u_xlat1.xy).x;
					    u_xlat16_12 = u_xlat16_12 + -0.5;
					    u_xlat1.xy = vec2(u_xlat16_12) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat1.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat1.xy;
					    u_xlat16_1.xyz = texture(_Texture1, u_xlat1.xy).xyz;
					    u_xlat3.xy = (-vec2(u_xlat16_12)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_12 = u_xlat16_12 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat3.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat3.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat3.xy).xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz;
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat16_14 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
					    u_xlat1.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat1.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat0.x = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat1.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD7;
					out highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					vec2 u_xlat3;
					mediump vec3 u_xlat16_3;
					mediump float u_xlat16_6;
					float u_xlat12;
					mediump float u_xlat16_12;
					float u_xlat13;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat12 = u_xlat12 + (-u_xlat1.x);
					    u_xlat12 = unity_ShadowFadeCenterAndType.w * u_xlat12 + u_xlat1.x;
					    u_xlat12 = u_xlat12 * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
					#else
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vs_TEXCOORD3.www * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.www + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD4.www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat1.xy,u_xlat1.z);
					    u_xlat16_1.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_1.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_6 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat12 * u_xlat16_6 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat1.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_12 = texture(_DistortionMap, u_xlat1.xy).x;
					    u_xlat16_12 = u_xlat16_12 + -0.5;
					    u_xlat1.xy = vec2(u_xlat16_12) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat1.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat1.xy;
					    u_xlat16_1.xyz = texture(_Texture1, u_xlat1.xy).xyz;
					    u_xlat3.xy = (-vec2(u_xlat16_12)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_12 = u_xlat16_12 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat3.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat3.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat3.xy).xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz;
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat16_14 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
					    u_xlat1.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat1.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat0.x = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat1.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD7;
					out highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					vec2 u_xlat3;
					mediump vec3 u_xlat16_3;
					mediump float u_xlat16_6;
					float u_xlat12;
					mediump float u_xlat16_12;
					float u_xlat13;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat12 = u_xlat12 + (-u_xlat1.x);
					    u_xlat12 = unity_ShadowFadeCenterAndType.w * u_xlat12 + u_xlat1.x;
					    u_xlat12 = u_xlat12 * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
					#else
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vs_TEXCOORD3.www * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.www + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD4.www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat1.xy,u_xlat1.z);
					    u_xlat16_1.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_1.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_6 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat12 * u_xlat16_6 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat1.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_12 = texture(_DistortionMap, u_xlat1.xy).x;
					    u_xlat16_12 = u_xlat16_12 + -0.5;
					    u_xlat1.xy = vec2(u_xlat16_12) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat1.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat1.xy;
					    u_xlat16_1.xyz = texture(_Texture1, u_xlat1.xy).xyz;
					    u_xlat3.xy = (-vec2(u_xlat16_12)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_12 = u_xlat16_12 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat3.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat3.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat3.xy).xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz;
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat16_14 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
					    u_xlat1.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat1.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat0.x = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat1.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD7;
					varying highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_5;
					mediump vec3 u_xlat16_6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.w = u_xlat1.x;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat3 = u_xlat1.xxxx * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat1.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat1.xxx * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.w = u_xlat1.y;
					    vs_TEXCOORD4.w = u_xlat1.z;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat16_5 = u_xlat3.y * u_xlat3.y;
					    u_xlat16_5 = u_xlat3.x * u_xlat3.x + (-u_xlat16_5);
					    u_xlat16_1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
					    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD7;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					vec3 u_xlat4;
					lowp vec3 u_xlat10_4;
					bool u_xlatb4;
					mediump vec3 u_xlat16_6;
					float u_xlat15;
					mediump float u_xlat16_15;
					lowp float u_xlat10_15;
					float u_xlat18;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.yzw = u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
					    u_xlat16_1 = max(u_xlat16_1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_1.yzw);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_15 = texture2D(_DistortionMap, u_xlat3.xy).x;
					    u_xlat16_15 = u_xlat10_15 + -0.5;
					    u_xlat3.xy = vec2(u_xlat16_15) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat10_3.xyz = texture2D(_Texture1, u_xlat3.xy).xyz;
					    u_xlat4.xy = (-vec2(u_xlat16_15)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_15 = u_xlat16_15 * _DistortionPower;
					    u_xlat16_15 = u_xlat16_15 * 5.0;
					    u_xlat4.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat4.xy;
					    u_xlat10_4.xyz = texture2D(_Texture2, u_xlat4.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_3.xyz * u_xlat10_4.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat18 = sqrt(u_xlat18);
					    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat18 = u_xlat18 + (-u_xlat4.x);
					    u_xlat18 = unity_ShadowFadeCenterAndType.w * u_xlat18 + u_xlat4.x;
					    u_xlat18 = u_xlat18 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat4.x = texture2D(_ShadowMapTexture, vs_TEXCOORD7.xy).x;
					    u_xlatb4 = vs_TEXCOORD7.z<u_xlat4.x;
					    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat4.x = max(u_xlat4.x, _LightShadowData.x);
					    u_xlat16_2.x = (-u_xlat4.x) + 1.0;
					    u_xlat16_2.x = u_xlat18 * u_xlat16_2.x + u_xlat4.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx;
					    u_xlat3.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat3.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat0.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat2.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_15);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD7;
					varying highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_5;
					mediump vec3 u_xlat16_6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.w = u_xlat1.x;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat3 = u_xlat1.xxxx * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat1.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat1.xxx * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.w = u_xlat1.y;
					    vs_TEXCOORD4.w = u_xlat1.z;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat16_5 = u_xlat3.y * u_xlat3.y;
					    u_xlat16_5 = u_xlat3.x * u_xlat3.x + (-u_xlat16_5);
					    u_xlat16_1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
					    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD7;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					vec3 u_xlat4;
					lowp vec3 u_xlat10_4;
					bool u_xlatb4;
					mediump vec3 u_xlat16_6;
					float u_xlat15;
					mediump float u_xlat16_15;
					lowp float u_xlat10_15;
					float u_xlat18;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.yzw = u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
					    u_xlat16_1 = max(u_xlat16_1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_1.yzw);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_15 = texture2D(_DistortionMap, u_xlat3.xy).x;
					    u_xlat16_15 = u_xlat10_15 + -0.5;
					    u_xlat3.xy = vec2(u_xlat16_15) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat10_3.xyz = texture2D(_Texture1, u_xlat3.xy).xyz;
					    u_xlat4.xy = (-vec2(u_xlat16_15)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_15 = u_xlat16_15 * _DistortionPower;
					    u_xlat16_15 = u_xlat16_15 * 5.0;
					    u_xlat4.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat4.xy;
					    u_xlat10_4.xyz = texture2D(_Texture2, u_xlat4.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_3.xyz * u_xlat10_4.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat18 = sqrt(u_xlat18);
					    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat18 = u_xlat18 + (-u_xlat4.x);
					    u_xlat18 = unity_ShadowFadeCenterAndType.w * u_xlat18 + u_xlat4.x;
					    u_xlat18 = u_xlat18 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat4.x = texture2D(_ShadowMapTexture, vs_TEXCOORD7.xy).x;
					    u_xlatb4 = vs_TEXCOORD7.z<u_xlat4.x;
					    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat4.x = max(u_xlat4.x, _LightShadowData.x);
					    u_xlat16_2.x = (-u_xlat4.x) + 1.0;
					    u_xlat16_2.x = u_xlat18 * u_xlat16_2.x + u_xlat4.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx;
					    u_xlat3.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat3.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat0.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat2.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_15);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD7;
					varying highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_5;
					mediump vec3 u_xlat16_6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.w = u_xlat1.x;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat3 = u_xlat1.xxxx * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat1.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat1.xxx * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.w = u_xlat1.y;
					    vs_TEXCOORD4.w = u_xlat1.z;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat16_5 = u_xlat3.y * u_xlat3.y;
					    u_xlat16_5 = u_xlat3.x * u_xlat3.x + (-u_xlat16_5);
					    u_xlat16_1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
					    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD7;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					vec3 u_xlat4;
					lowp vec3 u_xlat10_4;
					bool u_xlatb4;
					mediump vec3 u_xlat16_6;
					float u_xlat15;
					mediump float u_xlat16_15;
					lowp float u_xlat10_15;
					float u_xlat18;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.yzw = u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
					    u_xlat16_1 = max(u_xlat16_1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_1.yzw);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_15 = texture2D(_DistortionMap, u_xlat3.xy).x;
					    u_xlat16_15 = u_xlat10_15 + -0.5;
					    u_xlat3.xy = vec2(u_xlat16_15) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat10_3.xyz = texture2D(_Texture1, u_xlat3.xy).xyz;
					    u_xlat4.xy = (-vec2(u_xlat16_15)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_15 = u_xlat16_15 * _DistortionPower;
					    u_xlat16_15 = u_xlat16_15 * 5.0;
					    u_xlat4.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat4.xy;
					    u_xlat10_4.xyz = texture2D(_Texture2, u_xlat4.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_3.xyz * u_xlat10_4.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat18 = sqrt(u_xlat18);
					    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat18 = u_xlat18 + (-u_xlat4.x);
					    u_xlat18 = unity_ShadowFadeCenterAndType.w * u_xlat18 + u_xlat4.x;
					    u_xlat18 = u_xlat18 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat4.x = texture2D(_ShadowMapTexture, vs_TEXCOORD7.xy).x;
					    u_xlatb4 = vs_TEXCOORD7.z<u_xlat4.x;
					    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat4.x = max(u_xlat4.x, _LightShadowData.x);
					    u_xlat16_2.x = (-u_xlat4.x) + 1.0;
					    u_xlat16_2.x = u_xlat18 * u_xlat16_2.x + u_xlat4.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx;
					    u_xlat3.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat3.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat0.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat2.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_15);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD7;
					out highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump float u_xlat16_4;
					mediump vec3 u_xlat16_5;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
					    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat2.w;
					    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
					    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
					    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_6;
					mediump float u_xlat16_7;
					float u_xlat15;
					mediump float u_xlat16_15;
					float u_xlat18;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.yzw = u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
					    u_xlat16_1 = max(u_xlat16_1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_1.yzw);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_15 = texture(_DistortionMap, u_xlat3.xy).x;
					    u_xlat16_15 = u_xlat16_15 + -0.5;
					    u_xlat3.xy = vec2(u_xlat16_15) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat16_3.xyz = texture(_Texture1, u_xlat3.xy).xyz;
					    u_xlat4.xy = (-vec2(u_xlat16_15)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_15 = u_xlat16_15 * _DistortionPower;
					    u_xlat16_15 = u_xlat16_15 * 5.0;
					    u_xlat4.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat4.xy;
					    u_xlat16_4.xyz = texture(_Texture2, u_xlat4.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat18 = sqrt(u_xlat18);
					    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat18 = u_xlat18 + (-u_xlat4.x);
					    u_xlat18 = unity_ShadowFadeCenterAndType.w * u_xlat18 + u_xlat4.x;
					    u_xlat18 = u_xlat18 * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
					#else
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					#endif
					    u_xlat4.xyz = vs_TEXCOORD3.www * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.www + u_xlat4.xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD4.www + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
					    u_xlat16_4.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_4.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_7 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat18 * u_xlat16_7 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx;
					    u_xlat3.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat3.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat0.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat2.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_15);
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD7;
					out highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump float u_xlat16_4;
					mediump vec3 u_xlat16_5;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
					    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat2.w;
					    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
					    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
					    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_6;
					mediump float u_xlat16_7;
					float u_xlat15;
					mediump float u_xlat16_15;
					float u_xlat18;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.yzw = u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
					    u_xlat16_1 = max(u_xlat16_1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_1.yzw);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_15 = texture(_DistortionMap, u_xlat3.xy).x;
					    u_xlat16_15 = u_xlat16_15 + -0.5;
					    u_xlat3.xy = vec2(u_xlat16_15) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat16_3.xyz = texture(_Texture1, u_xlat3.xy).xyz;
					    u_xlat4.xy = (-vec2(u_xlat16_15)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_15 = u_xlat16_15 * _DistortionPower;
					    u_xlat16_15 = u_xlat16_15 * 5.0;
					    u_xlat4.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat4.xy;
					    u_xlat16_4.xyz = texture(_Texture2, u_xlat4.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat18 = sqrt(u_xlat18);
					    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat18 = u_xlat18 + (-u_xlat4.x);
					    u_xlat18 = unity_ShadowFadeCenterAndType.w * u_xlat18 + u_xlat4.x;
					    u_xlat18 = u_xlat18 * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
					#else
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					#endif
					    u_xlat4.xyz = vs_TEXCOORD3.www * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.www + u_xlat4.xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD4.www + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
					    u_xlat16_4.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_4.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_7 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat18 * u_xlat16_7 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx;
					    u_xlat3.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat3.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat0.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat2.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_15);
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD7;
					out highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump float u_xlat16_4;
					mediump vec3 u_xlat16_5;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
					    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat2.w;
					    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
					    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
					    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_6;
					mediump float u_xlat16_7;
					float u_xlat15;
					mediump float u_xlat16_15;
					float u_xlat18;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.yzw = u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
					    u_xlat16_1 = max(u_xlat16_1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_1.yzw);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_15 = texture(_DistortionMap, u_xlat3.xy).x;
					    u_xlat16_15 = u_xlat16_15 + -0.5;
					    u_xlat3.xy = vec2(u_xlat16_15) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat16_3.xyz = texture(_Texture1, u_xlat3.xy).xyz;
					    u_xlat4.xy = (-vec2(u_xlat16_15)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_15 = u_xlat16_15 * _DistortionPower;
					    u_xlat16_15 = u_xlat16_15 * 5.0;
					    u_xlat4.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat4.xy;
					    u_xlat16_4.xyz = texture(_Texture2, u_xlat4.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat18 = sqrt(u_xlat18);
					    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat18 = u_xlat18 + (-u_xlat4.x);
					    u_xlat18 = unity_ShadowFadeCenterAndType.w * u_xlat18 + u_xlat4.x;
					    u_xlat18 = u_xlat18 * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
					#else
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					#endif
					    u_xlat4.xyz = vs_TEXCOORD3.www * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.www + u_xlat4.xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD4.www + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
					    u_xlat16_4.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_4.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_7 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat18 * u_xlat16_7 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx;
					    u_xlat3.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat3.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat0.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat2.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_15);
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					lowp vec4 u_xlat10_0;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_5;
					vec2 u_xlat8;
					mediump float u_xlat16_8;
					lowp float u_xlat10_8;
					vec2 u_xlat10;
					float u_xlat12;
					mediump float u_xlat16_12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1 = max(u_xlat16_1, 0.0);
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat0.xyw = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat0.w = u_xlat0.z * 10.0;
					    u_xlat8.x = dot(u_xlat0.xyw, u_xlat0.xyw);
					    u_xlat8.x = inversesqrt(u_xlat8.x);
					    u_xlat0.xy = u_xlat0.xy * u_xlat8.xx + vec2(1.0, 1.0);
					    u_xlat8.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_8 = texture2D(_DistortionMap, u_xlat8.xy).x;
					    u_xlat16_8 = u_xlat10_8 + -0.5;
					    u_xlat16_12 = u_xlat16_8 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat10_0.xyw = texture2D(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyw = u_xlat10_0.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_8) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_8)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_3.xyz * u_xlat10_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
					    SV_Target0.xyz = u_xlat16_5.xyz * vec3(u_xlat16_1) + u_xlat0.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					lowp vec4 u_xlat10_0;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_5;
					vec2 u_xlat8;
					mediump float u_xlat16_8;
					lowp float u_xlat10_8;
					vec2 u_xlat10;
					float u_xlat12;
					mediump float u_xlat16_12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1 = max(u_xlat16_1, 0.0);
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat0.xyw = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat0.w = u_xlat0.z * 10.0;
					    u_xlat8.x = dot(u_xlat0.xyw, u_xlat0.xyw);
					    u_xlat8.x = inversesqrt(u_xlat8.x);
					    u_xlat0.xy = u_xlat0.xy * u_xlat8.xx + vec2(1.0, 1.0);
					    u_xlat8.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_8 = texture2D(_DistortionMap, u_xlat8.xy).x;
					    u_xlat16_8 = u_xlat10_8 + -0.5;
					    u_xlat16_12 = u_xlat16_8 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat10_0.xyw = texture2D(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyw = u_xlat10_0.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_8) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_8)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_3.xyz * u_xlat10_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
					    SV_Target0.xyz = u_xlat16_5.xyz * vec3(u_xlat16_1) + u_xlat0.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					lowp vec4 u_xlat10_0;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_5;
					vec2 u_xlat8;
					mediump float u_xlat16_8;
					lowp float u_xlat10_8;
					vec2 u_xlat10;
					float u_xlat12;
					mediump float u_xlat16_12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1 = max(u_xlat16_1, 0.0);
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat0.xyw = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat0.w = u_xlat0.z * 10.0;
					    u_xlat8.x = dot(u_xlat0.xyw, u_xlat0.xyw);
					    u_xlat8.x = inversesqrt(u_xlat8.x);
					    u_xlat0.xy = u_xlat0.xy * u_xlat8.xx + vec2(1.0, 1.0);
					    u_xlat8.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_8 = texture2D(_DistortionMap, u_xlat8.xy).x;
					    u_xlat16_8 = u_xlat10_8 + -0.5;
					    u_xlat16_12 = u_xlat16_8 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat10_0.xyw = texture2D(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyw = u_xlat10_0.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_8) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_8)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_3.xyz * u_xlat10_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
					    SV_Target0.xyz = u_xlat16_5.xyz * vec3(u_xlat16_1) + u_xlat0.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_5;
					vec2 u_xlat8;
					mediump float u_xlat16_8;
					vec2 u_xlat10;
					float u_xlat12;
					mediump float u_xlat16_12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1 = max(u_xlat16_1, 0.0);
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat0.xyw = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat0.w = u_xlat0.z * 10.0;
					    u_xlat8.x = dot(u_xlat0.xyw, u_xlat0.xyw);
					    u_xlat8.x = inversesqrt(u_xlat8.x);
					    u_xlat0.xy = u_xlat0.xy * u_xlat8.xx + vec2(1.0, 1.0);
					    u_xlat8.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_8 = texture(_DistortionMap, u_xlat8.xy).x;
					    u_xlat16_8 = u_xlat16_8 + -0.5;
					    u_xlat16_12 = u_xlat16_8 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat16_0.xyw = texture(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyw = u_xlat16_0.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_8) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_8)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
					    SV_Target0.xyz = u_xlat16_5.xyz * vec3(u_xlat16_1) + u_xlat0.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_5;
					vec2 u_xlat8;
					mediump float u_xlat16_8;
					vec2 u_xlat10;
					float u_xlat12;
					mediump float u_xlat16_12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1 = max(u_xlat16_1, 0.0);
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat0.xyw = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat0.w = u_xlat0.z * 10.0;
					    u_xlat8.x = dot(u_xlat0.xyw, u_xlat0.xyw);
					    u_xlat8.x = inversesqrt(u_xlat8.x);
					    u_xlat0.xy = u_xlat0.xy * u_xlat8.xx + vec2(1.0, 1.0);
					    u_xlat8.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_8 = texture(_DistortionMap, u_xlat8.xy).x;
					    u_xlat16_8 = u_xlat16_8 + -0.5;
					    u_xlat16_12 = u_xlat16_8 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat16_0.xyw = texture(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyw = u_xlat16_0.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_8) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_8)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
					    SV_Target0.xyz = u_xlat16_5.xyz * vec3(u_xlat16_1) + u_xlat0.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_5;
					vec2 u_xlat8;
					mediump float u_xlat16_8;
					vec2 u_xlat10;
					float u_xlat12;
					mediump float u_xlat16_12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1 = max(u_xlat16_1, 0.0);
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat0.xyw = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat0.w = u_xlat0.z * 10.0;
					    u_xlat8.x = dot(u_xlat0.xyw, u_xlat0.xyw);
					    u_xlat8.x = inversesqrt(u_xlat8.x);
					    u_xlat0.xy = u_xlat0.xy * u_xlat8.xx + vec2(1.0, 1.0);
					    u_xlat8.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_8 = texture(_DistortionMap, u_xlat8.xy).x;
					    u_xlat16_8 = u_xlat16_8 + -0.5;
					    u_xlat16_12 = u_xlat16_8 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat16_0.xyw = texture(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyw = u_xlat16_0.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_8) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_8)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
					    SV_Target0.xyz = u_xlat16_5.xyz * vec3(u_xlat16_1) + u_xlat0.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					mediump vec3 u_xlat16_5;
					vec4 u_xlat6;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2 = vec4(u_xlat22) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
					    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat4.xyz = u_xlat2.xyw;
					    vs_TEXCOORD2.z = u_xlat4.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.z = u_xlat4.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat4.z;
					    u_xlat16_5.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_5.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_5.x);
					    u_xlat16_1 = u_xlat2.ywzx * u_xlat2;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xyz = log2(u_xlat16_5.xyz);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat3.xyz = exp2(u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat5 = u_xlat4.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat6 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat6 * u_xlat4.xxxx + u_xlat5;
					    u_xlat2 = u_xlat0 * u_xlat2.wwzw + u_xlat4;
					    u_xlat1 = u_xlat6 * u_xlat6 + u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat1 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD5.xyz = u_xlat3.xyz + u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec3 u_xlat16_1;
					vec4 u_xlat2;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					lowp vec3 u_xlat10_4;
					mediump vec3 u_xlat16_5;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_0.x = texture2D(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0 = u_xlat10_0.x + -0.5;
					    u_xlat4.xy = vec2(u_xlat16_0) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat10_4.xyz = texture2D(_Texture1, u_xlat4.xy).xyz;
					    u_xlat2.xy = (-vec2(u_xlat16_0)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0 = u_xlat16_0 * _DistortionPower;
					    u_xlat16_0 = u_xlat16_0 * 5.0;
					    u_xlat2.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture2, u_xlat2.xy).xyz;
					    u_xlat16_4.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_4.xyz * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat16_4.xyz * vs_TEXCOORD5.xyz;
					    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
					    u_xlat2.x = vs_TEXCOORD2.w;
					    u_xlat2.y = vs_TEXCOORD3.w;
					    u_xlat2.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
					    u_xlat2.xyz = u_xlat4.yyy * vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * u_xlat4.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat4.zzz + u_xlat2.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat4.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat2.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + vec2(u_xlat16_0);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					mediump vec3 u_xlat16_5;
					vec4 u_xlat6;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2 = vec4(u_xlat22) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
					    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat4.xyz = u_xlat2.xyw;
					    vs_TEXCOORD2.z = u_xlat4.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.z = u_xlat4.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat4.z;
					    u_xlat16_5.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_5.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_5.x);
					    u_xlat16_1 = u_xlat2.ywzx * u_xlat2;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xyz = log2(u_xlat16_5.xyz);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat3.xyz = exp2(u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat5 = u_xlat4.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat6 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat6 * u_xlat4.xxxx + u_xlat5;
					    u_xlat2 = u_xlat0 * u_xlat2.wwzw + u_xlat4;
					    u_xlat1 = u_xlat6 * u_xlat6 + u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat1 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD5.xyz = u_xlat3.xyz + u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec3 u_xlat16_1;
					vec4 u_xlat2;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					lowp vec3 u_xlat10_4;
					mediump vec3 u_xlat16_5;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_0.x = texture2D(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0 = u_xlat10_0.x + -0.5;
					    u_xlat4.xy = vec2(u_xlat16_0) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat10_4.xyz = texture2D(_Texture1, u_xlat4.xy).xyz;
					    u_xlat2.xy = (-vec2(u_xlat16_0)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0 = u_xlat16_0 * _DistortionPower;
					    u_xlat16_0 = u_xlat16_0 * 5.0;
					    u_xlat2.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture2, u_xlat2.xy).xyz;
					    u_xlat16_4.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_4.xyz * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat16_4.xyz * vs_TEXCOORD5.xyz;
					    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
					    u_xlat2.x = vs_TEXCOORD2.w;
					    u_xlat2.y = vs_TEXCOORD3.w;
					    u_xlat2.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
					    u_xlat2.xyz = u_xlat4.yyy * vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * u_xlat4.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat4.zzz + u_xlat2.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat4.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat2.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + vec2(u_xlat16_0);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					mediump vec3 u_xlat16_5;
					vec4 u_xlat6;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2 = vec4(u_xlat22) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
					    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat4.xyz = u_xlat2.xyw;
					    vs_TEXCOORD2.z = u_xlat4.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.z = u_xlat4.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat4.z;
					    u_xlat16_5.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_5.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_5.x);
					    u_xlat16_1 = u_xlat2.ywzx * u_xlat2;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xyz = log2(u_xlat16_5.xyz);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat3.xyz = exp2(u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat5 = u_xlat4.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat6 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat6 * u_xlat4.xxxx + u_xlat5;
					    u_xlat2 = u_xlat0 * u_xlat2.wwzw + u_xlat4;
					    u_xlat1 = u_xlat6 * u_xlat6 + u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat1 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD5.xyz = u_xlat3.xyz + u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec3 u_xlat16_1;
					vec4 u_xlat2;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					lowp vec3 u_xlat10_4;
					mediump vec3 u_xlat16_5;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_0.x = texture2D(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0 = u_xlat10_0.x + -0.5;
					    u_xlat4.xy = vec2(u_xlat16_0) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat10_4.xyz = texture2D(_Texture1, u_xlat4.xy).xyz;
					    u_xlat2.xy = (-vec2(u_xlat16_0)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0 = u_xlat16_0 * _DistortionPower;
					    u_xlat16_0 = u_xlat16_0 * 5.0;
					    u_xlat2.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture2, u_xlat2.xy).xyz;
					    u_xlat16_4.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_4.xyz * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat16_4.xyz * vs_TEXCOORD5.xyz;
					    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
					    u_xlat2.x = vs_TEXCOORD2.w;
					    u_xlat2.y = vs_TEXCOORD3.w;
					    u_xlat2.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
					    u_xlat2.xyz = u_xlat4.yyy * vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * u_xlat4.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat4.zzz + u_xlat2.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat4.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat2.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + vec2(u_xlat16_0);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					mediump vec3 u_xlat16_5;
					vec4 u_xlat6;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2 = vec4(u_xlat22) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
					    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat4.xyz = u_xlat2.xyw;
					    vs_TEXCOORD2.z = u_xlat4.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.z = u_xlat4.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat4.z;
					    u_xlat16_5.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_5.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_5.x);
					    u_xlat16_1 = u_xlat2.ywzx * u_xlat2;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xyz = log2(u_xlat16_5.xyz);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat3.xyz = exp2(u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat5 = u_xlat4.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat6 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat6 * u_xlat4.xxxx + u_xlat5;
					    u_xlat2 = u_xlat0 * u_xlat2.wwzw + u_xlat4;
					    u_xlat1 = u_xlat6 * u_xlat6 + u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat1 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD5.xyz = u_xlat3.xyz + u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_0.x = texture(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0.x = u_xlat16_0.x + -0.5;
					    u_xlat4.xy = u_xlat16_0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat16_4.xyz = texture(_Texture1, u_xlat4.xy).xyz;
					    u_xlat2.xy = (-u_xlat16_0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0.x = u_xlat16_0.x * _DistortionPower;
					    u_xlat16_0.x = u_xlat16_0.x * 5.0;
					    u_xlat2.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture2, u_xlat2.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_4.xyz * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat16_4.xyz * vs_TEXCOORD5.xyz;
					    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
					    u_xlat2.x = vs_TEXCOORD2.w;
					    u_xlat2.y = vs_TEXCOORD3.w;
					    u_xlat2.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
					    u_xlat2.xyz = u_xlat4.yyy * vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * u_xlat4.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat4.zzz + u_xlat2.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat4.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat2.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + u_xlat16_0.xx;
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					mediump vec3 u_xlat16_5;
					vec4 u_xlat6;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2 = vec4(u_xlat22) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
					    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat4.xyz = u_xlat2.xyw;
					    vs_TEXCOORD2.z = u_xlat4.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.z = u_xlat4.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat4.z;
					    u_xlat16_5.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_5.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_5.x);
					    u_xlat16_1 = u_xlat2.ywzx * u_xlat2;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xyz = log2(u_xlat16_5.xyz);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat3.xyz = exp2(u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat5 = u_xlat4.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat6 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat6 * u_xlat4.xxxx + u_xlat5;
					    u_xlat2 = u_xlat0 * u_xlat2.wwzw + u_xlat4;
					    u_xlat1 = u_xlat6 * u_xlat6 + u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat1 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD5.xyz = u_xlat3.xyz + u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_0.x = texture(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0.x = u_xlat16_0.x + -0.5;
					    u_xlat4.xy = u_xlat16_0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat16_4.xyz = texture(_Texture1, u_xlat4.xy).xyz;
					    u_xlat2.xy = (-u_xlat16_0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0.x = u_xlat16_0.x * _DistortionPower;
					    u_xlat16_0.x = u_xlat16_0.x * 5.0;
					    u_xlat2.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture2, u_xlat2.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_4.xyz * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat16_4.xyz * vs_TEXCOORD5.xyz;
					    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
					    u_xlat2.x = vs_TEXCOORD2.w;
					    u_xlat2.y = vs_TEXCOORD3.w;
					    u_xlat2.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
					    u_xlat2.xyz = u_xlat4.yyy * vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * u_xlat4.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat4.zzz + u_xlat2.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat4.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat2.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + u_xlat16_0.xx;
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					mediump vec3 u_xlat16_5;
					vec4 u_xlat6;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2 = vec4(u_xlat22) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
					    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat4.xyz = u_xlat2.xyw;
					    vs_TEXCOORD2.z = u_xlat4.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.z = u_xlat4.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat4.z;
					    u_xlat16_5.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_5.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_5.x);
					    u_xlat16_1 = u_xlat2.ywzx * u_xlat2;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xyz = log2(u_xlat16_5.xyz);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat3.xyz = exp2(u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat5 = u_xlat4.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat6 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat6 * u_xlat4.xxxx + u_xlat5;
					    u_xlat2 = u_xlat0 * u_xlat2.wwzw + u_xlat4;
					    u_xlat1 = u_xlat6 * u_xlat6 + u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat1 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD5.xyz = u_xlat3.xyz + u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_0.x = texture(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0.x = u_xlat16_0.x + -0.5;
					    u_xlat4.xy = u_xlat16_0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat16_4.xyz = texture(_Texture1, u_xlat4.xy).xyz;
					    u_xlat2.xy = (-u_xlat16_0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0.x = u_xlat16_0.x * _DistortionPower;
					    u_xlat16_0.x = u_xlat16_0.x * 5.0;
					    u_xlat2.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture2, u_xlat2.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_4.xyz * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat16_4.xyz * vs_TEXCOORD5.xyz;
					    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
					    u_xlat2.x = vs_TEXCOORD2.w;
					    u_xlat2.y = vs_TEXCOORD3.w;
					    u_xlat2.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
					    u_xlat2.xyz = u_xlat4.yyy * vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * u_xlat4.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat4.zzz + u_xlat2.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat4.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat2.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + u_xlat16_0.xx;
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD7;
					varying highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat16) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.w = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat4.y;
					    vs_TEXCOORD4.w = u_xlat4.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD7;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					mediump float u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					vec2 u_xlat3;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_5;
					float u_xlat12;
					mediump float u_xlat16_12;
					lowp float u_xlat10_12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1 = max(u_xlat16_1, 0.0);
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat2.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat12 = u_xlat12 + (-u_xlat2.x);
					    u_xlat12 = unity_ShadowFadeCenterAndType.w * u_xlat12 + u_xlat2.x;
					    u_xlat12 = u_xlat12 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat2.x = texture2D(_ShadowMapTexture, vs_TEXCOORD7.xy).x;
					    u_xlatb2 = vs_TEXCOORD7.z<u_xlat2.x;
					    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat2.x = max(u_xlat2.x, _LightShadowData.x);
					    u_xlat16_5.x = (-u_xlat2.x) + 1.0;
					    u_xlat16_5.x = u_xlat12 * u_xlat16_5.x + u_xlat2.x;
					    u_xlat16_5.xyz = u_xlat16_5.xxx * _LightColor0.xyz;
					    u_xlat2.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_12 = texture2D(_DistortionMap, u_xlat2.xy).x;
					    u_xlat16_12 = u_xlat10_12 + -0.5;
					    u_xlat2.xy = vec2(u_xlat16_12) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat3.xy = (-vec2(u_xlat16_12)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_12 = u_xlat16_12 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat3.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat3.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat3.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
					    u_xlat2.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat0.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat2.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower);
					    SV_Target0.xyz = u_xlat16_5.xyz * vec3(u_xlat16_1) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD7;
					varying highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat16) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.w = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat4.y;
					    vs_TEXCOORD4.w = u_xlat4.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD7;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					mediump float u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					vec2 u_xlat3;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_5;
					float u_xlat12;
					mediump float u_xlat16_12;
					lowp float u_xlat10_12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1 = max(u_xlat16_1, 0.0);
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat2.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat12 = u_xlat12 + (-u_xlat2.x);
					    u_xlat12 = unity_ShadowFadeCenterAndType.w * u_xlat12 + u_xlat2.x;
					    u_xlat12 = u_xlat12 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat2.x = texture2D(_ShadowMapTexture, vs_TEXCOORD7.xy).x;
					    u_xlatb2 = vs_TEXCOORD7.z<u_xlat2.x;
					    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat2.x = max(u_xlat2.x, _LightShadowData.x);
					    u_xlat16_5.x = (-u_xlat2.x) + 1.0;
					    u_xlat16_5.x = u_xlat12 * u_xlat16_5.x + u_xlat2.x;
					    u_xlat16_5.xyz = u_xlat16_5.xxx * _LightColor0.xyz;
					    u_xlat2.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_12 = texture2D(_DistortionMap, u_xlat2.xy).x;
					    u_xlat16_12 = u_xlat10_12 + -0.5;
					    u_xlat2.xy = vec2(u_xlat16_12) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat3.xy = (-vec2(u_xlat16_12)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_12 = u_xlat16_12 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat3.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat3.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat3.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
					    u_xlat2.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat0.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat2.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower);
					    SV_Target0.xyz = u_xlat16_5.xyz * vec3(u_xlat16_1) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD7;
					varying highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat16) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.w = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat4.y;
					    vs_TEXCOORD4.w = u_xlat4.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD7;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					mediump float u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					vec2 u_xlat3;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_5;
					float u_xlat12;
					mediump float u_xlat16_12;
					lowp float u_xlat10_12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_1 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_1 = max(u_xlat16_1, 0.0);
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat2.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat12 = u_xlat12 + (-u_xlat2.x);
					    u_xlat12 = unity_ShadowFadeCenterAndType.w * u_xlat12 + u_xlat2.x;
					    u_xlat12 = u_xlat12 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat2.x = texture2D(_ShadowMapTexture, vs_TEXCOORD7.xy).x;
					    u_xlatb2 = vs_TEXCOORD7.z<u_xlat2.x;
					    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat2.x = max(u_xlat2.x, _LightShadowData.x);
					    u_xlat16_5.x = (-u_xlat2.x) + 1.0;
					    u_xlat16_5.x = u_xlat12 * u_xlat16_5.x + u_xlat2.x;
					    u_xlat16_5.xyz = u_xlat16_5.xxx * _LightColor0.xyz;
					    u_xlat2.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_12 = texture2D(_DistortionMap, u_xlat2.xy).x;
					    u_xlat16_12 = u_xlat10_12 + -0.5;
					    u_xlat2.xy = vec2(u_xlat16_12) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat3.xy = (-vec2(u_xlat16_12)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_12 = u_xlat16_12 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat3.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat3.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat3.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
					    u_xlat2.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat0.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat2.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower);
					    SV_Target0.xyz = u_xlat16_5.xyz * vec3(u_xlat16_1) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD7;
					out highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					vec2 u_xlat3;
					mediump vec3 u_xlat16_3;
					mediump float u_xlat16_6;
					float u_xlat12;
					mediump float u_xlat16_12;
					float u_xlat13;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat12 = u_xlat12 + (-u_xlat1.x);
					    u_xlat12 = unity_ShadowFadeCenterAndType.w * u_xlat12 + u_xlat1.x;
					    u_xlat12 = u_xlat12 * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
					#else
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vs_TEXCOORD3.www * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.www + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD4.www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat1.xy,u_xlat1.z);
					    u_xlat16_1.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_1.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_6 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat12 * u_xlat16_6 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat1.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_12 = texture(_DistortionMap, u_xlat1.xy).x;
					    u_xlat16_12 = u_xlat16_12 + -0.5;
					    u_xlat1.xy = vec2(u_xlat16_12) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat1.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat1.xy;
					    u_xlat16_1.xyz = texture(_Texture1, u_xlat1.xy).xyz;
					    u_xlat3.xy = (-vec2(u_xlat16_12)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_12 = u_xlat16_12 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat3.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat3.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat3.xy).xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz;
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat16_14 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
					    u_xlat1.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat1.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat0.x = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat1.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD7;
					out highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					vec2 u_xlat3;
					mediump vec3 u_xlat16_3;
					mediump float u_xlat16_6;
					float u_xlat12;
					mediump float u_xlat16_12;
					float u_xlat13;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat12 = u_xlat12 + (-u_xlat1.x);
					    u_xlat12 = unity_ShadowFadeCenterAndType.w * u_xlat12 + u_xlat1.x;
					    u_xlat12 = u_xlat12 * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
					#else
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vs_TEXCOORD3.www * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.www + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD4.www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat1.xy,u_xlat1.z);
					    u_xlat16_1.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_1.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_6 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat12 * u_xlat16_6 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat1.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_12 = texture(_DistortionMap, u_xlat1.xy).x;
					    u_xlat16_12 = u_xlat16_12 + -0.5;
					    u_xlat1.xy = vec2(u_xlat16_12) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat1.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat1.xy;
					    u_xlat16_1.xyz = texture(_Texture1, u_xlat1.xy).xyz;
					    u_xlat3.xy = (-vec2(u_xlat16_12)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_12 = u_xlat16_12 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat3.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat3.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat3.xy).xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz;
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat16_14 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
					    u_xlat1.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat1.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat0.x = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat1.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD7;
					out highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					vec2 u_xlat3;
					mediump vec3 u_xlat16_3;
					mediump float u_xlat16_6;
					float u_xlat12;
					mediump float u_xlat16_12;
					float u_xlat13;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat12 = u_xlat12 + (-u_xlat1.x);
					    u_xlat12 = unity_ShadowFadeCenterAndType.w * u_xlat12 + u_xlat1.x;
					    u_xlat12 = u_xlat12 * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
					#else
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vs_TEXCOORD3.www * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.www + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD4.www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat1.xy,u_xlat1.z);
					    u_xlat16_1.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_1.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_6 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat12 * u_xlat16_6 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat1.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_12 = texture(_DistortionMap, u_xlat1.xy).x;
					    u_xlat16_12 = u_xlat16_12 + -0.5;
					    u_xlat1.xy = vec2(u_xlat16_12) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat1.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat1.xy;
					    u_xlat16_1.xyz = texture(_Texture1, u_xlat1.xy).xyz;
					    u_xlat3.xy = (-vec2(u_xlat16_12)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_12 = u_xlat16_12 * _DistortionPower;
					    u_xlat16_12 = u_xlat16_12 * 5.0;
					    u_xlat3.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat3.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat3.xy).xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz;
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat16_14 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
					    u_xlat1.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat1.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat0.x = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat1.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_12);
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD7;
					varying highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat25;
					float u_xlat26;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    u_xlat25 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat26 = inversesqrt(u_xlat26);
					    u_xlat2 = vec4(u_xlat26) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
					    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.w = u_xlat4.x;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD3.w = u_xlat4.y;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.w = u_xlat4.z;
					    vs_TEXCOORD4.z = u_xlat2.w;
					    u_xlat1 = (-u_xlat4.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat4.yyyy) + unity_4LightPosY0;
					    u_xlat4 = (-u_xlat4.zzzz) + unity_4LightPosZ0;
					    u_xlat5 = u_xlat2.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat1 * u_xlat1 + u_xlat3;
					    u_xlat1 = u_xlat1 * u_xlat2.xxxx + u_xlat5;
					    u_xlat1 = u_xlat4 * u_xlat2.wwzw + u_xlat1;
					    u_xlat3 = u_xlat4 * u_xlat4 + u_xlat3;
					    u_xlat3 = max(u_xlat3, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat4 = inversesqrt(u_xlat3);
					    u_xlat3 = u_xlat3 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat3 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat3;
					    u_xlat1 = u_xlat1 * u_xlat4;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat3 * u_xlat1;
					    u_xlat3.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat3.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat3.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat16_6.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_6.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_6.x);
					    u_xlat16_2 = u_xlat2.ywzx * u_xlat2;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    vs_TEXCOORD5.xyz = u_xlat1.xyz * u_xlat3.xyz + u_xlat16_6.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD7;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					vec3 u_xlat4;
					lowp vec3 u_xlat10_4;
					bool u_xlatb4;
					mediump vec3 u_xlat16_6;
					float u_xlat15;
					mediump float u_xlat16_15;
					lowp float u_xlat10_15;
					float u_xlat18;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.yzw = u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
					    u_xlat16_1 = max(u_xlat16_1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_1.yzw);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_15 = texture2D(_DistortionMap, u_xlat3.xy).x;
					    u_xlat16_15 = u_xlat10_15 + -0.5;
					    u_xlat3.xy = vec2(u_xlat16_15) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat10_3.xyz = texture2D(_Texture1, u_xlat3.xy).xyz;
					    u_xlat4.xy = (-vec2(u_xlat16_15)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_15 = u_xlat16_15 * _DistortionPower;
					    u_xlat16_15 = u_xlat16_15 * 5.0;
					    u_xlat4.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat4.xy;
					    u_xlat10_4.xyz = texture2D(_Texture2, u_xlat4.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_3.xyz * u_xlat10_4.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat18 = sqrt(u_xlat18);
					    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat18 = u_xlat18 + (-u_xlat4.x);
					    u_xlat18 = unity_ShadowFadeCenterAndType.w * u_xlat18 + u_xlat4.x;
					    u_xlat18 = u_xlat18 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat4.x = texture2D(_ShadowMapTexture, vs_TEXCOORD7.xy).x;
					    u_xlatb4 = vs_TEXCOORD7.z<u_xlat4.x;
					    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat4.x = max(u_xlat4.x, _LightShadowData.x);
					    u_xlat16_2.x = (-u_xlat4.x) + 1.0;
					    u_xlat16_2.x = u_xlat18 * u_xlat16_2.x + u_xlat4.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx;
					    u_xlat3.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat3.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat0.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat2.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_15);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD7;
					varying highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat25;
					float u_xlat26;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    u_xlat25 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat26 = inversesqrt(u_xlat26);
					    u_xlat2 = vec4(u_xlat26) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
					    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.w = u_xlat4.x;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD3.w = u_xlat4.y;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.w = u_xlat4.z;
					    vs_TEXCOORD4.z = u_xlat2.w;
					    u_xlat1 = (-u_xlat4.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat4.yyyy) + unity_4LightPosY0;
					    u_xlat4 = (-u_xlat4.zzzz) + unity_4LightPosZ0;
					    u_xlat5 = u_xlat2.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat1 * u_xlat1 + u_xlat3;
					    u_xlat1 = u_xlat1 * u_xlat2.xxxx + u_xlat5;
					    u_xlat1 = u_xlat4 * u_xlat2.wwzw + u_xlat1;
					    u_xlat3 = u_xlat4 * u_xlat4 + u_xlat3;
					    u_xlat3 = max(u_xlat3, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat4 = inversesqrt(u_xlat3);
					    u_xlat3 = u_xlat3 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat3 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat3;
					    u_xlat1 = u_xlat1 * u_xlat4;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat3 * u_xlat1;
					    u_xlat3.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat3.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat3.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat16_6.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_6.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_6.x);
					    u_xlat16_2 = u_xlat2.ywzx * u_xlat2;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    vs_TEXCOORD5.xyz = u_xlat1.xyz * u_xlat3.xyz + u_xlat16_6.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD7;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					vec3 u_xlat4;
					lowp vec3 u_xlat10_4;
					bool u_xlatb4;
					mediump vec3 u_xlat16_6;
					float u_xlat15;
					mediump float u_xlat16_15;
					lowp float u_xlat10_15;
					float u_xlat18;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.yzw = u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
					    u_xlat16_1 = max(u_xlat16_1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_1.yzw);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_15 = texture2D(_DistortionMap, u_xlat3.xy).x;
					    u_xlat16_15 = u_xlat10_15 + -0.5;
					    u_xlat3.xy = vec2(u_xlat16_15) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat10_3.xyz = texture2D(_Texture1, u_xlat3.xy).xyz;
					    u_xlat4.xy = (-vec2(u_xlat16_15)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_15 = u_xlat16_15 * _DistortionPower;
					    u_xlat16_15 = u_xlat16_15 * 5.0;
					    u_xlat4.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat4.xy;
					    u_xlat10_4.xyz = texture2D(_Texture2, u_xlat4.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_3.xyz * u_xlat10_4.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat18 = sqrt(u_xlat18);
					    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat18 = u_xlat18 + (-u_xlat4.x);
					    u_xlat18 = unity_ShadowFadeCenterAndType.w * u_xlat18 + u_xlat4.x;
					    u_xlat18 = u_xlat18 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat4.x = texture2D(_ShadowMapTexture, vs_TEXCOORD7.xy).x;
					    u_xlatb4 = vs_TEXCOORD7.z<u_xlat4.x;
					    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat4.x = max(u_xlat4.x, _LightShadowData.x);
					    u_xlat16_2.x = (-u_xlat4.x) + 1.0;
					    u_xlat16_2.x = u_xlat18 * u_xlat16_2.x + u_xlat4.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx;
					    u_xlat3.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat3.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat0.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat2.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_15);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD7;
					varying highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat25;
					float u_xlat26;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    u_xlat25 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat26 = inversesqrt(u_xlat26);
					    u_xlat2 = vec4(u_xlat26) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
					    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.w = u_xlat4.x;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD3.w = u_xlat4.y;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.w = u_xlat4.z;
					    vs_TEXCOORD4.z = u_xlat2.w;
					    u_xlat1 = (-u_xlat4.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat4.yyyy) + unity_4LightPosY0;
					    u_xlat4 = (-u_xlat4.zzzz) + unity_4LightPosZ0;
					    u_xlat5 = u_xlat2.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat1 * u_xlat1 + u_xlat3;
					    u_xlat1 = u_xlat1 * u_xlat2.xxxx + u_xlat5;
					    u_xlat1 = u_xlat4 * u_xlat2.wwzw + u_xlat1;
					    u_xlat3 = u_xlat4 * u_xlat4 + u_xlat3;
					    u_xlat3 = max(u_xlat3, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat4 = inversesqrt(u_xlat3);
					    u_xlat3 = u_xlat3 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat3 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat3;
					    u_xlat1 = u_xlat1 * u_xlat4;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat3 * u_xlat1;
					    u_xlat3.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat3.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat3.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat16_6.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_6.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_6.x);
					    u_xlat16_2 = u_xlat2.ywzx * u_xlat2;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    vs_TEXCOORD5.xyz = u_xlat1.xyz * u_xlat3.xyz + u_xlat16_6.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD7;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					vec3 u_xlat4;
					lowp vec3 u_xlat10_4;
					bool u_xlatb4;
					mediump vec3 u_xlat16_6;
					float u_xlat15;
					mediump float u_xlat16_15;
					lowp float u_xlat10_15;
					float u_xlat18;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.yzw = u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
					    u_xlat16_1 = max(u_xlat16_1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_1.yzw);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_15 = texture2D(_DistortionMap, u_xlat3.xy).x;
					    u_xlat16_15 = u_xlat10_15 + -0.5;
					    u_xlat3.xy = vec2(u_xlat16_15) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat10_3.xyz = texture2D(_Texture1, u_xlat3.xy).xyz;
					    u_xlat4.xy = (-vec2(u_xlat16_15)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_15 = u_xlat16_15 * _DistortionPower;
					    u_xlat16_15 = u_xlat16_15 * 5.0;
					    u_xlat4.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat4.xy;
					    u_xlat10_4.xyz = texture2D(_Texture2, u_xlat4.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_3.xyz * u_xlat10_4.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat18 = sqrt(u_xlat18);
					    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat18 = u_xlat18 + (-u_xlat4.x);
					    u_xlat18 = unity_ShadowFadeCenterAndType.w * u_xlat18 + u_xlat4.x;
					    u_xlat18 = u_xlat18 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat4.x = texture2D(_ShadowMapTexture, vs_TEXCOORD7.xy).x;
					    u_xlatb4 = vs_TEXCOORD7.z<u_xlat4.x;
					    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat4.x = max(u_xlat4.x, _LightShadowData.x);
					    u_xlat16_2.x = (-u_xlat4.x) + 1.0;
					    u_xlat16_2.x = u_xlat18 * u_xlat16_2.x + u_xlat4.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx;
					    u_xlat3.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat3.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat0.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat2.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_15);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD7;
					out highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2 = vec4(u_xlat22) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
					    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat2.w;
					    u_xlat1 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat2.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat1 * u_xlat1 + u_xlat3;
					    u_xlat1 = u_xlat1 * u_xlat2.xxxx + u_xlat4;
					    u_xlat1 = u_xlat0 * u_xlat2.wwzw + u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat16_5.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_5.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_5.x);
					    u_xlat16_2 = u_xlat2.ywzx * u_xlat2;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    vs_TEXCOORD5.xyz = u_xlat0.xyz * u_xlat1.xyz + u_xlat16_5.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_6;
					mediump float u_xlat16_7;
					float u_xlat15;
					mediump float u_xlat16_15;
					float u_xlat18;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.yzw = u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
					    u_xlat16_1 = max(u_xlat16_1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_1.yzw);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_15 = texture(_DistortionMap, u_xlat3.xy).x;
					    u_xlat16_15 = u_xlat16_15 + -0.5;
					    u_xlat3.xy = vec2(u_xlat16_15) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat16_3.xyz = texture(_Texture1, u_xlat3.xy).xyz;
					    u_xlat4.xy = (-vec2(u_xlat16_15)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_15 = u_xlat16_15 * _DistortionPower;
					    u_xlat16_15 = u_xlat16_15 * 5.0;
					    u_xlat4.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat4.xy;
					    u_xlat16_4.xyz = texture(_Texture2, u_xlat4.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat18 = sqrt(u_xlat18);
					    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat18 = u_xlat18 + (-u_xlat4.x);
					    u_xlat18 = unity_ShadowFadeCenterAndType.w * u_xlat18 + u_xlat4.x;
					    u_xlat18 = u_xlat18 * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
					#else
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					#endif
					    u_xlat4.xyz = vs_TEXCOORD3.www * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.www + u_xlat4.xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD4.www + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
					    u_xlat16_4.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_4.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_7 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat18 * u_xlat16_7 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx;
					    u_xlat3.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat3.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat0.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat2.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_15);
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD7;
					out highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2 = vec4(u_xlat22) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
					    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat2.w;
					    u_xlat1 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat2.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat1 * u_xlat1 + u_xlat3;
					    u_xlat1 = u_xlat1 * u_xlat2.xxxx + u_xlat4;
					    u_xlat1 = u_xlat0 * u_xlat2.wwzw + u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat16_5.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_5.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_5.x);
					    u_xlat16_2 = u_xlat2.ywzx * u_xlat2;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    vs_TEXCOORD5.xyz = u_xlat0.xyz * u_xlat1.xyz + u_xlat16_5.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_6;
					mediump float u_xlat16_7;
					float u_xlat15;
					mediump float u_xlat16_15;
					float u_xlat18;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.yzw = u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
					    u_xlat16_1 = max(u_xlat16_1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_1.yzw);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_15 = texture(_DistortionMap, u_xlat3.xy).x;
					    u_xlat16_15 = u_xlat16_15 + -0.5;
					    u_xlat3.xy = vec2(u_xlat16_15) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat16_3.xyz = texture(_Texture1, u_xlat3.xy).xyz;
					    u_xlat4.xy = (-vec2(u_xlat16_15)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_15 = u_xlat16_15 * _DistortionPower;
					    u_xlat16_15 = u_xlat16_15 * 5.0;
					    u_xlat4.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat4.xy;
					    u_xlat16_4.xyz = texture(_Texture2, u_xlat4.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat18 = sqrt(u_xlat18);
					    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat18 = u_xlat18 + (-u_xlat4.x);
					    u_xlat18 = unity_ShadowFadeCenterAndType.w * u_xlat18 + u_xlat4.x;
					    u_xlat18 = u_xlat18 * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
					#else
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					#endif
					    u_xlat4.xyz = vs_TEXCOORD3.www * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.www + u_xlat4.xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD4.www + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
					    u_xlat16_4.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_4.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_7 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat18 * u_xlat16_7 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx;
					    u_xlat3.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat3.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat0.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat2.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_15);
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD7;
					out highp vec4 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2 = vec4(u_xlat22) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
					    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat2.w;
					    u_xlat1 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat2.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat1 * u_xlat1 + u_xlat3;
					    u_xlat1 = u_xlat1 * u_xlat2.xxxx + u_xlat4;
					    u_xlat1 = u_xlat0 * u_xlat2.wwzw + u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat16_5.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_5.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_5.x);
					    u_xlat16_2 = u_xlat2.ywzx * u_xlat2;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    vs_TEXCOORD5.xyz = u_xlat0.xyz * u_xlat1.xyz + u_xlat16_5.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 _LightColor0;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform mediump sampler2D _ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_6;
					mediump float u_xlat16_7;
					float u_xlat15;
					mediump float u_xlat16_15;
					float u_xlat18;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z;
					    u_xlat0.y = vs_TEXCOORD3.z;
					    u_xlat0.z = vs_TEXCOORD4.z;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.yzw = u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
					    u_xlat16_1 = max(u_xlat16_1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = log2(u_xlat16_1.yzw);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_15 = texture(_DistortionMap, u_xlat3.xy).x;
					    u_xlat16_15 = u_xlat16_15 + -0.5;
					    u_xlat3.xy = vec2(u_xlat16_15) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat16_3.xyz = texture(_Texture1, u_xlat3.xy).xyz;
					    u_xlat4.xy = (-vec2(u_xlat16_15)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_15 = u_xlat16_15 * _DistortionPower;
					    u_xlat16_15 = u_xlat16_15 * 5.0;
					    u_xlat4.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat4.xy;
					    u_xlat16_4.xyz = texture(_Texture2, u_xlat4.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat4.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat18 = sqrt(u_xlat18);
					    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat4.x = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat18 = u_xlat18 + (-u_xlat4.x);
					    u_xlat18 = unity_ShadowFadeCenterAndType.w * u_xlat18 + u_xlat4.x;
					    u_xlat18 = u_xlat18 * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
					#else
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					#endif
					    u_xlat4.xyz = vs_TEXCOORD3.www * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.www + u_xlat4.xyz;
					    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD4.www + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
					    u_xlat16_4.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat16_4.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_7 = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat18 * u_xlat16_7 + u_xlat16_2.x;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx;
					    u_xlat3.xyz = u_xlat0.yyy * vs_TEXCOORD3.xyz;
					    u_xlat3.xyz = vs_TEXCOORD2.xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat2.w = u_xlat2.z * 10.0;
					    u_xlat0.x = dot(u_xlat2.xyw, u_xlat2.xyw);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xy = u_xlat2.xy * u_xlat0.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(u_xlat16_15);
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
			}
		}
		Pass {
			Name "PREPASS"
			LOD 150
			Tags { "IGNOREPROJECTOR" = "False" "LIGHTMODE" = "PREPASSBASE" }
			GpuProgramID 90349
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD0.y = u_xlat3.x;
					    vs_TEXCOORD0.x = u_xlat2.z;
					    vs_TEXCOORD0.z = u_xlat1.y;
					    vs_TEXCOORD1.x = u_xlat2.x;
					    vs_TEXCOORD2.x = u_xlat2.y;
					    vs_TEXCOORD1.z = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat1.x;
					    vs_TEXCOORD1.w = u_xlat0.y;
					    vs_TEXCOORD2.w = u_xlat0.z;
					    vs_TEXCOORD1.y = u_xlat3.y;
					    vs_TEXCOORD2.y = u_xlat3.z;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD0.z;
					    u_xlat0.y = vs_TEXCOORD1.z;
					    u_xlat0.z = vs_TEXCOORD2.z;
					    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3 = inversesqrt(u_xlat3);
					    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target0.w = 0.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD0.y = u_xlat3.x;
					    vs_TEXCOORD0.x = u_xlat2.z;
					    vs_TEXCOORD0.z = u_xlat1.y;
					    vs_TEXCOORD1.x = u_xlat2.x;
					    vs_TEXCOORD2.x = u_xlat2.y;
					    vs_TEXCOORD1.z = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat1.x;
					    vs_TEXCOORD1.w = u_xlat0.y;
					    vs_TEXCOORD2.w = u_xlat0.z;
					    vs_TEXCOORD1.y = u_xlat3.y;
					    vs_TEXCOORD2.y = u_xlat3.z;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD0.z;
					    u_xlat0.y = vs_TEXCOORD1.z;
					    u_xlat0.z = vs_TEXCOORD2.z;
					    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3 = inversesqrt(u_xlat3);
					    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target0.w = 0.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD0.y = u_xlat3.x;
					    vs_TEXCOORD0.x = u_xlat2.z;
					    vs_TEXCOORD0.z = u_xlat1.y;
					    vs_TEXCOORD1.x = u_xlat2.x;
					    vs_TEXCOORD2.x = u_xlat2.y;
					    vs_TEXCOORD1.z = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat1.x;
					    vs_TEXCOORD1.w = u_xlat0.y;
					    vs_TEXCOORD2.w = u_xlat0.z;
					    vs_TEXCOORD1.y = u_xlat3.y;
					    vs_TEXCOORD2.y = u_xlat3.z;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD0.z;
					    u_xlat0.y = vs_TEXCOORD1.z;
					    u_xlat0.z = vs_TEXCOORD2.z;
					    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3 = inversesqrt(u_xlat3);
					    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target0.w = 0.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD0.y = u_xlat3.x;
					    vs_TEXCOORD0.x = u_xlat2.z;
					    vs_TEXCOORD0.z = u_xlat1.y;
					    vs_TEXCOORD1.x = u_xlat2.x;
					    vs_TEXCOORD2.x = u_xlat2.y;
					    vs_TEXCOORD1.z = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat1.x;
					    vs_TEXCOORD1.w = u_xlat0.y;
					    vs_TEXCOORD2.w = u_xlat0.z;
					    vs_TEXCOORD1.y = u_xlat3.y;
					    vs_TEXCOORD2.y = u_xlat3.z;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD0.z;
					    u_xlat0.y = vs_TEXCOORD1.z;
					    u_xlat0.z = vs_TEXCOORD2.z;
					    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3 = inversesqrt(u_xlat3);
					    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target0.w = 0.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD0.y = u_xlat3.x;
					    vs_TEXCOORD0.x = u_xlat2.z;
					    vs_TEXCOORD0.z = u_xlat1.y;
					    vs_TEXCOORD1.x = u_xlat2.x;
					    vs_TEXCOORD2.x = u_xlat2.y;
					    vs_TEXCOORD1.z = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat1.x;
					    vs_TEXCOORD1.w = u_xlat0.y;
					    vs_TEXCOORD2.w = u_xlat0.z;
					    vs_TEXCOORD1.y = u_xlat3.y;
					    vs_TEXCOORD2.y = u_xlat3.z;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD0.z;
					    u_xlat0.y = vs_TEXCOORD1.z;
					    u_xlat0.z = vs_TEXCOORD2.z;
					    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3 = inversesqrt(u_xlat3);
					    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target0.w = 0.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD0.y = u_xlat3.x;
					    vs_TEXCOORD0.x = u_xlat2.z;
					    vs_TEXCOORD0.z = u_xlat1.y;
					    vs_TEXCOORD1.x = u_xlat2.x;
					    vs_TEXCOORD2.x = u_xlat2.y;
					    vs_TEXCOORD1.z = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat1.x;
					    vs_TEXCOORD1.w = u_xlat0.y;
					    vs_TEXCOORD2.w = u_xlat0.z;
					    vs_TEXCOORD1.y = u_xlat3.y;
					    vs_TEXCOORD2.y = u_xlat3.z;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD0.z;
					    u_xlat0.y = vs_TEXCOORD1.z;
					    u_xlat0.z = vs_TEXCOORD2.z;
					    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3 = inversesqrt(u_xlat3);
					    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target0.w = 0.0;
					    return;
					}
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3"
				}
			}
		}
		Pass {
			Name "PREPASS"
			LOD 150
			Tags { "IGNOREPROJECTOR" = "False" "LIGHTMODE" = "PREPASSFINAL" }
			ZWrite Off
			GpuProgramID 168723
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					varying highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec3 vs_TEXCOORD6;
					#define SV_Target0 gl_FragData[0]
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					vec3 u_xlat3;
					lowp vec3 u_xlat10_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					lowp float u_xlat10_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_9 = texture2D(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat10_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat10_1.xyw = texture2D(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat10_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_3.xyz * u_xlat10_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat10_3.xyz = texture2D(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_0.xyz = log2(u_xlat16_0.xyz);
					    u_xlat3.xyz = (-u_xlat16_0.xyz) + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					varying highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec3 vs_TEXCOORD6;
					#define SV_Target0 gl_FragData[0]
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					vec3 u_xlat3;
					lowp vec3 u_xlat10_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					lowp float u_xlat10_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_9 = texture2D(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat10_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat10_1.xyw = texture2D(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat10_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_3.xyz * u_xlat10_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat10_3.xyz = texture2D(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_0.xyz = log2(u_xlat16_0.xyz);
					    u_xlat3.xyz = (-u_xlat16_0.xyz) + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					varying highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec3 vs_TEXCOORD6;
					#define SV_Target0 gl_FragData[0]
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					vec3 u_xlat3;
					lowp vec3 u_xlat10_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					lowp float u_xlat10_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_9 = texture2D(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat10_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat10_1.xyw = texture2D(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat10_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_3.xyz * u_xlat10_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat10_3.xyz = texture2D(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_0.xyz = log2(u_xlat16_0.xyz);
					    u_xlat3.xyz = (-u_xlat16_0.xyz) + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					out highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2D _LightBuffer;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in highp vec3 vs_TEXCOORD6;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_9 = texture(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat16_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat16_1.xyw = texture(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat16_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat16_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat16_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_0.xyz = log2(u_xlat16_0.xyz);
					    u_xlat3.xyz = (-u_xlat16_0.xyz) + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					out highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2D _LightBuffer;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in highp vec3 vs_TEXCOORD6;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_9 = texture(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat16_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat16_1.xyw = texture(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat16_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat16_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat16_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_0.xyz = log2(u_xlat16_0.xyz);
					    u_xlat3.xyz = (-u_xlat16_0.xyz) + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					out highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2D _LightBuffer;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in highp vec3 vs_TEXCOORD6;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_9 = texture(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat16_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat16_1.xyw = texture(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat16_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat16_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat16_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_0.xyz = log2(u_xlat16_0.xyz);
					    u_xlat3.xyz = (-u_xlat16_0.xyz) + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					varying highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec3 vs_TEXCOORD6;
					#define SV_Target0 gl_FragData[0]
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					vec3 u_xlat3;
					lowp vec3 u_xlat10_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					lowp float u_xlat10_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_9 = texture2D(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat10_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat10_1.xyw = texture2D(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat10_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_3.xyz * u_xlat10_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat10_3.xyz = texture2D(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_0.xyz = log2(u_xlat16_0.xyz);
					    u_xlat3.xyz = (-u_xlat16_0.xyz) + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					varying highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec3 vs_TEXCOORD6;
					#define SV_Target0 gl_FragData[0]
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					vec3 u_xlat3;
					lowp vec3 u_xlat10_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					lowp float u_xlat10_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_9 = texture2D(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat10_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat10_1.xyw = texture2D(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat10_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_3.xyz * u_xlat10_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat10_3.xyz = texture2D(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_0.xyz = log2(u_xlat16_0.xyz);
					    u_xlat3.xyz = (-u_xlat16_0.xyz) + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					varying highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec3 vs_TEXCOORD6;
					#define SV_Target0 gl_FragData[0]
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					vec3 u_xlat3;
					lowp vec3 u_xlat10_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					lowp float u_xlat10_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_9 = texture2D(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat10_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat10_1.xyw = texture2D(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat10_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_3.xyz * u_xlat10_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat10_3.xyz = texture2D(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_0.xyz = log2(u_xlat16_0.xyz);
					    u_xlat3.xyz = (-u_xlat16_0.xyz) + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					out highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2D _LightBuffer;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in highp vec3 vs_TEXCOORD6;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_9 = texture(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat16_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat16_1.xyw = texture(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat16_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat16_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat16_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_0.xyz = log2(u_xlat16_0.xyz);
					    u_xlat3.xyz = (-u_xlat16_0.xyz) + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					out highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2D _LightBuffer;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in highp vec3 vs_TEXCOORD6;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_9 = texture(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat16_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat16_1.xyw = texture(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat16_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat16_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat16_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_0.xyz = log2(u_xlat16_0.xyz);
					    u_xlat3.xyz = (-u_xlat16_0.xyz) + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					out highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2D _LightBuffer;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in highp vec3 vs_TEXCOORD6;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_9 = texture(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat16_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat16_1.xyw = texture(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat16_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat16_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat16_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_0.xyz = log2(u_xlat16_0.xyz);
					    u_xlat3.xyz = (-u_xlat16_0.xyz) + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					varying highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec3 vs_TEXCOORD6;
					#define SV_Target0 gl_FragData[0]
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					vec3 u_xlat3;
					lowp vec3 u_xlat10_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					lowp float u_xlat10_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_9 = texture2D(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat10_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat10_1.xyw = texture2D(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat10_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_3.xyz * u_xlat10_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat10_3.xyz = texture2D(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat3.xyz = u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					varying highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec3 vs_TEXCOORD6;
					#define SV_Target0 gl_FragData[0]
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					vec3 u_xlat3;
					lowp vec3 u_xlat10_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					lowp float u_xlat10_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_9 = texture2D(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat10_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat10_1.xyw = texture2D(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat10_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_3.xyz * u_xlat10_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat10_3.xyz = texture2D(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat3.xyz = u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					varying highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec3 vs_TEXCOORD6;
					#define SV_Target0 gl_FragData[0]
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					vec3 u_xlat3;
					lowp vec3 u_xlat10_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					lowp float u_xlat10_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_9 = texture2D(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat10_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat10_1.xyw = texture2D(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat10_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_3.xyz * u_xlat10_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat10_3.xyz = texture2D(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat3.xyz = u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					out highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2D _LightBuffer;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in highp vec3 vs_TEXCOORD6;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_9 = texture(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat16_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat16_1.xyw = texture(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat16_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat16_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat16_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat3.xyz = u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					out highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2D _LightBuffer;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in highp vec3 vs_TEXCOORD6;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_9 = texture(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat16_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat16_1.xyw = texture(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat16_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat16_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat16_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat3.xyz = u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					out highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2D _LightBuffer;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in highp vec3 vs_TEXCOORD6;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_9 = texture(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat16_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat16_1.xyw = texture(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat16_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat16_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat16_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat3.xyz = u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					varying highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec3 vs_TEXCOORD6;
					#define SV_Target0 gl_FragData[0]
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					vec3 u_xlat3;
					lowp vec3 u_xlat10_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					lowp float u_xlat10_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_9 = texture2D(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat10_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat10_1.xyw = texture2D(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat10_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_3.xyz * u_xlat10_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat10_3.xyz = texture2D(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat3.xyz = u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					varying highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec3 vs_TEXCOORD6;
					#define SV_Target0 gl_FragData[0]
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					vec3 u_xlat3;
					lowp vec3 u_xlat10_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					lowp float u_xlat10_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_9 = texture2D(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat10_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat10_1.xyw = texture2D(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat10_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_3.xyz * u_xlat10_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat10_3.xyz = texture2D(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat3.xyz = u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD5;
					varying highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					uniform lowp sampler2D _LightBuffer;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying highp vec3 vs_TEXCOORD6;
					#define SV_Target0 gl_FragData[0]
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					vec3 u_xlat3;
					lowp vec3 u_xlat10_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					lowp float u_xlat10_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_9 = texture2D(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat10_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat10_1.xyw = texture2D(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat10_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat10_3.xyz = texture2D(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat10_2.xyz = texture2D(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_3.xyz * u_xlat10_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat10_3.xyz = texture2D(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat10_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat3.xyz = u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					out highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2D _LightBuffer;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in highp vec3 vs_TEXCOORD6;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_9 = texture(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat16_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat16_1.xyw = texture(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat16_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat16_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat16_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat3.xyz = u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					out highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2D _LightBuffer;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in highp vec3 vs_TEXCOORD6;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_9 = texture(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat16_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat16_1.xyw = texture(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat16_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat16_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat16_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat3.xyz = u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					out highp vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat24;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
					    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
					    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat4.xyz);
					    vs_TEXCOORD3.xyz = u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat1.zw;
					    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_6.x = u_xlat4.y * u_xlat4.y;
					    u_xlat16_6.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_6.x);
					    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
					    u_xlat4.w = 1.0;
					    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
					    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
					    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
					    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
					    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_6.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					uniform mediump sampler2D _LightBuffer;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in mediump vec3 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in highp vec3 vs_TEXCOORD6;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec2 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec2 u_xlat9;
					mediump float u_xlat16_9;
					vec2 u_xlat10;
					mediump float u_xlat16_13;
					void main()
					{
					    u_xlat16_0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
					    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat1.xy = u_xlat16_0.xy;
					    u_xlat1.z = u_xlat16_0.z * 10.0;
					    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9.x = inversesqrt(u_xlat9.x);
					    u_xlat1.xy = u_xlat1.xy * u_xlat9.xx + vec2(1.0, 1.0);
					    u_xlat9.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_9 = texture(_DistortionMap, u_xlat9.xy).x;
					    u_xlat16_9 = u_xlat16_9 + -0.5;
					    u_xlat16_13 = u_xlat16_9 * _DistortionPower;
					    u_xlat16_13 = u_xlat16_13 * 5.0;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(u_xlat16_13);
					    u_xlat16_1.xyw = texture(_Reflection, u_xlat1.xy).xyz;
					    u_xlat1.xyw = u_xlat16_1.xyw * vec3(_ReflectPower);
					    u_xlat2.xy = vec2(u_xlat16_9) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat10.xy = (-vec2(u_xlat16_9)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat10.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat10.xy;
					    u_xlat16_3.xyz = texture(_Texture2, u_xlat10.xy).xyz;
					    u_xlat2.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat2.xy;
					    u_xlat16_2.xyz = texture(_Texture1, u_xlat2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat16_3.xyz = texture(_LightBuffer, u_xlat3.xy).xyz;
					    u_xlat16_0.xyz = max(u_xlat16_3.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat3.xyz = u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat3.xyz + u_xlat1.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3"
				}
			}
		}
		Pass {
			Name "DEFERRED"
			LOD 150
			Tags { "IGNOREPROJECTOR" = "False" "LIGHTMODE" = "DEFERRED" }
			GpuProgramID 247101
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD2.z = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.x = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_0.x = texture2D(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0 = u_xlat10_0.x + -0.5;
					    u_xlat3.xy = vec2(u_xlat16_0) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat10_3.xyz = texture2D(_Texture1, u_xlat3.xy).xyz;
					    u_xlat1.xy = (-vec2(u_xlat16_0)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0 = u_xlat16_0 * _DistortionPower;
					    u_xlat16_0 = u_xlat16_0 * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat10_1.xyz = texture2D(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_3.xyz * u_xlat10_1.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat3.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_2.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
					    u_xlat16_2.xyz = u_xlat16_2.xxx * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_2.xy;
					    u_xlat1.z = u_xlat16_2.z * 10.0;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xy = u_xlat1.xy * u_xlat3.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat3.xy * vec2(0.5, 0.5) + vec2(u_xlat16_0);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower);
					    SV_Target3.xyz = exp2((-u_xlat0.xyz));
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD2.z = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.x = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_0.x = texture2D(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0 = u_xlat10_0.x + -0.5;
					    u_xlat3.xy = vec2(u_xlat16_0) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat10_3.xyz = texture2D(_Texture1, u_xlat3.xy).xyz;
					    u_xlat1.xy = (-vec2(u_xlat16_0)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0 = u_xlat16_0 * _DistortionPower;
					    u_xlat16_0 = u_xlat16_0 * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat10_1.xyz = texture2D(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_3.xyz * u_xlat10_1.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat3.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_2.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
					    u_xlat16_2.xyz = u_xlat16_2.xxx * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_2.xy;
					    u_xlat1.z = u_xlat16_2.z * 10.0;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xy = u_xlat1.xy * u_xlat3.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat3.xy * vec2(0.5, 0.5) + vec2(u_xlat16_0);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower);
					    SV_Target3.xyz = exp2((-u_xlat0.xyz));
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD2.z = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.x = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_0.x = texture2D(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0 = u_xlat10_0.x + -0.5;
					    u_xlat3.xy = vec2(u_xlat16_0) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat10_3.xyz = texture2D(_Texture1, u_xlat3.xy).xyz;
					    u_xlat1.xy = (-vec2(u_xlat16_0)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0 = u_xlat16_0 * _DistortionPower;
					    u_xlat16_0 = u_xlat16_0 * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat10_1.xyz = texture2D(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_3.xyz * u_xlat10_1.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat3.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_2.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
					    u_xlat16_2.xyz = u_xlat16_2.xxx * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_2.xy;
					    u_xlat1.z = u_xlat16_2.z * 10.0;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xy = u_xlat1.xy * u_xlat3.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat3.xy * vec2(0.5, 0.5) + vec2(u_xlat16_0);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower);
					    SV_Target3.xyz = exp2((-u_xlat0.xyz));
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD2.z = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.x = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_0.x = texture(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0.x = u_xlat16_0.x + -0.5;
					    u_xlat3.xy = u_xlat16_0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat16_3.xyz = texture(_Texture1, u_xlat3.xy).xyz;
					    u_xlat1.xy = (-u_xlat16_0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0.x = u_xlat16_0.x * _DistortionPower;
					    u_xlat16_0.x = u_xlat16_0.x * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat16_1.xyz = texture(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat3.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_2.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
					    u_xlat16_2.xyz = u_xlat16_2.xxx * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_2.xy;
					    u_xlat1.z = u_xlat16_2.z * 10.0;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xy = u_xlat1.xy * u_xlat3.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat3.xy * vec2(0.5, 0.5) + u_xlat16_0.xx;
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower);
					    SV_Target3.xyz = exp2((-u_xlat0.xyz));
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD2.z = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.x = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_0.x = texture(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0.x = u_xlat16_0.x + -0.5;
					    u_xlat3.xy = u_xlat16_0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat16_3.xyz = texture(_Texture1, u_xlat3.xy).xyz;
					    u_xlat1.xy = (-u_xlat16_0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0.x = u_xlat16_0.x * _DistortionPower;
					    u_xlat16_0.x = u_xlat16_0.x * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat16_1.xyz = texture(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat3.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_2.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
					    u_xlat16_2.xyz = u_xlat16_2.xxx * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_2.xy;
					    u_xlat1.z = u_xlat16_2.z * 10.0;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xy = u_xlat1.xy * u_xlat3.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat3.xy * vec2(0.5, 0.5) + u_xlat16_0.xx;
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower);
					    SV_Target3.xyz = exp2((-u_xlat0.xyz));
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD2.z = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.x = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_0.x = texture(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0.x = u_xlat16_0.x + -0.5;
					    u_xlat3.xy = u_xlat16_0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat16_3.xyz = texture(_Texture1, u_xlat3.xy).xyz;
					    u_xlat1.xy = (-u_xlat16_0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0.x = u_xlat16_0.x * _DistortionPower;
					    u_xlat16_0.x = u_xlat16_0.x * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat16_1.xyz = texture(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat3.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_2.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
					    u_xlat16_2.xyz = u_xlat16_2.xxx * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_2.xy;
					    u_xlat1.z = u_xlat16_2.z * 10.0;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xy = u_xlat1.xy * u_xlat3.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat3.xy * vec2(0.5, 0.5) + u_xlat16_0.xx;
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower);
					    SV_Target3.xyz = exp2((-u_xlat0.xyz));
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD6;
					varying mediump vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat2 = vec4(u_xlat19) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.x = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    vs_TEXCOORD4.z = u_xlat2.z;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat2.xyw);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat2.yzwx * u_xlat2.xywz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_4.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD7.xyz = u_xlat1.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying mediump vec3 vs_TEXCOORD7;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec2 u_xlat0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_0.x = texture2D(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0 = u_xlat10_0.x + -0.5;
					    u_xlat4.xy = vec2(u_xlat16_0) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat10_4.xyz = texture2D(_Texture1, u_xlat4.xy).xyz;
					    u_xlat1.xy = (-vec2(u_xlat16_0)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0 = u_xlat16_0 * _DistortionPower;
					    u_xlat16_0 = u_xlat16_0 * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat10_1.xyz = texture2D(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_4.xyz = u_xlat10_4.xyz * u_xlat10_1.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_4.xyz;
					    u_xlat16_2.xyz = u_xlat16_4.xyz * vs_TEXCOORD7.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat4.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_14 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_14 = inversesqrt(u_xlat16_14);
					    u_xlat16_3.xyz = vec3(u_xlat16_14) * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_3.xy;
					    u_xlat1.z = u_xlat16_3.z * 10.0;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat1.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + vec2(u_xlat16_0);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(_ReflectPower) + u_xlat16_2.xyz;
					    SV_Target3.xyz = exp2((-u_xlat16_2.xyz));
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD6;
					varying mediump vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat2 = vec4(u_xlat19) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.x = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    vs_TEXCOORD4.z = u_xlat2.z;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat2.xyw);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat2.yzwx * u_xlat2.xywz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_4.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD7.xyz = u_xlat1.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying mediump vec3 vs_TEXCOORD7;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec2 u_xlat0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_0.x = texture2D(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0 = u_xlat10_0.x + -0.5;
					    u_xlat4.xy = vec2(u_xlat16_0) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat10_4.xyz = texture2D(_Texture1, u_xlat4.xy).xyz;
					    u_xlat1.xy = (-vec2(u_xlat16_0)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0 = u_xlat16_0 * _DistortionPower;
					    u_xlat16_0 = u_xlat16_0 * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat10_1.xyz = texture2D(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_4.xyz = u_xlat10_4.xyz * u_xlat10_1.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_4.xyz;
					    u_xlat16_2.xyz = u_xlat16_4.xyz * vs_TEXCOORD7.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat4.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_14 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_14 = inversesqrt(u_xlat16_14);
					    u_xlat16_3.xyz = vec3(u_xlat16_14) * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_3.xy;
					    u_xlat1.z = u_xlat16_3.z * 10.0;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat1.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + vec2(u_xlat16_0);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(_ReflectPower) + u_xlat16_2.xyz;
					    SV_Target3.xyz = exp2((-u_xlat16_2.xyz));
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD6;
					varying mediump vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat2 = vec4(u_xlat19) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.x = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    vs_TEXCOORD4.z = u_xlat2.z;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat2.xyw);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat2.yzwx * u_xlat2.xywz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_4.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD7.xyz = u_xlat1.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying mediump vec3 vs_TEXCOORD7;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec2 u_xlat0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_0.x = texture2D(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0 = u_xlat10_0.x + -0.5;
					    u_xlat4.xy = vec2(u_xlat16_0) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat10_4.xyz = texture2D(_Texture1, u_xlat4.xy).xyz;
					    u_xlat1.xy = (-vec2(u_xlat16_0)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0 = u_xlat16_0 * _DistortionPower;
					    u_xlat16_0 = u_xlat16_0 * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat10_1.xyz = texture2D(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_4.xyz = u_xlat10_4.xyz * u_xlat10_1.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_4.xyz;
					    u_xlat16_2.xyz = u_xlat16_4.xyz * vs_TEXCOORD7.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat4.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_14 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_14 = inversesqrt(u_xlat16_14);
					    u_xlat16_3.xyz = vec3(u_xlat16_14) * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_3.xy;
					    u_xlat1.z = u_xlat16_3.z * 10.0;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat1.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + vec2(u_xlat16_0);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(_ReflectPower) + u_xlat16_2.xyz;
					    SV_Target3.xyz = exp2((-u_xlat16_2.xyz));
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD6;
					out mediump vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat2 = vec4(u_xlat19) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.x = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    vs_TEXCOORD4.z = u_xlat2.z;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat2.xyw);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat2.yzwx * u_xlat2.xywz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_4.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD7.xyz = u_xlat1.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					in mediump vec3 vs_TEXCOORD7;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec2 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_0.x = texture(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0.x = u_xlat16_0.x + -0.5;
					    u_xlat4.xy = u_xlat16_0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat16_4.xyz = texture(_Texture1, u_xlat4.xy).xyz;
					    u_xlat1.xy = (-u_xlat16_0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0.x = u_xlat16_0.x * _DistortionPower;
					    u_xlat16_0.x = u_xlat16_0.x * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat16_1.xyz = texture(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_1.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_4.xyz;
					    u_xlat16_2.xyz = u_xlat16_4.xyz * vs_TEXCOORD7.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat4.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_14 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_14 = inversesqrt(u_xlat16_14);
					    u_xlat16_3.xyz = vec3(u_xlat16_14) * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_3.xy;
					    u_xlat1.z = u_xlat16_3.z * 10.0;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat1.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + u_xlat16_0.xx;
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(_ReflectPower) + u_xlat16_2.xyz;
					    SV_Target3.xyz = exp2((-u_xlat16_2.xyz));
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD6;
					out mediump vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat2 = vec4(u_xlat19) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.x = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    vs_TEXCOORD4.z = u_xlat2.z;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat2.xyw);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat2.yzwx * u_xlat2.xywz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_4.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD7.xyz = u_xlat1.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					in mediump vec3 vs_TEXCOORD7;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec2 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_0.x = texture(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0.x = u_xlat16_0.x + -0.5;
					    u_xlat4.xy = u_xlat16_0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat16_4.xyz = texture(_Texture1, u_xlat4.xy).xyz;
					    u_xlat1.xy = (-u_xlat16_0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0.x = u_xlat16_0.x * _DistortionPower;
					    u_xlat16_0.x = u_xlat16_0.x * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat16_1.xyz = texture(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_1.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_4.xyz;
					    u_xlat16_2.xyz = u_xlat16_4.xyz * vs_TEXCOORD7.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat4.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_14 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_14 = inversesqrt(u_xlat16_14);
					    u_xlat16_3.xyz = vec3(u_xlat16_14) * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_3.xy;
					    u_xlat1.z = u_xlat16_3.z * 10.0;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat1.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + u_xlat16_0.xx;
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(_ReflectPower) + u_xlat16_2.xyz;
					    SV_Target3.xyz = exp2((-u_xlat16_2.xyz));
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD6;
					out mediump vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat2 = vec4(u_xlat19) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.x = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    vs_TEXCOORD4.z = u_xlat2.z;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat2.xyw);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat2.yzwx * u_xlat2.xywz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_4.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD7.xyz = u_xlat1.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					in mediump vec3 vs_TEXCOORD7;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec2 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_0.x = texture(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0.x = u_xlat16_0.x + -0.5;
					    u_xlat4.xy = u_xlat16_0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat16_4.xyz = texture(_Texture1, u_xlat4.xy).xyz;
					    u_xlat1.xy = (-u_xlat16_0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0.x = u_xlat16_0.x * _DistortionPower;
					    u_xlat16_0.x = u_xlat16_0.x * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat16_1.xyz = texture(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_1.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_4.xyz;
					    u_xlat16_2.xyz = u_xlat16_4.xyz * vs_TEXCOORD7.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat4.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_14 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_14 = inversesqrt(u_xlat16_14);
					    u_xlat16_3.xyz = vec3(u_xlat16_14) * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_3.xy;
					    u_xlat1.z = u_xlat16_3.z * 10.0;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat1.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + u_xlat16_0.xx;
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(_ReflectPower) + u_xlat16_2.xyz;
					    SV_Target3.xyz = exp2((-u_xlat16_2.xyz));
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD2.z = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.x = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_0.x = texture2D(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0 = u_xlat10_0.x + -0.5;
					    u_xlat3.xy = vec2(u_xlat16_0) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat10_3.xyz = texture2D(_Texture1, u_xlat3.xy).xyz;
					    u_xlat1.xy = (-vec2(u_xlat16_0)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0 = u_xlat16_0 * _DistortionPower;
					    u_xlat16_0 = u_xlat16_0 * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat10_1.xyz = texture2D(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_3.xyz * u_xlat10_1.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat3.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_2.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
					    u_xlat16_2.xyz = u_xlat16_2.xxx * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_2.xy;
					    u_xlat1.z = u_xlat16_2.z * 10.0;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xy = u_xlat1.xy * u_xlat3.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat3.xy * vec2(0.5, 0.5) + vec2(u_xlat16_0);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower);
					    SV_Target3.xyz = u_xlat0.xyz;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD2.z = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.x = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_0.x = texture2D(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0 = u_xlat10_0.x + -0.5;
					    u_xlat3.xy = vec2(u_xlat16_0) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat10_3.xyz = texture2D(_Texture1, u_xlat3.xy).xyz;
					    u_xlat1.xy = (-vec2(u_xlat16_0)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0 = u_xlat16_0 * _DistortionPower;
					    u_xlat16_0 = u_xlat16_0 * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat10_1.xyz = texture2D(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_3.xyz * u_xlat10_1.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat3.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_2.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
					    u_xlat16_2.xyz = u_xlat16_2.xxx * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_2.xy;
					    u_xlat1.z = u_xlat16_2.z * 10.0;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xy = u_xlat1.xy * u_xlat3.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat3.xy * vec2(0.5, 0.5) + vec2(u_xlat16_0);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower);
					    SV_Target3.xyz = u_xlat0.xyz;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD2.z = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.x = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_0.x = texture2D(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0 = u_xlat10_0.x + -0.5;
					    u_xlat3.xy = vec2(u_xlat16_0) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat10_3.xyz = texture2D(_Texture1, u_xlat3.xy).xyz;
					    u_xlat1.xy = (-vec2(u_xlat16_0)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0 = u_xlat16_0 * _DistortionPower;
					    u_xlat16_0 = u_xlat16_0 * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat10_1.xyz = texture2D(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_3.xyz * u_xlat10_1.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat3.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_2.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
					    u_xlat16_2.xyz = u_xlat16_2.xxx * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_2.xy;
					    u_xlat1.z = u_xlat16_2.z * 10.0;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xy = u_xlat1.xy * u_xlat3.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat3.xy * vec2(0.5, 0.5) + vec2(u_xlat16_0);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectPower);
					    SV_Target3.xyz = u_xlat0.xyz;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD2.z = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.x = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_0.x = texture(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0.x = u_xlat16_0.x + -0.5;
					    u_xlat3.xy = u_xlat16_0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat16_3.xyz = texture(_Texture1, u_xlat3.xy).xyz;
					    u_xlat1.xy = (-u_xlat16_0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0.x = u_xlat16_0.x * _DistortionPower;
					    u_xlat16_0.x = u_xlat16_0.x * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat16_1.xyz = texture(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat3.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_2.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
					    u_xlat16_2.xyz = u_xlat16_2.xxx * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_2.xy;
					    u_xlat1.z = u_xlat16_2.z * 10.0;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xy = u_xlat1.xy * u_xlat3.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat3.xy * vec2(0.5, 0.5) + u_xlat16_0.xx;
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower);
					    SV_Target3.xyz = u_xlat0.xyz;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD2.z = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.x = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_0.x = texture(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0.x = u_xlat16_0.x + -0.5;
					    u_xlat3.xy = u_xlat16_0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat16_3.xyz = texture(_Texture1, u_xlat3.xy).xyz;
					    u_xlat1.xy = (-u_xlat16_0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0.x = u_xlat16_0.x * _DistortionPower;
					    u_xlat16_0.x = u_xlat16_0.x * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat16_1.xyz = texture(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat3.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_2.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
					    u_xlat16_2.xyz = u_xlat16_2.xxx * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_2.xy;
					    u_xlat1.z = u_xlat16_2.z * 10.0;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xy = u_xlat1.xy * u_xlat3.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat3.xy * vec2(0.5, 0.5) + u_xlat16_0.xx;
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower);
					    SV_Target3.xyz = u_xlat0.xyz;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD2.z = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.x = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_0.x = texture(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0.x = u_xlat16_0.x + -0.5;
					    u_xlat3.xy = u_xlat16_0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat3.xy;
					    u_xlat16_3.xyz = texture(_Texture1, u_xlat3.xy).xyz;
					    u_xlat1.xy = (-u_xlat16_0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0.x = u_xlat16_0.x * _DistortionPower;
					    u_xlat16_0.x = u_xlat16_0.x * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat16_1.xyz = texture(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat3.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_2.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
					    u_xlat16_2.xyz = u_xlat16_2.xxx * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_2.xy;
					    u_xlat1.z = u_xlat16_2.z * 10.0;
					    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xy = u_xlat1.xy * u_xlat3.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat3.xy * vec2(0.5, 0.5) + u_xlat16_0.xx;
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_ReflectPower);
					    SV_Target3.xyz = u_xlat0.xyz;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD6;
					varying mediump vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat2 = vec4(u_xlat19) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.x = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    vs_TEXCOORD4.z = u_xlat2.z;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat2.xyw);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat2.yzwx * u_xlat2.xywz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_4.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD7.xyz = u_xlat1.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying mediump vec3 vs_TEXCOORD7;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec2 u_xlat0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_0.x = texture2D(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0 = u_xlat10_0.x + -0.5;
					    u_xlat4.xy = vec2(u_xlat16_0) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat10_4.xyz = texture2D(_Texture1, u_xlat4.xy).xyz;
					    u_xlat1.xy = (-vec2(u_xlat16_0)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0 = u_xlat16_0 * _DistortionPower;
					    u_xlat16_0 = u_xlat16_0 * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat10_1.xyz = texture2D(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_4.xyz = u_xlat10_4.xyz * u_xlat10_1.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_4.xyz;
					    u_xlat16_2.xyz = u_xlat16_4.xyz * vs_TEXCOORD7.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat4.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_14 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_14 = inversesqrt(u_xlat16_14);
					    u_xlat16_3.xyz = vec3(u_xlat16_14) * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_3.xy;
					    u_xlat1.z = u_xlat16_3.z * 10.0;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat1.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + vec2(u_xlat16_0);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    SV_Target3.xyz = u_xlat10_0.xyz * vec3(_ReflectPower) + u_xlat16_2.xyz;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD6;
					varying mediump vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat2 = vec4(u_xlat19) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.x = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    vs_TEXCOORD4.z = u_xlat2.z;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat2.xyw);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat2.yzwx * u_xlat2.xywz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_4.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD7.xyz = u_xlat1.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying mediump vec3 vs_TEXCOORD7;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec2 u_xlat0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_0.x = texture2D(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0 = u_xlat10_0.x + -0.5;
					    u_xlat4.xy = vec2(u_xlat16_0) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat10_4.xyz = texture2D(_Texture1, u_xlat4.xy).xyz;
					    u_xlat1.xy = (-vec2(u_xlat16_0)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0 = u_xlat16_0 * _DistortionPower;
					    u_xlat16_0 = u_xlat16_0 * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat10_1.xyz = texture2D(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_4.xyz = u_xlat10_4.xyz * u_xlat10_1.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_4.xyz;
					    u_xlat16_2.xyz = u_xlat16_4.xyz * vs_TEXCOORD7.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat4.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_14 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_14 = inversesqrt(u_xlat16_14);
					    u_xlat16_3.xyz = vec3(u_xlat16_14) * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_3.xy;
					    u_xlat1.z = u_xlat16_3.z * 10.0;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat1.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + vec2(u_xlat16_0);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    SV_Target3.xyz = u_xlat10_0.xyz * vec3(_ReflectPower) + u_xlat16_2.xyz;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_TANGENT0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD6;
					varying mediump vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat2 = vec4(u_xlat19) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.x = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    vs_TEXCOORD4.z = u_xlat2.z;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat2.xyw);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat2.yzwx * u_xlat2.xywz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_4.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD7.xyz = u_xlat1.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					#ifdef GL_EXT_draw_buffers
					#extension GL_EXT_draw_buffers : enable
					#endif
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform lowp sampler2D _DistortionMap;
					uniform lowp sampler2D _Reflection;
					uniform lowp sampler2D _Texture1;
					uniform lowp sampler2D _Texture2;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD4;
					varying mediump vec3 vs_TEXCOORD5;
					varying mediump vec3 vs_TEXCOORD7;
					#define SV_Target0 gl_FragData[0]
					#define SV_Target1 gl_FragData[1]
					#define SV_Target2 gl_FragData[2]
					#define SV_Target3 gl_FragData[3]
					vec2 u_xlat0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat10_0.x = texture2D(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0 = u_xlat10_0.x + -0.5;
					    u_xlat4.xy = vec2(u_xlat16_0) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat10_4.xyz = texture2D(_Texture1, u_xlat4.xy).xyz;
					    u_xlat1.xy = (-vec2(u_xlat16_0)) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0 = u_xlat16_0 * _DistortionPower;
					    u_xlat16_0 = u_xlat16_0 * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat10_1.xyz = texture2D(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_4.xyz = u_xlat10_4.xyz * u_xlat10_1.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_4.xyz;
					    u_xlat16_2.xyz = u_xlat16_4.xyz * vs_TEXCOORD7.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat4.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_14 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_14 = inversesqrt(u_xlat16_14);
					    u_xlat16_3.xyz = vec3(u_xlat16_14) * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_3.xy;
					    u_xlat1.z = u_xlat16_3.z * 10.0;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat1.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + vec2(u_xlat16_0);
					    u_xlat10_0.xyz = texture2D(_Reflection, u_xlat0.xy).xyz;
					    SV_Target3.xyz = u_xlat10_0.xyz * vec3(_ReflectPower) + u_xlat16_2.xyz;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD6;
					out mediump vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat2 = vec4(u_xlat19) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.x = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    vs_TEXCOORD4.z = u_xlat2.z;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat2.xyw);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat2.yzwx * u_xlat2.xywz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_4.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD7.xyz = u_xlat1.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					in mediump vec3 vs_TEXCOORD7;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec2 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_0.x = texture(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0.x = u_xlat16_0.x + -0.5;
					    u_xlat4.xy = u_xlat16_0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat16_4.xyz = texture(_Texture1, u_xlat4.xy).xyz;
					    u_xlat1.xy = (-u_xlat16_0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0.x = u_xlat16_0.x * _DistortionPower;
					    u_xlat16_0.x = u_xlat16_0.x * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat16_1.xyz = texture(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_1.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_4.xyz;
					    u_xlat16_2.xyz = u_xlat16_4.xyz * vs_TEXCOORD7.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat4.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_14 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_14 = inversesqrt(u_xlat16_14);
					    u_xlat16_3.xyz = vec3(u_xlat16_14) * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_3.xy;
					    u_xlat1.z = u_xlat16_3.z * 10.0;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat1.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + u_xlat16_0.xx;
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    SV_Target3.xyz = u_xlat16_0.xyz * vec3(_ReflectPower) + u_xlat16_2.xyz;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD6;
					out mediump vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat2 = vec4(u_xlat19) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.x = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    vs_TEXCOORD4.z = u_xlat2.z;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat2.xyw);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat2.yzwx * u_xlat2.xywz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_4.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD7.xyz = u_xlat1.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					in mediump vec3 vs_TEXCOORD7;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec2 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_0.x = texture(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0.x = u_xlat16_0.x + -0.5;
					    u_xlat4.xy = u_xlat16_0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat16_4.xyz = texture(_Texture1, u_xlat4.xy).xyz;
					    u_xlat1.xy = (-u_xlat16_0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0.x = u_xlat16_0.x * _DistortionPower;
					    u_xlat16_0.x = u_xlat16_0.x * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat16_1.xyz = texture(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_1.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_4.xyz;
					    u_xlat16_2.xyz = u_xlat16_4.xyz * vs_TEXCOORD7.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat4.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_14 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_14 = inversesqrt(u_xlat16_14);
					    u_xlat16_3.xyz = vec3(u_xlat16_14) * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_3.xy;
					    u_xlat1.z = u_xlat16_3.z * 10.0;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat1.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + u_xlat16_0.xx;
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    SV_Target3.xyz = u_xlat16_0.xyz * vec3(_ReflectPower) + u_xlat16_2.xyz;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _DistortionMap_ST;
					uniform 	vec4 _Texture1_ST;
					uniform 	vec4 _Texture2_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD6;
					out mediump vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat2 = vec4(u_xlat19) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD2.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.y;
					    vs_TEXCOORD4.x = u_xlat1.z;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat3.y = dot(u_xlat0.xyz, u_xlat3.xyz);
					    vs_TEXCOORD4.z = u_xlat2.z;
					    u_xlat3.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat3.z = dot(u_xlat0.xyz, u_xlat2.xyw);
					    vs_TEXCOORD5.xyz = u_xlat3.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat2.yzwx * u_xlat2.xywz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_4.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD7.xyz = u_xlat1.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	mediump vec4 _Color;
					uniform 	mediump float _MainTexSpeed;
					uniform 	mediump float _Texture2Speed;
					uniform 	mediump float _DistortionSpeed;
					uniform 	mediump float _DistortionPower;
					uniform 	float _ReflectPower;
					uniform mediump sampler2D _DistortionMap;
					uniform mediump sampler2D _Reflection;
					uniform mediump sampler2D _Texture1;
					uniform mediump sampler2D _Texture2;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD5;
					in mediump vec3 vs_TEXCOORD7;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec2 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xy = vec2(vec2(_DistortionSpeed, _DistortionSpeed)) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat16_0.x = texture(_DistortionMap, u_xlat0.xy).x;
					    u_xlat16_0.x = u_xlat16_0.x + -0.5;
					    u_xlat4.xy = u_xlat16_0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat4.xy = vec2(_MainTexSpeed) * _Time.xx + u_xlat4.xy;
					    u_xlat16_4.xyz = texture(_Texture1, u_xlat4.xy).xyz;
					    u_xlat1.xy = (-u_xlat16_0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat16_0.x = u_xlat16_0.x * _DistortionPower;
					    u_xlat16_0.x = u_xlat16_0.x * 5.0;
					    u_xlat1.xy = vec2(vec2(_Texture2Speed, _Texture2Speed)) * _Time.xx + u_xlat1.xy;
					    u_xlat16_1.xyz = texture(_Texture2, u_xlat1.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_1.xyz;
					    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat16_4.xyz;
					    u_xlat16_2.xyz = u_xlat16_4.xyz * vs_TEXCOORD7.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = vs_TEXCOORD2.z;
					    u_xlat1.y = vs_TEXCOORD3.z;
					    u_xlat1.z = vs_TEXCOORD4.z;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat4.xyz;
					    SV_Target2.w = 1.0;
					    u_xlat16_14 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
					    u_xlat16_14 = inversesqrt(u_xlat16_14);
					    u_xlat16_3.xyz = vec3(u_xlat16_14) * vs_TEXCOORD5.xyz;
					    u_xlat1.xy = u_xlat16_3.xy;
					    u_xlat1.z = u_xlat16_3.z * 10.0;
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xy = u_xlat1.xy * u_xlat4.xx + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + u_xlat16_0.xx;
					    u_xlat16_0.xyz = texture(_Reflection, u_xlat0.xy).xyz;
					    SV_Target3.xyz = u_xlat16_0.xyz * vec3(_ReflectPower) + u_xlat16_2.xyz;
					    SV_Target3.w = 1.0;
					    return;
					}
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "UNITY_HDR_ON" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES3"
				}
			}
		}
		Pass {
			Name "Meta"
			LOD 150
			Tags { "IGNOREPROJECTOR" = "False" "LIGHTMODE" = "META" }
			Cull Off
			GpuProgramID 294938
		}
	}
	Fallback "Diffuse"
}