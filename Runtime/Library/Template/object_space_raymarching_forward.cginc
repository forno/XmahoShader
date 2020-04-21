#ifndef XMAHO_TEMPLATE_OBJECT_SPACE_RAYMARCHING_FORWARD
#define XMAHO_TEMPLATE_OBJECT_SPACE_RAYMARCHING_FORWARD

#include "../raymarching.cginc"

struct v2f
{
    float4 vertex              : SV_POSITION;
    float4 projection_position : TEXCOORD0;
    float3 world_position      : TEXCOORD1;
    float3 world_normal        : TEXCOORD2;
    UNITY_FOG_COORDS(3)
    UNITY_VERTEX_INPUT_INSTANCE_ID
    UNITY_VERTEX_OUTPUT_STEREO
};

struct frag_out
{
    float4 color : SV_Target;
    float depth  : SV_Depth;
};

v2f vert(appdata_base v)
{
    v2f o;
    UNITY_SETUP_INSTANCE_ID(v);
    UNITY_INITIALIZE_OUTPUT(v2f, o);
    UNITY_TRANSFER_INSTANCE_ID(v, o);
    UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.vertex.z = 0.01;
    o.projection_position = ComputeNonStereoScreenPos(o.vertex);
    COMPUTE_EYEDEPTH(o.projection_position.z);
    o.world_position = mul(unity_ObjectToWorld, v.vertex).xyz;
    o.world_normal = UnityObjectToWorldNormal(v.normal);
    //UNITY_TRANSFER_FOG(o, o.vertex);
    return o;
}

frag_out frag(v2f i)
{
    UNITY_SETUP_INSTANCE_ID(i);
    UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);

    raymarching_in ray_input;
    ray_input.world_position = i.world_position;
    ray_input.world_normal = i.world_normal;
    ray_input.threshold = _MinDistance;
    ray_input.loop_count = _Loop;
    ray_input.distance_multiplier = _DistanceMultiplier;
    ray_input.projection_position = i.projection_position;
    raymarching_out ray_result = raymarch(ray_input);

    frag_out o;
    o.color.rgb = float3(1, 0, 0);
    // Directional right
    o.color.rgb *= max(dot(ray_result.normal, _WorldSpaceLightPos0.xyz), 0.0);
    o.color.a = 1;

#if defined(FOG_LINEAR) || defined(FOG_EXP) || defined(FOG_EXP2)
    {
        float4 pv_position = mul(UNITY_MATRIX_VP, float4(ray_result.position, 1.0));
        i.fogCoord = 1 - pv_position.z;
    }
#endif
    //UNITY_APPLY_FOG(i.fogCoord, o.color);

    o.depth = ray_result.depth;
    return o;
}

#endif