Shader "Xmaho/Color2Alpha"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        [KeywordEnum(Red, Green, Blue)] _Channel ("Color Channel", Float) = 0
        _NearLength ("Near Length", Range(0, 0.5)) = 0.01
    }
    SubShader
    {
        Tags {
            "RenderType"="Opaque"
            "Queue"="Transparent+100"
        }
        LOD 100

        Pass
        {
            Cull Off
            ZWrite On
            ZTest Always
            CGPROGRAM

            fixed getChannelColor(fixed4 col)
            {
#if defined(_CHANNEL_RED)
                return col.r;
#elif defined(_CHANNEL_GREEN)
                return col.g;
#elif defined(_CHANNEL_BLUE)
                return col.b;
#else
                return Luminance(col);
#endif
            }

            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #pragma shader_feature_local _CHANNEL_RED _CHANNEL_GREEN _CHANNEL_BLUE 

            #include "UnityCG.cginc"
            #include "Packages/link.xmaho.shader/Runtime/Library/utility.cginc"

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _NearLength;

            v2f vert (appdata_base v)
            {
                v2f o;

                UNITY_SETUP_INSTANCE_ID(v);
                o.vertex = lerp(UnityObjectToClipPos(v.vertex), 0, _NearLength < length(to_local(_WorldSpaceCameraPos)));
                o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                col.a = getChannelColor(col);
                return col;
            }
            ENDCG
        }
    }
}
