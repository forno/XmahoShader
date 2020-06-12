Shader "Xmaho/Color2Alpha"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        [KeywordEnum(Red, Green, Blue)] _Channel ("Color Channel", Float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
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
                return dot(col.rgb, float3(0.299, 0.587, 0.114));
#endif
            }

            #pragma vertex vert
            #pragma fragment frag
            #pragma shader_feature_local _CHANNEL_RED _CHANNEL_GREEN _CHANNEL_BLUE 

            #include "UnityCG.cginc"

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
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
