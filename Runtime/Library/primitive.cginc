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
#ifndef XMAHO_PRIMITIVE
#define XMAHO_PRIMITIVE


float sphere(float3 position, float radius)
{
    return length(position) - radius;
}

float round_box(float3 position, float3 size, float round)
{
    float3 d = abs(position) - size;
    return length(max(abs(position) - size, 0.0)) - round +
      min(max(d.x, max(d.y, d.z)), 0.0);
}

float box(float3 position, float3 size)
{
    float3 d = abs(position) - size;
    return length(max(abs(position) - size, 0.0)) +
      min(max(d.x, max(d.y, d.z)), 0.0);
}

float torus(float3 position, float2 radius)
{
    float2 r = float2(length(position.xy) - radius.x, position.z);
    return length(r) - radius.y;
}

float plane(float3 position, float3 dir)
{
    return dot(position, dir);
}

float cylinder(float3 position, float2 r)
{
    float2 d = abs(float2(length(position.xy), position.z)) - r;
    return min(max(d.x, d.y), 0.0) + length(max(d, 0.0)) - 0.1;
}

#endif