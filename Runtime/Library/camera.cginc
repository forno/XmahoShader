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
#ifndef XMAHO_CAMERA
#define XMAHO_CAMERA

float3 camera_position()
{
  return _WorldSpaceCameraPos;
}

float3 camera_forward()
{
  return -UNITY_MATRIX_V._m20_m21_m22;
}

float3 camera_up()
{
  return UNITY_MATRIX_V[1].xyz;
}

float3 camera_right()
{
  return UNITY_MATRIX_V[0].xyz;
}

float camera_focal_length()
{
  return abs(UNITY_MATRIX_P[1][1]);
}

float camera_visible_length()
{
  return _ProjectionParams.z - _ProjectionParams.y;
}

float camera_near_clip()
{
  return _ProjectionParams.y;
}

float camera_far_clip()
{
  return _ProjectionParams.z;
}

float3 camera_direction(float4 projection_position)
{
  projection_position.xy /= projection_position.w;
  projection_position.xy = mad(projection_position.xy, 2, -1);
  projection_position.x *= _ScreenParams.x / _ScreenParams.y;
  return normalize((camera_right() * projection_position.x) + (camera_up() * projection_position.y) + (camera_forward() * camera_focal_length()));
}

inline float distance_from_near_clip(float4 projection_position)
{
  projection_position.xy /= projection_position.w;
  projection_position.xy = mad(projection_position.xy, 2, -1);
  projection_position.x *= _ScreenParams.x / _ScreenParams.y;
  float3 dir = normalize(float3(projection_position.xy, camera_focal_length()));
  return camera_near_clip() / dir.z;
}

#endif
