/*
MIT License

Copyright (c) 2020 FORNO

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
Shader "Xmaho/Infinity/InfinitePlane"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _BumpMap ("Bumpmap", 2D) = "bump" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _GroundHeight ("Ground Height", Float) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows vertex:vert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 5.0

        #include "Packages/link.xmaho.shader/Runtime/Library/camera.cginc"
        #include "Packages/link.xmaho.shader/Runtime/Library/noise.cginc"

        sampler2D _MainTex;
        float4 _MainTex_ST;
        sampler2D _BumpMap;

        struct Input
        {
            float3 worldPos;
            float2 customUV;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        float _GroundHeight;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void vert(inout appdata_full v, out Input o) {
            float center_distance = abs(camera_far_clip() - camera_near_clip()) * 0.5;
            float3 center = camera_position() + camera_forward() * (center_distance + abs(camera_near_clip()));
            float3 pos = float3(v.vertex.x * center_distance * 0.5 + center.x,
                                _GroundHeight,
                                v.vertex.z * center_distance * 0.5 + center.z);
            v.vertex = float4(pos, v.vertex.w);
            UNITY_INITIALIZE_OUTPUT(Input, o);
            o.customUV = TRANSFORM_TEX(pos.xz, _MainTex);
        }

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float2 uv = IN.customUV;
            float2 off = rgrad2(floor(uv), 0);
            uv = frac(uv) + off.xy;

            float dx = ddx(uv);
            float dy = ddy(uv);

            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, uv, dx, dy) * _Color;
            o.Albedo = c.rgb;
            o.Normal = UnpackNormal(tex2D(_BumpMap, uv, dx, dy));
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
