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
#ifndef XMAHO_MATH
#define XMAHO_MATH

float mod(float x, float y)
{
  return frac(x / y) * abs(y);
}

float2 mod(float2 x, float2 y)
{
  return frac(x / y) * abs(y);
}

float3 mod(float3 x, float3 y)
{
  return frac(x / y) * abs(y);
}

float repeat(float pos, float span)
{
  return mad(-0.5, span, mod(pos, span));
}

float2 repeat(float2 pos, float2 span)
{
  return mad(-0.5, span, mod(pos, span));
}

float3 repeat(float3 pos, float3 span)
{
  return mad(-0.5, span, mod(pos, span));
}

float smooth_min(float d1, float d2, float k)
{
  float h = exp(-k * d1) + exp(-k * d2);
  return -log(h) / k;
}

#endif
