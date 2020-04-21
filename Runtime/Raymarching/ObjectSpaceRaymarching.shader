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
Shader "Xmaho/Raymarching/ObjectSpaceRaymarching"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}

        [Header(Raymarching)]
        _Loop ("Loop", Range(1, 100)) = 30
        _MinDistance ("Minimum Distance", Range(0.001, 0.1)) = 0.01
        _DistanceMultiplier ("Distance Multiplier", Range(0.001, 2.0)) = 1.0

        [Header(Pass)]
        [Enum(UnityEngine.Rendering.CullMode)] _Cull("Culling", Int) = 2
        [Toggle][KeyEnum(Off, On)] _ZWrite("ZWrite", Int) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest", Int) = 4
    }

    SubShader
    {
        Tags {
            "Queue"="Geometry"
            "RenderType"="Opeque"
            "DisableBatching"="True"
        }
        LOD 100

        Pass
        {
            Cull [_Cull]
            ZWrite [_ZWrite]
            ZTest [_ZTest]

            CGPROGRAM
            #pragma target 5.0
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog
            #pragma multi_compile_instancing

            sampler2D _MainTex;
            float4 _MainTex_ST;
            int _Loop;
            float _MinDistance;
            float _DistanceMultiplier;

            #include "UnityCG.cginc"
            #include "../Library/math.cginc"
            #include "../Library/primitive.cginc"
            #include "../Library/ThirdParty/noise.cginc"
            #include "../Library/Template/object_space_raymarching_forward.cginc"

            // The MIT License
            // Copyright © 2013 Inigo Quilez
            // Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
            // Making noise
            float hash(float2 p)
            {
              p = 50.0 * frac(p * 0.3183099 + float2(0.71, 0.113));
              return -1.0 + 2.0 * frac(p.x * p.y * (p.x + p.y));
            }

            // Making ball status
            float4 metaballvalue(float i)
            {
                float kt = 3 * _Time.y * mad(i, 0.01, 0.1);
                float3 ballpos = 0.3 * float3(cnoise(float2(i, i) + kt),
                                              cnoise(float2(i + 10, i * 20) + kt),
                                              cnoise(float2(i * 20, i + 20) + kt));
                float scale = mad(hash(i.xx), 0.02, 0.05);
                return float4(ballpos, scale);
            }

            // Making ball distance function
            float metaballone(float3 p, float i)
            {
                float4 value = metaballvalue(i);
                float3 ballpos = p - value.xyz;
                float scale = value.w;
                return sphere(ballpos, scale);
            }

            //Making metaballs distance function
            float metaball(float3 p)
            {
                float d1 = metaballone(p, 0);
                for (int i = 1; i < 6; ++i) {
                    float d2 = metaballone(p, i);
                    d1 = smooth_min(d1, d2, 20);
                }
                return d1;
            }

            float distance_function(float3 position)
            {
                return metaball(to_local(position) * object_scale());
            }
            ENDCG
        }
    }
}
