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
#ifndef XMAHO_RAYMARCHING
#define XMAHO_RAYMARCHING

#include "./camera.cginc"
#include "./utility.cginc"

/**
 * This need "float distance_function(float3 pos)" function.
 * Or define DISTANCE_FUNCTION for your distance function name
 */
#ifndef DISTANCE_FUNCTION
float distance_function(float3 pos);
#define DISTANCE_FUNCTION distance_function
#endif

struct raymarching_out
{
  float3 position;
  float3 normal;
  float depth;
};

struct raymarching_in
{
  float3 world_position;
  float4 projection_position;
  float threshold;
  int loop_count;
  float distance_multiplier;
  float3 world_normal;
};

bool is_inner_box(float3 position)
{
  return all(max(mad(0.5, object_scale(), -abs(to_local(position) * object_scale())), 0.0));
}

bool is_inner_sphere(float3 position)
{
  return length(to_local(position) * object_scale()) < length(object_scale()) * 0.28867513459; // PI
}

float3 raymarch_normal(float3 position)
{
  const float epsilon = 1e-4;
  const float2 k = float2(1, -1);
  return normalize(k.xyy * DISTANCE_FUNCTION(mad(k.xyy, epsilon, position)) +
                   k.yyx * DISTANCE_FUNCTION(mad(k.yyx, epsilon, position)) +
                   k.yxy * DISTANCE_FUNCTION(mad(k.yxy, epsilon, position)) +
                   k.xxx * DISTANCE_FUNCTION(mad(k.xxx, epsilon, position)));
}

raymarching_out raymarch(raymarching_in i)
{
    float3 to = i.world_position - camera_position();
    float3 ray_direction = normalize(to);
    float max_length = camera_far_clip();
    float3 near_clip_position = mad(distance_from_near_clip(i.projection_position), ray_direction, camera_position());
#if defined(_OBJECTCULLING_BOX)
    bool is_ray_inner = is_inner_box(near_clip_position);
#elif defined(_OBJECTCULLING_SPHERE)
    bool is_ray_inner = is_inner_sphere(near_clip_position);
#endif
    float3 local_ray_direction = normalize(mul(unity_WorldToObject, ray_direction));
    i.distance_multiplier *= length(mul(unity_ObjectToWorld, local_ray_direction));

    raymarching_out o;
    float init_length;
#if defined(_OBJECTCULLING_BOX) || defined(_OBJECTCULLING_SPHERE)
    if (is_ray_inner) {
        o.position = near_clip_position;
        o.normal = -ray_direction;
        init_length = camera_near_clip();
    } else {
#endif
        o.position = i.world_position;
        o.normal = i.world_normal;
        init_length = length(to);
#if defined(_OBJECTCULLING_BOX) || defined(_OBJECTCULLING_SPHERE)
    }
#endif
    float total_length = init_length;
    float last_distance;
    for (int n = i.loop_count; n; --n) {
        last_distance = DISTANCE_FUNCTION(o.position) * i.distance_multiplier;
        total_length += last_distance;
        o.position += ray_direction * last_distance;
        if (last_distance < i.threshold || total_length > max_length) break;
#if defined(_OBJECTCULLING_BOX)
        if (!is_inner_box(o.position)) break;
#elif defined(_OBJECTCULLING_SPHERE)
        if (!is_inner_sphere(o.position)) break;
#endif
    }

    if (last_distance > i.threshold || total_length > max_length) discard;
    if (total_length - init_length >= i.threshold) {
        o.normal = raymarch_normal(o.position);
    }
    o.depth = encode_depth(o.position);
    o.normal = normalize(o.normal);
    return o;
}

#endif