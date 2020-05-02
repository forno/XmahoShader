Shader "Xmaho/Dissolve/LowerDissolve"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _DissolveThreshold ("Dissolve Threshold", Range(0,1)) = 0.0
        _LowestHight ("Lowest Hight", Float) = 0.0
        _HighestHight ("Highest Hight", Float) = 1.0
        _Epsilon ("Epsilon", Float) = 0.00001
        [HDR] _EmissionColor ("Emission Color", Color) = (0,1,0.3,1)
        _EmissionWidth ("Emission Width", Range(0,1)) = 0.01
        _FluctuationFactor ("Fluctuation Factor", Float) = 0.01
        _TimeFactor ("Time Factor", Float) = 1
    }
    SubShader
    {
        Tags {
            "RenderType"="TransparentCutout"
            "Queue"="AlphaTest"
        }
        LOD 200
        Cull Off

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows addshadow

        #pragma target 5.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 worldPos;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        half _DissolveThreshold;
        float _LowestHight;
        float _HighestHight;
        half _Epsilon;
        float4 _EmissionColor;
        half _EmissionWidth;
        half _FluctuationFactor;
        half _TimeFactor;

        #include "../Library/utility.cginc"
        #include "../Library/noise.cginc"

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float3 local_pos = to_local(IN.worldPos);
            float fluctuation_y = mad(_FluctuationFactor, mad(0.5, snoise(mad(_TimeFactor, _Time.y, local_pos)), 0.5), local_pos.y);
            float normalized_y = saturate((fluctuation_y - _LowestHight) * rcp((_HighestHight + _FluctuationFactor + _Epsilon) - _LowestHight)); // saturate are no cost
            half dissolve_level = mad(1 - _EmissionWidth, normalized_y, _EmissionWidth - _DissolveThreshold);
            clip(dissolve_level);

            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = lerp(c.rgb, _EmissionColor, saturate((_EmissionWidth - dissolve_level) * rcp(_EmissionWidth)));
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
