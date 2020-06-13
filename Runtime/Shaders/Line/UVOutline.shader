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
Shader "Xmaho/Line/UVOutline" {
    Properties {
        [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull", Float) = 2
        [Header(Main Settings)]
        [HDR] _Color ("Color", Color) = (0, 0, 2, 1)
        _Width ("Witdh", Float) = 0.03
        [Toggle] _Scale ("Scale width?", Float) = 0
    }
    SubShader {
        Tags {
            "RenderType"="TransparentCutout"
            "Queue"="AlphaTest"
        }
        LOD 100

        Pass {
            Cull [_Cull]

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #pragma shader_feature_local __ _SCALE_ON

            #include "UnityCG.cginc"
            #include "Packages/link.xmaho.shader/Runtime/Library/utility.cginc"

            float3 object_scale_factor() {
#if defined(_SCALE_ON)
                return 1;
#else
                return object_scale();
#endif
            }

            struct v2f {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
            };

            UNITY_INSTANCING_BUFFER_START(Props)
                UNITY_DEFINE_INSTANCED_PROP(float3, _Color)
                UNITY_DEFINE_INSTANCED_PROP(float, _Width)
            UNITY_INSTANCING_BUFFER_END(Props)

            v2f vert(appdata_base v) {
                v2f o;

                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_OUTPUT(v2f, o);
                UNITY_TRANSFER_INSTANCE_ID(v, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                UNITY_TRANSFER_FOG(o, o.vertex);
                return o;
            }

            float4 frag(v2f i) : SV_Target{
                UNITY_SETUP_INSTANCE_ID(i);
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
                float2 uv_scaled_origin_center = object_scale_factor() * mad(2, i.uv, -1);
                float2 outline_distance_field = abs(abs(uv_scaled_origin_center) - object_scale_factor());
                float norm1_from_outline = min(outline_distance_field.x, outline_distance_field.y);
                clip(UNITY_ACCESS_INSTANCED_PROP(Props, _Width) - norm1_from_outline);
                float3 col = UNITY_ACCESS_INSTANCED_PROP(Props, _Color);
                UNITY_APPLY_FOG(i.fogCoord, col);
                return float4(col, 1);
            }
            ENDCG
        }
    }
}
