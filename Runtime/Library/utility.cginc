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
#ifndef XMAHO_UTILITY
#define XMAHO_UTILITY

float3 object_scale()
{
  return float3(
    length(float3(unity_ObjectToWorld[0].x, unity_ObjectToWorld[1].x, unity_ObjectToWorld[2].x)),
    length(float3(unity_ObjectToWorld[0].y, unity_ObjectToWorld[1].y, unity_ObjectToWorld[2].y)),
    length(float3(unity_ObjectToWorld[0].z, unity_ObjectToWorld[1].z, unity_ObjectToWorld[2].z)));
}

float encode_depth(float4 position)
{
  float z = position.z / position.w;
#if defined(SHADER_API_GLCORE) || \
    defined(SHADER_API_OPENGL) || \
    defined(SHADER_API_GLES) || \
    defined(SHADER_API_GLES3)
  return mad(0.5, z, 0.5);
#else 
  return z;
#endif 
}

float encode_depth(float3 position)
{
  float4 vp_position = mul(UNITY_MATRIX_VP, float4(position, 1.0));
  return encode_depth(vp_position);
}

float3 to_local(float3 position)
{
  return mul(unity_WorldToObject, float4(position, 1.0)).xyz;
}

#endif