/*
Unity Companion License (“License”)
Software Copyright © 2019 Unity Technologies ApS

Unity Technologies ApS (“Unity”) grants to you a worldwide, non-exclusive, no-charge, and royalty-free copyright license to reproduce, prepare derivative works of, publicly display, publicly perform, sublicense, and distribute the software that is made available under this License (“Software”), subject to the following terms and conditions:

1. Unity Companion Use Only. Exercise of the license granted herein is limited to exercise for the creation, use, and/or distribution of applications, software, or other content pursuant to a valid Unity content authoring and rendering engine software license (“Engine License”). That means while use of the Software is not limited to use in the software licensed under the Engine License, the Software may not be used for any purpose other than the creation, use, and/or distribution of Engine License-dependent applications, software, or other content. No other exercise of the license granted herein is permitted, and in no event may the Software be used for competitive analysis or to develop a competing product or service.

2. No Modification of Engine License. Neither this License nor any exercise of the license granted herein modifies the Engine License in any way.

3. Ownership & Grant Back to You.

3.1 You own your content. In this License, “derivative works” means derivatives of the Software itself--works derived only from the Software by you under this License (for example, modifying the code of the Software itself to improve its efficacy); “derivative works” of the Software do not include, for example, games, apps, or content that you create using the Software. You keep all right, title, and interest to your own content.

3.2 Unity owns its content. While you keep all right, title, and interest to your own content per the above, as between Unity and you, Unity will own all right, title, and interest to all intellectual property rights (including patent, trademark, and copyright) in the Software and derivative works of the Software, and you hereby assign and agree to assign all such rights in those derivative works to Unity.

3.3 You have a license to those derivative works. Subject to this License, Unity grants to you the same worldwide, non-exclusive, no-charge, and royalty-free copyright license to derivative works of the Software you create as is granted to you for the Software under this License.

4. Trademarks. You are not granted any right or license under this License to use any trademarks, service marks, trade names, products names, or branding of Unity or its affiliates (“Trademarks”). Descriptive uses of Trademarks are permitted; see, for example, Unity’s Branding Usage Guidelines at https://unity3d.com/public-relations/brand.

5. Notices & Third-Party Rights. This License, including the copyright notice associated with the Software, must be provided in all substantial portions of the Software and derivative works thereof (or, if that is impracticable, in any other location where such notices are customarily placed). Further, if the Software is accompanied by a Unity “third-party notices” or similar file, you acknowledge and agree that software identified in that file is governed by those separate license terms.

6. DISCLAIMER, LIMITATION OF LIABILITY. THE SOFTWARE AND ANY DERIVATIVE WORKS THEREOF IS PROVIDED ON AN "AS IS" BASIS, AND IS PROVIDED WITHOUT WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING ANY WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND/OR NONINFRINGEMENT. IN NO EVENT SHALL ANY COPYRIGHT HOLDER OR AUTHOR BE LIABLE FOR ANY CLAIM, DAMAGES (WHETHER DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL, INCLUDING PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES, LOSS OF USE, DATA, OR PROFITS, AND BUSINESS INTERRUPTION), OR OTHER LIABILITY WHATSOEVER, WHETHER IN AN ACTION OF CONTRACT, TORT, OR OTHERWISE, ARISING FROM OR OUT OF, OR IN CONNECTION WITH, THE SOFTWARE OR ANY DERIVATIVE WORKS THEREOF OR THE USE OF OR OTHER DEALINGS IN SAME, EVEN WHERE ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

7. USE IS ACCEPTANCE and License Versions. Your receipt and use of the Software constitutes your acceptance of this License and its terms and conditions. Software released by Unity under this License may be modified or updated and the License with it; upon any such modification or update, you will comply with the terms of the updated License for any use of any of the Software under the updated License.

8. Use in Compliance with Law and Termination. Your exercise of the license granted herein will at all times be in compliance with applicable law and will not infringe any proprietary rights (including intellectual property rights); this License will terminate immediately on any breach by you of this License.

9. Severability. If any provision of this License is held to be unenforceable or invalid, that provision will be enforced to the maximum extent possible and the other provisions will remain in full force and effect.

10. Governing Law and Venue. This License is governed by and construed in accordance with the laws of Denmark, except for its conflict of laws rules; the United Nations Convention on Contracts for the International Sale of Goods will not apply. If you reside (or your principal place of business is) within the United States, you and Unity agree to submit to the personal and exclusive jurisdiction of and venue in the state and federal courts located in San Francisco County, California concerning any dispute arising out of this License (“Dispute”). If you reside (or your principal place of business is) outside the United States, you and Unity agree to submit to the personal and exclusive jurisdiction of and venue in the courts located in Copenhagen, Denmark concerning any Dispute.
*/
#ifndef XMAHO_THIRD_PARTY_NOISE
#define XMAHO_THIRD_PARTY_NOISE

// Modulo 289 without a division (only multiplications)
float  mod289(float x)
{
  return x - floor(x * (1.0f / 289.0f)) * 289.0f;
}
float2 mod289(float2 x)
{
  return x - floor(x * (1.0f / 289.0f)) * 289.0f;
}
float3 mod289(float3 x)
{
  return x - floor(x * (1.0f / 289.0f)) * 289.0f;
}
float4 mod289(float4 x)
{
  return x - floor(x * (1.0f / 289.0f)) * 289.0f;
}

// Modulo 7 without a division
float3 mod7(float3 x)
{
  return x - floor(x * (1.0f / 7.0f)) * 7.0f;
}
float4 mod7(float4 x)
{
  return x - floor(x * (1.0f / 7.0f)) * 7.0f;
}

// Permutation polynomial: (34x^2 + x) math.mod 289
float  permute(float x)
{
  return mod289(mad(34.0f, x, 1.0f) * x);
}
float3 permute(float3 x)
{
  return mod289(mad(34.0f, x, 1.0f) * x);
}
float4 permute(float4 x)
{
  return mod289(mad(34.0f, x, 1.0f) * x);
}

float  taylorInvSqrt(float r)
{
  return mad(-0.85373472095314f, r, 1.79284291400159f);
}
float4 taylorInvSqrt(float4 r)
{
  return mad(-0.85373472095314f, r, 1.79284291400159f);
}

float2 fade(float2 t)
{
  return t * t * t * mad(t, mad(6.0f, t, -15.0f), 10.0f);
}
float3 fade(float3 t)
{
  return t * t * t * mad(t, mad(6.0f, t, -15.0f), 10.0f);
}
float4 fade(float4 t)
{
  return t * t * t * mad(t, mad(6.0f, t, -15.0f), 10.0f);
}

float4 grad4(float j, float4 ip)
{
  float4 ones = float4(1.0f, 1.0f, 1.0f, -1.0f);
  float3 pxyz = floor(frac(float3(j,j,j)*ip.xyz) * 7.0f) * ip.z - 1.0f;
  float  pw = 1.5f - dot(abs(pxyz), ones.xyz);
  float4 p = float4(pxyz, pw);
  float4 s = float4(p < 0.0f);
  p.xyz = mad(s.www, s.xyz * 2.0f - 1.0f, p.xyz);
  return p;
}

/**
 * Hashed 2-D gradients with an extra rotation.
 * (The constant 0.0243902439 is 1/41)
 */
float2 rgrad2(float2 p, float rot)
{
  // For more isotropic gradients, math.sin/math.cos can be used instead.
  float u = mad(0.0243902439f, permute(permute(p.x) + p.y), rot); // Rotate by shift
  u = frac(u) * 6.28318530718f; // 2*pi
  return float2(cos(u), sin(u));
}

// Cellular noise ("Worley noise") in 2D in GLSL.
// Copyright (c) Stefan Gustavson 2011-04-19. All rights reserved.
// This code is released under the conditions of the MIT license.
// See LICENSE file for details.
// https://github.com/stegu/webgl-noiseo
/**
 * Cellular noise, returning F1 and F2 in a float2.
 * Standard 3x3 search window for good F1 and F2 values
 */
float2 cellular(float2 P)
{
  const float K = 0.142857142857f; // 1/7
  const float Ko = 0.428571428571f; // 3/7
  const float jitter = 1.0f; // Less gives more regular pattern

  float2 Pi;
  float2 Pf = modf(P, Pi);
  Pi = mod289(Pi);
  const float3 oi = float3(-1.0f, 0.0f, 1.0f);
  const float3 of = float3(-0.5f, 0.5f, 1.5f);
  float3 px = permute(Pi.x + oi);
  float3 p = permute(px.x + Pi.y + oi); // p11, p12, p13
  float3 oy;
  float3 ox = modf(p * K, oy) - Ko;
  oy = mod7(oy) * K - Ko;
  float3 dx = Pf.x + 0.5f + jitter * ox;
  float3 dy = Pf.y - of + jitter * oy;
  float3 d1 = dx * dx + dy * dy; // d11, d12 and d13, squared
  p = permute(px.y + Pi.y + oi); // p21, p22, p23
  oy = mod7(modf(p * K, ox)) * K - Ko;
  ox -= Ko;
  dx = Pf.x - 0.5f + jitter * ox;
  dy = Pf.y - of + jitter * oy;
  float3 d2 = dx * dx + dy * dy; // d21, d22 and d23, squared
  p = permute(px.z + Pi.y + oi); // p31, p32, p33
  ox = modf(p * K, oy) - Ko;
  oy = mod7(oy) * K - Ko;
  dx = Pf.x - 1.5f + jitter * ox;
  dy = Pf.y - of + jitter * oy;
  float3 d3 = dx * dx + dy * dy; // d31, d32 and d33, squared
  // Sort out the two smallest distances (F1, F2)
  float3 d1a = min(d1, d2);
  d2 = max(d1, d2); // Swap to keep candidates for F2
  d2 = min(d2, d3); // neither F1 nor F2 are now in d3
  d1 = min(d1a, d2); // F1 is now in d1
  d2 = max(d1a, d2); // Swap to keep candidates for F2
  d1.xy = (d1.x < d1.y) ? d1.xy : d1.yx; // Swap if smaller
  d1.xz = (d1.x < d1.z) ? d1.xz : d1.zx; // F1 is in d1.x
  d1.yz = min(d1.yz, d2.yz); // F2 is now not in d2.yz
  d1.y = min(d1.y, d1.z); // nor in  d1.z
  d1.y = min(d1.y, d2.x); // F2 is in d1.y, we're done.
  return sqrt(d1.xy);
}

// Cellular noise ("Worley noise") in 2D in GLSL.
// Copyright (c) Stefan Gustavson 2011-04-19. All rights reserved.
// This code is released under the conditions of the MIT license.
// See LICENSE file for details.
// https://github.com/stegu/webgl-noise
/**
 * Cellular noise, returning F1 and F2 in a float2.
 * Speeded up by umath.sing 2x2 search window instead of 3x3,
 * at the expense of some strong pattern artifacts.
 * F2 is often wrong and has sharp discontinuities.
 * If you need a smooth F2, use the slower 3x3 version.
 * F1 is sometimes wrong, too, but OK for most purposes.
 */
float2 cellular2x2(float2 P)
{
  const float K = 0.142857142857f; // 1/7
  const float K2 = 0.0714285714285f; // K/2
  const float jitter = 0.8f; // jitter 1.0 makes F1 wrong more often

  float2 Pi;
  float2 Pf = modf(P, Pi);
  Pi = mod289(Pi);
  float4 Pfx = Pf.x + float4(-0.5f, -1.5f, -0.5f, -1.5f);
  float4 Pfy = Pf.y + float4(-0.5f, -0.5f, -1.5f, -1.5f);
  float4 p = permute(Pi.x + float4(0.0f, 1.0f, 0.0f, 1.0f));
  p = permute(p + Pi.y + float4(0.0f, 0.0f, 1.0f, 1.0f));
  float4 ox = mad(K, mod7(p), K2);
  float4 oy = mad(K, mod7(floor(p * K)), K2);
  float4 dx = mad(jitter, ox, Pfx);
  float4 dy = mad(jitter, oy, Pfy);
  float4 d = dx * dx + dy * dy; // d11, d12, d21 and d22, squared
  // Sort out the two smallest distances
  // Do it right and find both F1 and F2
  d.xy = (d.x < d.y) ? d.xy : d.yx; // Swap if smaller
  d.xz = (d.x < d.z) ? d.xz : d.zx;
  d.xw = (d.x < d.w) ? d.xw : d.wx;
  d.y = min(d.y, d.z);
  d.y = min(d.y, d.w);
  return sqrt(d.xy);
}

// Cellular noise ("Worley noise") in 2D in GLSL.
// Copyright (c) Stefan Gustavson 2011-04-19. All rights reserved.
// This code is released under the conditions of the MIT license.
// See LICENSE file for details.
// https://github.com/stegu/webgl-noise
/**
 * Cellular noise, returning F1 and F2 in a float2.
 * Speeded up by umath.sing 2x2x2 search window instead of 3x3x3,
 * at the expense of some pattern artifacts.
 * F2 is often wrong and has sharp discontinuities.
 * If you need a good F2, use the slower 3x3x3 version.
 */
float2 cellular2x2x2(float3 P)
{
  const float K = 0.142857142857f; // 1/7
  const float Ko = 0.428571428571f; // 1/2-K/2
  const float K2 = 0.020408163265306f; // 1/(7*7)
  const float Kz = 0.166666666667f; // 1/6
  const float Kzo = 0.416666666667f; // 1/2-1/6*2
  const float jitter = 0.8f; // smaller jitter gives less errors in F2

  float3 Pi;
  float3 Pf = modf(P, Pi);
  Pi = mod289(Pi);
  float4 Pfx = Pf.x + float4(0.0f, -1.0f, 0.0f, -1.0f);
  float4 Pfy = Pf.y + float4(0.0f, 0.0f, -1.0f, -1.0f);
  float4 p = permute(Pi.x + float4(0.0f, 1.0f, 0.0f, 1.0f));
  p = permute(p + Pi.y + float4(0.0f, 0.0f, 1.0f, 1.0f));
  float4 p1 = permute(p + Pi.z); // z+0
  float4 p2 = permute(p + Pi.z + float4(1.0f, 1.0f, 1.0f, 1.0f)); // z+1
  float4 oy1;
  float4 ox1 = modf(p1 * K, oy1) - Ko;
  oy1 = mod7(oy1) * K - Ko;
  float4 oz1 = floor(p1 * K2) * Kz - Kzo; // p1 < 289 guaranteed
  float4 oy2;
  float4 ox2 = modf(p2 * K, oy2) - Ko;
  oy2 = mod7(oy2) * K - Ko;
  float4 oz2 = floor(p2 * K2) * Kz - Kzo;
  float4 dx1 = mad(jitter, ox1,  Pfx);
  float4 dy1 = mad(jitter, oy1,  Pfy);
  float4 dz1 = mad(jitter, oz1, Pf.z);
  float4 dx2 = mad(jitter, ox2,  Pfx);
  float4 dy2 = mad(jitter, oy2,  Pfy);
  float4 dz2 = mad(jitter, oz2, Pf.z - 1.0f);
  float4 d1 = dx1 * dx1 + dy1 * dy1 + dz1 * dz1; // z+0
  float4 d2 = dx2 * dx2 + dy2 * dy2 + dz2 * dz2; // z+1

  // Sort out the two smallest distances (F1, F2)

  // Do it right and sort out both F1 and F2
  float4 d = min(d1, d2); // F1 is now in d
  d2 = max(d1, d2); // Make sure we keep all candidates for F2
  d.xy = (d.x < d.y) ? d.xy : d.yx; // Swap smallest to d.x
  d.xz = (d.x < d.z) ? d.xz : d.zx;
  d.xw = (d.x < d.w) ? d.xw : d.wx; // F1 is now in d.x
  d.yzw = min(d.yzw, d2.yzw); // F2 now not in d2.yzw
  d.y = min(d.y, d.z); // nor in d.z
  d.y = min(d.y, d.w); // nor in d.w
  d.y = min(d.y, d2.x); // F2 is now in d.y
  return sqrt(d.xy); // F1 and F2
}

// Cellular noise ("Worley noise") in 3D in GLSL.
// Copyright (c) Stefan Gustavson 2011-04-19. All rights reserved.
// This code is released under the conditions of the MIT license.
// See LICENSE file for details.
// https://github.com/stegu/webgl-noise
/**
 * Cellular noise, returning F1 and F2 in a float2.
 * 3x3x3 search region for good F2 everywhere, but a lot
 * slower than the 2x2x2 version.
 * The code below is a bit scary even to its author,
 * but it has at least half decent performance on a
 * math.modern GPU. In any case, it beats any software
 * implementation of Worley noise hands down.
 */
float2 cellular(float3 P)
{
  const float K = 0.142857142857f; // 1/7
  const float Ko = 0.428571428571f; // 1/2-K/2
  const float K2 = 0.020408163265306f; // 1/(7*7)
  const float Kz = 0.166666666667f; // 1/6
  const float Kzo = 0.416666666667f; // 1/2-1/6*2
  const float jitter = 1.0f; // smaller jitter gives more regular pattern

  float3 Pi;
  float3 Pf = modf(P, Pi) - 0.5f;
  Pi = mod289(Pi);

  float3 Pfx = Pf.x + float3(1.0f, 0.0f, -1.0f);
  float3 Pfy = Pf.y + float3(1.0f, 0.0f, -1.0f);
  float3 Pfz = Pf.z + float3(1.0f, 0.0f, -1.0f);

  float3 p = permute(Pi.x + float3(-1.0f, 0.0f, 1.0f));
  float3 p1 = permute(p + Pi.y - 1.0f);
  float3 p2 = permute(p + Pi.y);
  float3 p3 = permute(p + Pi.y + 1.0f);

  float3 p11 = permute(p1 + Pi.z - 1.0f);
  float3 p12 = permute(p1 + Pi.z);
  float3 p13 = permute(p1 + Pi.z + 1.0f);

  float3 p21 = permute(p2 + Pi.z - 1.0f);
  float3 p22 = permute(p2 + Pi.z);
  float3 p23 = permute(p2 + Pi.z + 1.0f);

  float3 p31 = permute(p3 + Pi.z - 1.0f);
  float3 p32 = permute(p3 + Pi.z);
  float3 p33 = permute(p3 + Pi.z + 1.0f);

  float3 oy11;
  float3 ox11 = modf(p11 * K, oy11) - Ko;
  oy11 = mod7(oy11) * K - Ko;
  float3 oz11 = floor(p11 * K2) * Kz - Kzo; // p11 < 289 guaranteed

  float3 oy12;
  float3 ox12 = modf(p12 * K, oy12) - Ko;
  oy12 = mod7(oy12) * K - Ko;
  float3 oz12 = floor(p12 * K2) * Kz - Kzo;

  float3 oy13;
  float3 ox13 = modf(p13 * K, oy13) - Ko;
  oy13 = mod7(oy13) * K - Ko;
  float3 oz13 = floor(p13 * K2) * Kz - Kzo;

  float3 oy21;
  float3 ox21 = modf(p21 * K, oy21) - Ko;
  oy21 = mod7(oy21) * K - Ko;
  float3 oz21 = floor(p21 * K2) * Kz - Kzo;

  float3 oy22;
  float3 ox22 = modf(p22 * K, oy22) - Ko;
  oy22 = mod7(oy22) * K - Ko;
  float3 oz22 = floor(p22 * K2) * Kz - Kzo;

  float3 oy23;
  float3 ox23 = modf(p23 * K, oy23) - Ko;
  oy23 = mod7(oy23) * K - Ko;
  float3 oz23 = floor(p23 * K2) * Kz - Kzo;

  float3 oy31;
  float3 ox31 = modf(p31 * K, oy31) - Ko;
  oy31 = mod7(oy31) * K - Ko;
  float3 oz31 = floor(p31 * K2) * Kz - Kzo;

  float3 oy32;
  float3 ox32 = modf(p32 * K, oy32) - Ko;
  oy32 = mod7(oy32) * K - Ko;
  float3 oz32 = floor(p32 * K2) * Kz - Kzo;

  float3 oy33;
  float3 ox33 = modf(p33 * K, oy33) - Ko;
  oy33 = mod7(oy33) * K - Ko;
  float3 oz33 = floor(p33 * K2) * Kz - Kzo;

  float3 dx11 = mad(jitter, ox11, Pfx);
  float3 dy11 = mad(jitter, oy11, Pfy.x);
  float3 dz11 = mad(jitter, oz11, Pfz.x);

  float3 dx12 = mad(jitter, ox12, Pfx);
  float3 dy12 = mad(jitter, oy12, Pfy.x);
  float3 dz12 = mad(jitter, oz12, Pfz.y);

  float3 dx13 = mad(jitter, ox13, Pfx);
  float3 dy13 = mad(jitter, oy13, Pfy.x);
  float3 dz13 = mad(jitter, oz13, Pfz.z);

  float3 dx21 = mad(jitter, ox21, Pfx);
  float3 dy21 = mad(jitter, oy21, Pfy.y);
  float3 dz21 = mad(jitter, oz21, Pfz.x);

  float3 dx22 = mad(jitter, ox22, Pfx);
  float3 dy22 = mad(jitter, oy22, Pfy.y);
  float3 dz22 = mad(jitter, oz22, Pfz.y);

  float3 dx23 = mad(jitter, ox23, Pfx);
  float3 dy23 = mad(jitter, oy23, Pfy.y);
  float3 dz23 = mad(jitter, oz23, Pfz.z);

  float3 dx31 = mad(jitter, ox31, Pfx);
  float3 dy31 = mad(jitter, oy31, Pfy.z);
  float3 dz31 = mad(jitter, oz31, Pfz.x);

  float3 dx32 = mad(jitter, ox32, Pfx);
  float3 dy32 = mad(jitter, oy32, Pfy.z);
  float3 dz32 = mad(jitter, oz32, Pfz.y);

  float3 dx33 = mad(jitter, ox33, Pfx);
  float3 dy33 = mad(jitter, oy33, Pfy.z);
  float3 dz33 = mad(jitter, oz33, Pfz.z);

  float3 d11 = dx11 * dx11 + dy11 * dy11 + dz11 * dz11;
  float3 d12 = dx12 * dx12 + dy12 * dy12 + dz12 * dz12;
  float3 d13 = dx13 * dx13 + dy13 * dy13 + dz13 * dz13;
  float3 d21 = dx21 * dx21 + dy21 * dy21 + dz21 * dz21;
  float3 d22 = dx22 * dx22 + dy22 * dy22 + dz22 * dz22;
  float3 d23 = dx23 * dx23 + dy23 * dy23 + dz23 * dz23;
  float3 d31 = dx31 * dx31 + dy31 * dy31 + dz31 * dz31;
  float3 d32 = dx32 * dx32 + dy32 * dy32 + dz32 * dz32;
  float3 d33 = dx33 * dx33 + dy33 * dy33 + dz33 * dz33;

  // Sort out the two smallest distances (F1, F2)
  // Do it right and sort out both F1 and F2
  float3 d1a = min(d11, d12);
  d12 = max(d11, d12);
  d11 = min(d1a, d13); // Smallest now not in d12 or d13
  d13 = max(d1a, d13);
  d12 = min(d12, d13); // 2nd smallest now not in d13
  float3 d2a = min(d21, d22);
  d22 = max(d21, d22);
  d21 = min(d2a, d23); // Smallest now not in d22 or d23
  d23 = max(d2a, d23);
  d22 = min(d22, d23); // 2nd smallest now not in d23
  float3 d3a = min(d31, d32);
  d32 = max(d31, d32);
  d31 = min(d3a, d33); // Smallest now not in d32 or d33
  d33 = max(d3a, d33);
  d32 = min(d32, d33); // 2nd smallest now not in d33
  float3 da = min(d11, d21);
  d21 = max(d11, d21);
  d11 = min(da, d31); // Smallest now in d11
  d31 = max(da, d31); // 2nd smallest now not in d31
  d11.xy = (d11.x < d11.y) ? d11.xy : d11.yx;
  d11.xz = (d11.x < d11.z) ? d11.xz : d11.zx; // d11.x now smallest
  d12 = min(d12, d21); // 2nd smallest now not in d21
  d12 = min(d12, d22); // nor in d22
  d12 = min(d12, d31); // nor in d31
  d12 = min(d12, d32); // nor in d32
  d11.yz = min(d11.yz, d12.xy); // nor in d12.yz
  d11.y = min(d11.y, d12.z); // Only two more to go
  d11.y = min(d11.y, d11.z); // Done! (Phew!)
  return sqrt(d11.xy); // F1, F2
}

// GLSL textureless classic 2D noise "cnoise",
// with an RSL-style periodic variant "pnoise".
// Author:  Stefan Gustavson (stefan.gustavson@liu.se)
// Version: 2011-08-22
//
// Many thanks to Ian McEwan of Ashima Arts for the
// ideas for permutation and gradient selection.
//
// Copyright (c) 2011 Stefan Gustavson. All rights reserved.
// Distributed under the MIT license. See LICENSE file.
// https://github.com/stegu/webgl-noise
//! Classic Perlin noise
float cnoise(float2 P)
{
  float4 Pi;
  float4 Pf = modf(P.xyxy, Pi) - float4(0.0f, 0.0f, 1.0f, 1.0f);
  Pi += float4(0.0f, 0.0f, 1.0f, 1.0f);
  Pi = mod289(Pi); // To avoid truncation effects in permutation
  float4 ix = Pi.xzxz;
  float4 iy = Pi.yyww;
  float4 fx = Pf.xzxz;
  float4 fy = Pf.yyww;

  float4 i = permute(permute(ix) + iy);

  float4 gx = mad(2.0f, frac(i * (1.0f / 41.0f)), -1.0f);
  float4 gy = abs(gx) - 0.5f;
  float4 tx = floor(gx + 0.5f);
  gx = gx - tx;

  float2 g00 = float2(gx.x, gy.x);
  float2 g10 = float2(gx.y, gy.y);
  float2 g01 = float2(gx.z, gy.z);
  float2 g11 = float2(gx.w, gy.w);

  float4 norm = taylorInvSqrt(float4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11)));
  g00 *= norm.x;
  g01 *= norm.y;
  g10 *= norm.z;
  g11 *= norm.w;

  float n00 = dot(g00, float2(fx.x, fy.x));
  float n10 = dot(g10, float2(fx.y, fy.y));
  float n01 = dot(g01, float2(fx.z, fy.z));
  float n11 = dot(g11, float2(fx.w, fy.w));

  float2 fade_xy = fade(Pf.xy);
  float2 n_x = lerp(float2(n00, n01), float2(n10, n11), fade_xy.x);
  float n_xy = lerp(n_x.x, n_x.y, fade_xy.y);
  return 2.3f * n_xy;
}

//! Classic Perlin noise, periodic variant
float pnoise(float2 P, float2 rep)
{
  float4 Pi;
  float4 Pf = modf(P.xyxy, Pi) - float4(0.0f, 0.0f, 1.0f, 1.0f);
  Pi += float4(0.0f, 0.0f, 1.0f, 1.0f);
  Pi = fmod(Pi, rep.xyxy); // To create noise with explicit period
  Pi = mod289(Pi); // To avoid truncation effects in permutation
  float4 ix = Pi.xzxz;
  float4 iy = Pi.yyww;
  float4 fx = Pf.xzxz;
  float4 fy = Pf.yyww;

  float4 i = permute(permute(ix) + iy);

  float4 gx = mad(2.0f, frac(i * (1.0f / 41.0f)), -1.0f);
  float4 gy = abs(gx) - 0.5f;
  float4 tx = floor(gx + 0.5f);
  gx = gx - tx;

  float2 g00 = float2(gx.x, gy.x);
  float2 g10 = float2(gx.y, gy.y);
  float2 g01 = float2(gx.z, gy.z);
  float2 g11 = float2(gx.w, gy.w);

  float4 norm = taylorInvSqrt(float4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11)));
  g00 *= norm.x;
  g01 *= norm.y;
  g10 *= norm.z;
  g11 *= norm.w;

  float n00 = dot(g00, float2(fx.x, fy.x));
  float n10 = dot(g10, float2(fx.y, fy.y));
  float n01 = dot(g01, float2(fx.z, fy.z));
  float n11 = dot(g11, float2(fx.w, fy.w));

  float2 fade_xy = fade(Pf.xy);
  float2 n_x = lerp(float2(n00, n01), float2(n10, n11), fade_xy.x);
  float n_xy = lerp(n_x.x, n_x.y, fade_xy.y);
  return 2.3f * n_xy;
}

// GLSL textureless classic 3D noise "cnoise",
// with an RSL-style periodic variant "pnoise".
// Author:  Stefan Gustavson (stefan.gustavson@liu.se)
// Version: 2011-10-11
//
// Many thanks to Ian McEwan of Ashima Arts for the
// ideas for permutation and gradient selection.
//
// Copyright (c) 2011 Stefan Gustavson. All rights reserved.
// Distributed under the MIT license. See LICENSE file.
// https://github.com/stegu/webgl-noise
//! Classic Perlin noise
float cnoise(float3 P)
{
  float3 Pi0; // Integer part for indexing
  float3 Pf0 = modf(P, Pi0); // Fractional part for interpolation
  float3 Pi1 = Pi0 + 1.0f; // Integer part + 1
  Pi0 = mod289(Pi0);
  Pi1 = mod289(Pi1);
  float3 Pf1 = Pf0 - 1.0f; // Fractional part - 1.0
  float4 ix = float4(Pi0.x, Pi1.x, Pi0.x, Pi1.x);
  float4 iy = float4(Pi0.yy, Pi1.yy);
  float4 iz0 = Pi0.zzzz;
  float4 iz1 = Pi1.zzzz;

  float4 ixy = permute(permute(ix) + iy);
  float4 ixy0 = permute(ixy + iz0);
  float4 ixy1 = permute(ixy + iz1);

  float4 gx0 = ixy0 * (1.0f / 7.0f);
  float4 gy0 = frac(floor(gx0) * (1.0f / 7.0f)) - 0.5f;
  gx0 = frac(gx0);
  float4 gz0 = float4(0.5f, 0.5f, 0.5f, 0.5f) - abs(gx0) - abs(gy0);
  float4 sz0 = step(gz0, float4(0.0f, 0.0f, 0.0f, 0.0f));
  gx0 -= sz0 * (step(0.0f, gx0) - 0.5f);
  gy0 -= sz0 * (step(0.0f, gy0) - 0.5f);

  float4 gx1 = ixy1 * (1.0f / 7.0f);
  float4 gy1 = frac(floor(gx1) * (1.0f / 7.0f)) - 0.5f;
  gx1 = frac(gx1);
  float4 gz1 = float4(0.5f, 0.5f, 0.5f, 0.5f) - abs(gx1) - abs(gy1);
  float4 sz1 = step(gz1, float4(0.0f, 0.0f, 0.0f, 0.0f));
  gx1 -= sz1 * (step(0.0f, gx1) - 0.5f);
  gy1 -= sz1 * (step(0.0f, gy1) - 0.5f);

  float3 g000 = float3(gx0.x, gy0.x, gz0.x);
  float3 g100 = float3(gx0.y, gy0.y, gz0.y);
  float3 g010 = float3(gx0.z, gy0.z, gz0.z);
  float3 g110 = float3(gx0.w, gy0.w, gz0.w);
  float3 g001 = float3(gx1.x, gy1.x, gz1.x);
  float3 g101 = float3(gx1.y, gy1.y, gz1.y);
  float3 g011 = float3(gx1.z, gy1.z, gz1.z);
  float3 g111 = float3(gx1.w, gy1.w, gz1.w);

  float4 norm0 = taylorInvSqrt(float4(dot(g000, g000), dot(g010, g010), dot(g100, g100), dot(g110, g110)));
  g000 *= norm0.x;
  g010 *= norm0.y;
  g100 *= norm0.z;
  g110 *= norm0.w;
  float4 norm1 = taylorInvSqrt(float4(dot(g001, g001), dot(g011, g011), dot(g101, g101), dot(g111, g111)));
  g001 *= norm1.x;
  g011 *= norm1.y;
  g101 *= norm1.z;
  g111 *= norm1.w;

  float n000 = dot(g000, Pf0);
  float n100 = dot(g100, float3(Pf1.x, Pf0.yz));
  float n010 = dot(g010, float3(Pf0.x, Pf1.y, Pf0.z));
  float n110 = dot(g110, float3(Pf1.xy, Pf0.z));
  float n001 = dot(g001, float3(Pf0.xy, Pf1.z));
  float n101 = dot(g101, float3(Pf1.x, Pf0.y, Pf1.z));
  float n011 = dot(g011, float3(Pf0.x, Pf1.yz));
  float n111 = dot(g111, Pf1);

  float3 fade_xyz = fade(Pf0);
  float4 n_z = lerp(float4(n000, n100, n010, n110), float4(n001, n101, n011, n111), fade_xyz.z);
  float2 n_yz = lerp(n_z.xy, n_z.zw, fade_xyz.y);
  float n_xyz = lerp(n_yz.x, n_yz.y, fade_xyz.x);
  return 2.2f * n_xyz;
}

//! Classic Perlin noise, periodic variant
float pnoise(float3 P, float3 rep)
{
  float3 Pi0 = fmod(floor(P), rep); // Integer part, math.modulo period
  float3 Pi1 = fmod(Pi0 + 1.0f, rep); // Integer part + 1, math.mod period
  Pi0 = mod289(Pi0);
  Pi1 = mod289(Pi1);
  float3 Pf0 = frac(P); // Fractional part for interpolation
  float3 Pf1 = Pf0 - 1.0f; // Fractional part - 1.0
  float4 ix = float4(Pi0.x, Pi1.x, Pi0.x, Pi1.x);
  float4 iy = float4(Pi0.yy, Pi1.yy);
  float4 iz0 = Pi0.zzzz;
  float4 iz1 = Pi1.zzzz;

  float4 ixy = permute(permute(ix) + iy);
  float4 ixy0 = permute(ixy + iz0);
  float4 ixy1 = permute(ixy + iz1);

  float4 gx0 = ixy0 * (1.0f / 7.0f);
  float4 gy0 = frac(floor(gx0) * (1.0f / 7.0f)) - 0.5f;
  gx0 = frac(gx0);
  float4 gz0 = float4(0.5f, 0.5f, 0.5f, 0.5f) - abs(gx0) - abs(gy0);
  float4 sz0 = step(gz0, float4(0.0f, 0.0f, 0.0f, 0.0f));
  gx0 -= sz0 * (step(0.0f, gx0) - 0.5f);
  gy0 -= sz0 * (step(0.0f, gy0) - 0.5f);

  float4 gx1 = ixy1 * (1.0f / 7.0f);
  float4 gy1 = frac(floor(gx1) * (1.0f / 7.0f)) - 0.5f;
  gx1 = frac(gx1);
  float4 gz1 = float4(0.5f, 0.5f, 0.5f, 0.5f) - abs(gx1) - abs(gy1);
  float4 sz1 = step(gz1, float4(0.0f, 0.0f, 0.0f, 0.0f));
  gx1 -= sz1 * (step(0.0f, gx1) - 0.5f);
  gy1 -= sz1 * (step(0.0f, gy1) - 0.5f);

  float3 g000 = float3(gx0.x, gy0.x, gz0.x);
  float3 g100 = float3(gx0.y, gy0.y, gz0.y);
  float3 g010 = float3(gx0.z, gy0.z, gz0.z);
  float3 g110 = float3(gx0.w, gy0.w, gz0.w);
  float3 g001 = float3(gx1.x, gy1.x, gz1.x);
  float3 g101 = float3(gx1.y, gy1.y, gz1.y);
  float3 g011 = float3(gx1.z, gy1.z, gz1.z);
  float3 g111 = float3(gx1.w, gy1.w, gz1.w);

  float4 norm0 = taylorInvSqrt(float4(dot(g000, g000), dot(g010, g010), dot(g100, g100), dot(g110, g110)));
  g000 *= norm0.x;
  g010 *= norm0.y;
  g100 *= norm0.z;
  g110 *= norm0.w;
  float4 norm1 = taylorInvSqrt(float4(dot(g001, g001), dot(g011, g011), dot(g101, g101), dot(g111, g111)));
  g001 *= norm1.x;
  g011 *= norm1.y;
  g101 *= norm1.z;
  g111 *= norm1.w;

  float n000 = dot(g000, Pf0);
  float n100 = dot(g100, float3(Pf1.x, Pf0.yz));
  float n010 = dot(g010, float3(Pf0.x, Pf1.y, Pf0.z));
  float n110 = dot(g110, float3(Pf1.xy, Pf0.z));
  float n001 = dot(g001, float3(Pf0.xy, Pf1.z));
  float n101 = dot(g101, float3(Pf1.x, Pf0.y, Pf1.z));
  float n011 = dot(g011, float3(Pf0.x, Pf1.yz));
  float n111 = dot(g111, Pf1);

  float3 fade_xyz = fade(Pf0);
  float4 n_z = lerp(float4(n000, n100, n010, n110), float4(n001, n101, n011, n111), fade_xyz.z);
  float2 n_yz = lerp(n_z.xy, n_z.zw, fade_xyz.y);
  float n_xyz = lerp(n_yz.x, n_yz.y, fade_xyz.x);
  return 2.2f * n_xyz;
}

// GLSL textureless classic 4D noise "cnoise",
// with an RSL-style periodic variant "pnoise".
// Author:  Stefan Gustavson (stefan.gustavson@liu.se)
// Version: 2011-08-22
//
// Many thanks to Ian McEwan of Ashima Arts for the
// ideas for permutation and gradient selection.
//
// Copyright (c) 2011 Stefan Gustavson. All rights reserved.
// Distributed under the MIT license. See LICENSE file.
// https://github.com/stegu/webgl-noise
//! Classic Perlin noise
float cnoise(float4 P)
{
  float4 Pi0; // Integer part for indexing
  float4 Pf0 = modf(P, Pi0); // Fractional part for interpolation
  float4 Pi1 = Pi0 + 1.0f; // Integer part + 1
  Pi0 = mod289(Pi0);
  Pi1 = mod289(Pi1);
  float4 Pf1 = Pf0 - 1.0f; // Fractional part - 1.0
  float4 ix = float4(Pi0.x, Pi1.x, Pi0.x, Pi1.x);
  float4 iy = float4(Pi0.yy, Pi1.yy);
  float4 iz0 = float4(Pi0.zzzz);
  float4 iz1 = float4(Pi1.zzzz);
  float4 iw0 = float4(Pi0.wwww);
  float4 iw1 = float4(Pi1.wwww);

  float4 ixy = permute(permute(ix) + iy);
  float4 ixy0 = permute(ixy + iz0);
  float4 ixy1 = permute(ixy + iz1);
  float4 ixy00 = permute(ixy0 + iw0);
  float4 ixy01 = permute(ixy0 + iw1);
  float4 ixy10 = permute(ixy1 + iw0);
  float4 ixy11 = permute(ixy1 + iw1);

  float4 gx00 = ixy00 * (1.0f / 7.0f);
  float4 gy00 = floor(gx00) * (1.0f / 7.0f);
  float4 gz00 = floor(gy00) * (1.0f / 6.0f);
  gx00 = frac(gx00) - 0.5f;
  gy00 = frac(gy00) - 0.5f;
  gz00 = frac(gz00) - 0.5f;
  float4 gw00 = float4(0.75f, 0.75f, 0.75f, 0.75f) - abs(gx00) - abs(gy00) - abs(gz00);
  float4 sw00 = step(gw00, float4(0.0f, 0.0f, 0.0f, 0.0f));
  gx00 -= sw00 * (step(0.0f, gx00) - 0.5f);
  gy00 -= sw00 * (step(0.0f, gy00) - 0.5f);

  float4 gx01 = ixy01 * (1.0f / 7.0f);
  float4 gy01 = floor(gx01) * (1.0f / 7.0f);
  float4 gz01 = floor(gy01) * (1.0f / 6.0f);
  gx01 = frac(gx01) - 0.5f;
  gy01 = frac(gy01) - 0.5f;
  gz01 = frac(gz01) - 0.5f;
  float4 gw01 = float4(0.75f, 0.75f, 0.75f, 0.75f) - abs(gx01) - abs(gy01) - abs(gz01);
  float4 sw01 = step(gw01, float4(0.0f, 0.0f, 0.0f, 0.0f));
  gx01 -= sw01 * (step(0.0f, gx01) - 0.5f);
  gy01 -= sw01 * (step(0.0f, gy01) - 0.5f);

  float4 gx10 = ixy10 * (1.0f / 7.0f);
  float4 gy10 = floor(gx10) * (1.0f / 7.0f);
  float4 gz10 = floor(gy10) * (1.0f / 6.0f);
  gx10 = frac(gx10) - 0.5f;
  gy10 = frac(gy10) - 0.5f;
  gz10 = frac(gz10) - 0.5f;
  float4 gw10 = float4(0.75f, 0.75f, 0.75f, 0.75f) - abs(gx10) - abs(gy10) - abs(gz10);
  float4 sw10 = step(gw10, float4(0.0f, 0.0f, 0.0f, 0.0f));
  gx10 -= sw10 * (step(0.0f, gx10) - 0.5f);
  gy10 -= sw10 * (step(0.0f, gy10) - 0.5f);

  float4 gx11 = ixy11 * (1.0f / 7.0f);
  float4 gy11 = floor(gx11) * (1.0f / 7.0f);
  float4 gz11 = floor(gy11) * (1.0f / 6.0f);
  gx11 = frac(gx11) - 0.5f;
  gy11 = frac(gy11) - 0.5f;
  gz11 = frac(gz11) - 0.5f;
  float4 gw11 = float4(0.75f, 0.75f, 0.75f, 0.75f) - abs(gx11) - abs(gy11) - abs(gz11);
  float4 sw11 = step(gw11, float4(0.0f, 0.0f, 0.0f, 0.0f));
  gx11 -= sw11 * (step(0.0f, gx11) - 0.5f);
  gy11 -= sw11 * (step(0.0f, gy11) - 0.5f);

  float4 g0000 = float4(gx00.x, gy00.x, gz00.x, gw00.x);
  float4 g1000 = float4(gx00.y, gy00.y, gz00.y, gw00.y);
  float4 g0100 = float4(gx00.z, gy00.z, gz00.z, gw00.z);
  float4 g1100 = float4(gx00.w, gy00.w, gz00.w, gw00.w);
  float4 g0010 = float4(gx10.x, gy10.x, gz10.x, gw10.x);
  float4 g1010 = float4(gx10.y, gy10.y, gz10.y, gw10.y);
  float4 g0110 = float4(gx10.z, gy10.z, gz10.z, gw10.z);
  float4 g1110 = float4(gx10.w, gy10.w, gz10.w, gw10.w);
  float4 g0001 = float4(gx01.x, gy01.x, gz01.x, gw01.x);
  float4 g1001 = float4(gx01.y, gy01.y, gz01.y, gw01.y);
  float4 g0101 = float4(gx01.z, gy01.z, gz01.z, gw01.z);
  float4 g1101 = float4(gx01.w, gy01.w, gz01.w, gw01.w);
  float4 g0011 = float4(gx11.x, gy11.x, gz11.x, gw11.x);
  float4 g1011 = float4(gx11.y, gy11.y, gz11.y, gw11.y);
  float4 g0111 = float4(gx11.z, gy11.z, gz11.z, gw11.z);
  float4 g1111 = float4(gx11.w, gy11.w, gz11.w, gw11.w);

  float4 norm00 = taylorInvSqrt(float4(dot(g0000, g0000), dot(g0100, g0100), dot(g1000, g1000), dot(g1100, g1100)));
  g0000 *= norm00.x;
  g0100 *= norm00.y;
  g1000 *= norm00.z;
  g1100 *= norm00.w;

  float4 norm01 = taylorInvSqrt(float4(dot(g0001, g0001), dot(g0101, g0101), dot(g1001, g1001), dot(g1101, g1101)));
  g0001 *= norm01.x;
  g0101 *= norm01.y;
  g1001 *= norm01.z;
  g1101 *= norm01.w;

  float4 norm10 = taylorInvSqrt(float4(dot(g0010, g0010), dot(g0110, g0110), dot(g1010, g1010), dot(g1110, g1110)));
  g0010 *= norm10.x;
  g0110 *= norm10.y;
  g1010 *= norm10.z;
  g1110 *= norm10.w;

  float4 norm11 = taylorInvSqrt(float4(dot(g0011, g0011), dot(g0111, g0111), dot(g1011, g1011), dot(g1111, g1111)));
  g0011 *= norm11.x;
  g0111 *= norm11.y;
  g1011 *= norm11.z;
  g1111 *= norm11.w;

  float n0000 = dot(g0000, Pf0);
  float n1000 = dot(g1000, float4(Pf1.x, Pf0.yzw));
  float n0100 = dot(g0100, float4(Pf0.x, Pf1.y, Pf0.zw));
  float n1100 = dot(g1100, float4(Pf1.xy, Pf0.zw));
  float n0010 = dot(g0010, float4(Pf0.xy, Pf1.z, Pf0.w));
  float n1010 = dot(g1010, float4(Pf1.x, Pf0.y, Pf1.z, Pf0.w));
  float n0110 = dot(g0110, float4(Pf0.x, Pf1.yz, Pf0.w));
  float n1110 = dot(g1110, float4(Pf1.xyz, Pf0.w));
  float n0001 = dot(g0001, float4(Pf0.xyz, Pf1.w));
  float n1001 = dot(g1001, float4(Pf1.x, Pf0.yz, Pf1.w));
  float n0101 = dot(g0101, float4(Pf0.x, Pf1.y, Pf0.z, Pf1.w));
  float n1101 = dot(g1101, float4(Pf1.xy, Pf0.z, Pf1.w));
  float n0011 = dot(g0011, float4(Pf0.xy, Pf1.zw));
  float n1011 = dot(g1011, float4(Pf1.x, Pf0.y, Pf1.zw));
  float n0111 = dot(g0111, float4(Pf0.x, Pf1.yzw));
  float n1111 = dot(g1111, Pf1);

  float4 fade_xyzw = fade(Pf0);
  float4 n_0w = lerp(float4(n0000, n1000, n0100, n1100), float4(n0001, n1001, n0101, n1101), fade_xyzw.w);
  float4 n_1w = lerp(float4(n0010, n1010, n0110, n1110), float4(n0011, n1011, n0111, n1111), fade_xyzw.w);
  float4 n_zw = lerp(n_0w, n_1w, fade_xyzw.z);
  float2 n_yzw = lerp(n_zw.xy, n_zw.zw, fade_xyzw.y);
  float n_xyzw = lerp(n_yzw.x, n_yzw.y, fade_xyzw.x);
  return 2.2f * n_xyzw;
}

//! Classic Perlin noise, periodic version
float pnoise(float4 P, float4 rep)
{
  float4 Pi0; // Integer part math.modulo rep
  float4 Pf0 = modf(P, Pi0); // Fractional part for interpolation
  Pi0 = fmod(Pi0, rep);
  float4 Pi1 = fmod(Pi0 + 1.0f, rep); // Integer part + 1 math.mod rep
  Pi0 = mod289(Pi0);
  Pi1 = mod289(Pi1);
  float4 Pf1 = Pf0 - 1.0f; // Fractional part - 1.0
  float4 ix = float4(Pi0.x, Pi1.x, Pi0.x, Pi1.x);
  float4 iy = float4(Pi0.yy, Pi1.yy);
  float4 iz0 = float4(Pi0.zzzz);
  float4 iz1 = float4(Pi1.zzzz);
  float4 iw0 = float4(Pi0.wwww);
  float4 iw1 = float4(Pi1.wwww);

  float4 ixy = permute(permute(ix) + iy);
  float4 ixy0 = permute(ixy + iz0);
  float4 ixy1 = permute(ixy + iz1);
  float4 ixy00 = permute(ixy0 + iw0);
  float4 ixy01 = permute(ixy0 + iw1);
  float4 ixy10 = permute(ixy1 + iw0);
  float4 ixy11 = permute(ixy1 + iw1);

  float4 gx00 = ixy00 * (1.0f / 7.0f);
  float4 gy00 = floor(gx00) * (1.0f / 7.0f);
  float4 gz00 = floor(gy00) * (1.0f / 6.0f);
  gx00 = frac(gx00) - 0.5f;
  gy00 = frac(gy00) - 0.5f;
  gz00 = frac(gz00) - 0.5f;
  float4 gw00 = float4(0.75f, 0.75f, 0.75f, 0.75f) - abs(gx00) - abs(gy00) - abs(gz00);
  float4 sw00 = step(gw00, float4(0.0f, 0.0f, 0.0f, 0.0f));
  gx00 -= sw00 * (step(0.0f, gx00) - 0.5f);
  gy00 -= sw00 * (step(0.0f, gy00) - 0.5f);

  float4 gx01 = ixy01 * (1.0f / 7.0f);
  float4 gy01 = floor(gx01) * (1.0f / 7.0f);
  float4 gz01 = floor(gy01) * (1.0f / 6.0f);
  gx01 = frac(gx01) - 0.5f;
  gy01 = frac(gy01) - 0.5f;
  gz01 = frac(gz01) - 0.5f;
  float4 gw01 = float4(0.75f, 0.75f, 0.75f, 0.75f) - abs(gx01) - abs(gy01) - abs(gz01);
  float4 sw01 = step(gw01, float4(0.0f, 0.0f, 0.0f, 0.0f));
  gx01 -= sw01 * (step(0.0f, gx01) - 0.5f);
  gy01 -= sw01 * (step(0.0f, gy01) - 0.5f);

  float4 gx10 = ixy10 * (1.0f / 7.0f);
  float4 gy10 = floor(gx10) * (1.0f / 7.0f);
  float4 gz10 = floor(gy10) * (1.0f / 6.0f);
  gx10 = frac(gx10) - 0.5f;
  gy10 = frac(gy10) - 0.5f;
  gz10 = frac(gz10) - 0.5f;
  float4 gw10 = float4(0.75f, 0.75f, 0.75f, 0.75f) - abs(gx10) - abs(gy10) - abs(gz10);
  float4 sw10 = step(gw10, float4(0.0f, 0.0f, 0.0f, 0.0f));
  gx10 -= sw10 * (step(0.0f, gx10) - 0.5f);
  gy10 -= sw10 * (step(0.0f, gy10) - 0.5f);

  float4 gx11 = ixy11 * (1.0f / 7.0f);
  float4 gy11 = floor(gx11) * (1.0f / 7.0f);
  float4 gz11 = floor(gy11) * (1.0f / 6.0f);
  gx11 = frac(gx11) - 0.5f;
  gy11 = frac(gy11) - 0.5f;
  gz11 = frac(gz11) - 0.5f;
  float4 gw11 = float4(0.75f, 0.75f, 0.75f, 0.75f) - abs(gx11) - abs(gy11) - abs(gz11);
  float4 sw11 = step(gw11, float4(0.0f, 0.0f, 0.0f, 0.0f));
  gx11 -= sw11 * (step(0.0f, gx11) - 0.5f);
  gy11 -= sw11 * (step(0.0f, gy11) - 0.5f);

  float4 g0000 = float4(gx00.x, gy00.x, gz00.x, gw00.x);
  float4 g1000 = float4(gx00.y, gy00.y, gz00.y, gw00.y);
  float4 g0100 = float4(gx00.z, gy00.z, gz00.z, gw00.z);
  float4 g1100 = float4(gx00.w, gy00.w, gz00.w, gw00.w);
  float4 g0010 = float4(gx10.x, gy10.x, gz10.x, gw10.x);
  float4 g1010 = float4(gx10.y, gy10.y, gz10.y, gw10.y);
  float4 g0110 = float4(gx10.z, gy10.z, gz10.z, gw10.z);
  float4 g1110 = float4(gx10.w, gy10.w, gz10.w, gw10.w);
  float4 g0001 = float4(gx01.x, gy01.x, gz01.x, gw01.x);
  float4 g1001 = float4(gx01.y, gy01.y, gz01.y, gw01.y);
  float4 g0101 = float4(gx01.z, gy01.z, gz01.z, gw01.z);
  float4 g1101 = float4(gx01.w, gy01.w, gz01.w, gw01.w);
  float4 g0011 = float4(gx11.x, gy11.x, gz11.x, gw11.x);
  float4 g1011 = float4(gx11.y, gy11.y, gz11.y, gw11.y);
  float4 g0111 = float4(gx11.z, gy11.z, gz11.z, gw11.z);
  float4 g1111 = float4(gx11.w, gy11.w, gz11.w, gw11.w);

  float4 norm00 = taylorInvSqrt(float4(dot(g0000, g0000), dot(g0100, g0100), dot(g1000, g1000), dot(g1100, g1100)));
  g0000 *= norm00.x;
  g0100 *= norm00.y;
  g1000 *= norm00.z;
  g1100 *= norm00.w;

  float4 norm01 = taylorInvSqrt(float4(dot(g0001, g0001), dot(g0101, g0101), dot(g1001, g1001), dot(g1101, g1101)));
  g0001 *= norm01.x;
  g0101 *= norm01.y;
  g1001 *= norm01.z;
  g1101 *= norm01.w;

  float4 norm10 = taylorInvSqrt(float4(dot(g0010, g0010), dot(g0110, g0110), dot(g1010, g1010), dot(g1110, g1110)));
  g0010 *= norm10.x;
  g0110 *= norm10.y;
  g1010 *= norm10.z;
  g1110 *= norm10.w;

  float4 norm11 = taylorInvSqrt(float4(dot(g0011, g0011), dot(g0111, g0111), dot(g1011, g1011), dot(g1111, g1111)));
  g0011 *= norm11.x;
  g0111 *= norm11.y;
  g1011 *= norm11.z;
  g1111 *= norm11.w;

  float n0000 = dot(g0000, Pf0);
  float n1000 = dot(g1000, float4(Pf1.x, Pf0.yzw));
  float n0100 = dot(g0100, float4(Pf0.x, Pf1.y, Pf0.zw));
  float n1100 = dot(g1100, float4(Pf1.xy, Pf0.zw));
  float n0010 = dot(g0010, float4(Pf0.xy, Pf1.z, Pf0.w));
  float n1010 = dot(g1010, float4(Pf1.x, Pf0.y, Pf1.z, Pf0.w));
  float n0110 = dot(g0110, float4(Pf0.x, Pf1.yz, Pf0.w));
  float n1110 = dot(g1110, float4(Pf1.xyz, Pf0.w));
  float n0001 = dot(g0001, float4(Pf0.xyz, Pf1.w));
  float n1001 = dot(g1001, float4(Pf1.x, Pf0.yz, Pf1.w));
  float n0101 = dot(g0101, float4(Pf0.x, Pf1.y, Pf0.z, Pf1.w));
  float n1101 = dot(g1101, float4(Pf1.xy, Pf0.z, Pf1.w));
  float n0011 = dot(g0011, float4(Pf0.xy, Pf1.zw));
  float n1011 = dot(g1011, float4(Pf1.x, Pf0.y, Pf1.zw));
  float n0111 = dot(g0111, float4(Pf0.x, Pf1.yzw));
  float n1111 = dot(g1111, Pf1);

  float4 fade_xyzw = fade(Pf0);
  float4 n_0w = lerp(float4(n0000, n1000, n0100, n1100), float4(n0001, n1001, n0101, n1101), fade_xyzw.w);
  float4 n_1w = lerp(float4(n0010, n1010, n0110, n1110), float4(n0011, n1011, n0111, n1111), fade_xyzw.w);
  float4 n_zw = lerp(n_0w, n_1w, fade_xyzw.z);
  float2 n_yzw = lerp(n_zw.xy, n_zw.zw, fade_xyzw.y);
  float n_xyzw = lerp(n_yzw.x, n_yzw.y, fade_xyzw.x);
  return 2.2f * n_xyzw;
}

/**
 * Description : Array and textureless GLSL 2D simplex noise function.
 *      Author : Ian McEwan, Ashima Arts.
 *  Maintainer : stegu
 *     Lastmath.mod : 20110822 (ijm)
 *     License : Copyright (C) 2011 Ashima Arts. All rights reserved.
 *               Distributed under the MIT License. See LICENSE file.
 *               https://github.com/ashima/webgl-noise
 *               https://github.com/stegu/webgl-noise
 */
float snoise(float2 v)
{
  float4 C = float4(0.211324865405187f,  // (3.0-math.sqrt(3.0))/6.0
                    0.366025403784439f,  // 0.5*(math.sqrt(3.0)-1.0)
                    -0.577350269189626f,  // -1.0 + 2.0 * C.x
                    0.024390243902439f); // 1.0 / 41.0
  // First corner
  float2 i = floor(v + dot(v, C.yy));
  float2 x0 = v - i + dot(i, C.xx);

  // Other corners
  float2 i1;
  //i1.x = math.step( x0.y, x0.x ); // x0.x > x0.y ? 1.0 : 0.0
  //i1.y = 1.0 - i1.x;
  i1 = (x0.x > x0.y) ? float2(1.0f, 0.0f) : float2(0.0f, 1.0f);
  // x0 = x0 - 0.0 + 0.0 * C.xx ;
  // x1 = x0 - i1 + 1.0 * C.xx ;
  // x2 = x0 - 1.0 + 2.0 * C.xx ;
  float4 x12 = x0.xyxy + C.xxzz;
  x12.xy -= i1;

  // Permutations
  i = mod289(i); // Avoid truncation effects in permutation
  float3 p = permute(permute(i.y + float3(0.0f, i1.y, 1.0f)) + i.x + float3(0.0f, i1.x, 1.0f));

  float3 m = max(0.5f - float3(dot(x0, x0), dot(x12.xy, x12.xy), dot(x12.zw, x12.zw)), 0.0f);
  m = m * m;
  m = m * m;

  // Gradients: 41 points uniformly over a line, mapped onto a diamond.
  // The ring size 17*17 = 289 is close to a multiple of 41 (41*7 = 287)

  float3 x = mad(2.0f, frac(p * C.www), -1.0f);
  float3 h = abs(x) - 0.5f;
  float3 ox = floor(x + 0.5f);
  float3 a0 = x - ox;

  // Normalise gradients implicitly by scaling m
  // Approximation of: m *= inversemath.sqrt( a0*a0 + h*h );
  m *= mad(-0.85373472095314f, a0 * a0 + h * h, 1.79284291400159f);

  // Compute final noise value at P

  float  gx = a0.x * x0.x + h.x * x0.y;
  float2 gyz = a0.yz * x12.xz + h.yz * x12.yw;
  float3 g = float3(gx, gyz);

  return 130.0f * dot(m, g);
}

/**
 * Description : Array and textureless GLSL 2D/3D/4D simplex
 *               noise functions.
 *      Author : Ian McEwan, Ashima Arts.
 *  Maintainer : stegu
 *     Lastmath.mod : 20110822 (ijm)
 *     License : Copyright (C) 2011 Ashima Arts. All rights reserved.
 *               Distributed under the MIT License. See LICENSE file.
 *               https://github.com/ashima/webgl-noise
 *               https://github.com/stegu/webgl-noise
*/
float snoise(float3 v)
{
  float2 C = float2(1.0f / 6.0f, 1.0f / 3.0f);
  float4 D = float4(0.0f, 0.5f, 1.0f, 2.0f);

  // First corner
  float3 i = floor(v + dot(v, C.yyy));
  float3 x0 = v - i + dot(i, C.xxx);

  // Other corners
  float3 g = step(x0.yzx, x0.xyz);
  float3 l = 1.0f - g;
  float3 i1 = min(g.xyz, l.zxy);
  float3 i2 = max(g.xyz, l.zxy);

  //   x0 = x0 - 0.0 + 0.0 * C.xxx;
  //   x1 = x0 - i1  + 1.0 * C.xxx;
  //   x2 = x0 - i2  + 2.0 * C.xxx;
  //   x3 = x0 - 1.0 + 3.0 * C.xxx;
  float3 x1 = x0 - i1 + C.xxx;
  float3 x2 = x0 - i2 + C.yyy; // 2.0*C.x = 1/3 = C.y
  float3 x3 = x0 - D.yyy; // -1.0+3.0*C.x = -0.5 = -D.y

  // Permutations
  i = mod289(i);
  float4 p = permute(permute(permute(
    i.z + float4(0.0f, i1.z, i2.z, 1.0f)) +
    i.y + float4(0.0f, i1.y, i2.y, 1.0f)) +
    i.x + float4(0.0f, i1.x, i2.x, 1.0f));

  // Gradients: 7x7 points over a square, mapped onto an octahedron.
  // The ring size 17*17 = 289 is close to a multiple of 49 (49*6 = 294)
  float n_ = 0.142857142857f; // 1.0/7.0
  float3 ns = mad(n_, D.wyz, -D.xzx);

  float4 j = mad(-49.0f, floor(p * ns.z * ns.z), p); //  math.mod(p,7*7)

  float4 x_ = floor(j * ns.z);
  float4 y_ = floor(mad(-7.0f, x_, j)); // math.mod(j,N)

  float4 x = mad(x_, ns.x, ns.yyyy);
  float4 y = mad(y_, ns.x, ns.yyyy);
  float4 h = 1.0f - abs(x) - abs(y);

  float4 b0 = float4(x.xy, y.xy);
  float4 b1 = float4(x.zw, y.zw);

  //float4 s0 = float4(math.lessThan(b0,0.0))*2.0 - 1.0;
  //float4 s1 = float4(math.lessThan(b1,0.0))*2.0 - 1.0;
  float4 s0 = mad(2.0f, floor(b0), 1.0f);
  float4 s1 = mad(2.0f, floor(b1), 1.0f);
  float4 sh = -step(h, float4(0.0f, 0.0f, 0.0f, 0.0f));

  float4 a0 = mad(sh.xxyy, s0.xzyw, b0.xzyw);
  float4 a1 = mad(sh.zzww, s1.xzyw, b1.xzyw);

  float3 p0 = float3(a0.xy, h.x);
  float3 p1 = float3(a0.zw, h.y);
  float3 p2 = float3(a1.xy, h.z);
  float3 p3 = float3(a1.zw, h.w);

  //Normalise gradients
  float4 norm = taylorInvSqrt(float4(dot(p0, p0), dot(p1, p1), dot(p2, p2), dot(p3, p3)));
  p0 *= norm.x;
  p1 *= norm.y;
  p2 *= norm.z;
  p3 *= norm.w;

  // Mix final noise value
  float4 m = max(0.6f - float4(dot(x0, x0), dot(x1, x1), dot(x2, x2), dot(x3, x3)), 0.0f);
  m = m * m;
  return 42.0f * dot(m * m, float4(dot(p0, x0), dot(p1, x1), dot(p2, x2), dot(p3, x3)));
}

/**
 * Description : Array and textureless GLSL 2D/3D/4D simplex
 *               noise functions.
 *      Author : Ian McEwan, Ashima Arts.
 *  Maintainer : stegu
 *     Lastmath.mod : 20110822 (ijm)
 *     License : Copyright (C) 2011 Ashima Arts. All rights reserved.
 *               Distributed under the MIT License. See LICENSE file.
 *               https://github.com/ashima/webgl-noise
 *               https://github.com/stegu/webgl-noise
 */
float snoise(float3 v, out float3 gradient)
{
  const float2 C = float2(1.0f / 6.0f, 1.0f / 3.0f);
  const float4 D = float4(0.0f, 0.5f, 1.0f, 2.0f);

  // First corner
  float3 i = floor(v + dot(v, C.yyy));
  float3 x0 = v - i + dot(i, C.xxx);

  // Other corners
  float3 g = step(x0.yzx, x0.xyz);
  float3 l = 1.0f - g;
  float3 i1 = min(g.xyz, l.zxy);
  float3 i2 = max(g.xyz, l.zxy);

  //   x0 = x0 - 0.0 + 0.0 * C.xxx;
  //   x1 = x0 - i1  + 1.0 * C.xxx;
  //   x2 = x0 - i2  + 2.0 * C.xxx;
  //   x3 = x0 - 1.0 + 3.0 * C.xxx;
  float3 x1 = x0 - i1 + C.xxx;
  float3 x2 = x0 - i2 + C.yyy; // 2.0*C.x = 1/3 = C.y
  float3 x3 = x0 - D.yyy; // -1.0+3.0*C.x = -0.5 = -D.y

  // Permutations
  i = mod289(i);
  float4 p = permute(permute(permute(
    i.z + float4(0.0f, i1.z, i2.z, 1.0f)) +
    i.y + float4(0.0f, i1.y, i2.y, 1.0f)) +
    i.x + float4(0.0f, i1.x, i2.x, 1.0f));

  // Gradients: 7x7 points over a square, mapped onto an octahedron.
  // The ring size 17*17 = 289 is close to a multiple of 49 (49*6 = 294)
  float n_ = 0.142857142857f; // 1.0/7.0
  float3 ns = mad(n_, D.wyz, -D.xzx);

  float4 j = mad(-49.0f, floor(p * ns.z * ns.z), p); //  math.mod(p,7*7)

  float4 x_ = floor(j * ns.z);
  float4 y_ = floor(mad(-7.0f, x_, j)); // math.mod(j,N)

  float4 x = mad(x_, ns.x, ns.yyyy);
  float4 y = mad(y_, ns.x, ns.yyyy);
  float4 h = 1.0f - abs(x) - abs(y);

  float4 b0 = float4(x.xy, y.xy);
  float4 b1 = float4(x.zw, y.zw);

  //float4 s0 = float4(math.lessThan(b0,0.0))*2.0 - 1.0;
  //float4 s1 = float4(math.lessThan(b1,0.0))*2.0 - 1.0;
  float4 s0 = mad(2.0f, floor(b0), 1.0f);
  float4 s1 = mad(2.0f, floor(b1), 1.0f);
  float4 sh = -step(h, float4(0.0f, 0.0f, 0.0f, 0.0f));

  float4 a0 = mad(sh.xxyy, s0.xzyw, b0.xzyw);
  float4 a1 = mad(sh.zzww, s1.xzyw, b1.xzyw);

  float3 p0 = float3(a0.xy, h.x);
  float3 p1 = float3(a0.zw, h.y);
  float3 p2 = float3(a1.xy, h.z);
  float3 p3 = float3(a1.zw, h.w);

  //Normalise gradients
  float4 norm = taylorInvSqrt(float4(dot(p0, p0), dot(p1, p1), dot(p2, p2), dot(p3, p3)));
  p0 *= norm.x;
  p1 *= norm.y;
  p2 *= norm.z;
  p3 *= norm.w;

  // Mix final noise value
  float4 m = max(0.6f - float4(dot(x0, x0), dot(x1, x1), dot(x2, x2), dot(x3, x3)), 0.0f);
  float4 m2 = m * m;
  float4 m4 = m2 * m2;
  float4 pdotx = float4(dot(p0, x0), dot(p1, x1), dot(p2, x2), dot(p3, x3));

  // Determath.mine noise gradient
  float4 temp = m2 * m * pdotx;
  gradient = -8.0f * (temp.x * x0 + temp.y * x1 + temp.z * x2 + temp.w * x3);
  gradient += m4.x * p0 + m4.y * p1 + m4.z * p2 + m4.w * p3;
  gradient *= 42.0f;

  return 42.0f * dot(m4, pdotx);
}

/**
 * Description : Array and textureless GLSL 2D/3D/4D simplex
 *               noise functions.
 *      Author : Ian McEwan, Ashima Arts.
 *  Maintainer : stegu
 *     Lastmath.mod : 20110822 (ijm)
 *     License : Copyright (C) 2011 Ashima Arts. All rights reserved.
 *               Distributed under the MIT License. See LICENSE file.
 *               https://github.com/ashima/webgl-noise
 *               https://github.com/stegu/webgl-noise
 */
float snoise(float4 v)
{
  // (math.sqrt(5) - 1)/4 = F4, used once below
  const float F4 = 0.309016994374947451f;
  const float4 C = float4(0.138196601125011f,  // (5 - math.sqrt(5))/20  G4
                          0.276393202250021f,  // 2 * G4
                          0.414589803375032f,  // 3 * G4
                          -0.447213595499958f); // -1 + 4 * G4

                        // First corner
  float4 i = floor(v + dot(v, float4(F4, F4, F4, F4)));
  float4 x0 = v - i + dot(i, C.xxxx);

  // Other corners

  // Rank sorting originally contributed by Bill Licea-Kane, AMD (formerly ATI)
  float4 i0 = float4(0.0f, 0.0f, 0.0f, 0.0f);
  float3 isX = step(x0.yzw, x0.xxx);
  float3 isYZ = step(x0.zww, x0.yyz);
  //  i0.x = math.dot( isX, float3( 1.0 ) );
  i0.x = isX.x + isX.y + isX.z;
  i0.yzw = 1.0f - isX;
  //  i0.y += math.dot( isYZ.xy, float2( 1.0 ) );
  i0.y += isYZ.x + isYZ.y;
  i0.zw += 1.0f - isYZ.xy;
  i0.z += isYZ.z;
  i0.w += 1.0f - isYZ.z;

  // i0 now contains the unique values 0,1,2,3 in each channel
  float4 i3 = clamp(i0, 0.0f, 1.0f);
  float4 i2 = clamp(i0 - 1.0f, 0.0f, 1.0f);
  float4 i1 = clamp(i0 - 2.0f, 0.0f, 1.0f);

  //  x0 = x0 - 0.0 + 0.0 * C.xxxx
  //  x1 = x0 - i1  + 1.0 * C.xxxx
  //  x2 = x0 - i2  + 2.0 * C.xxxx
  //  x3 = x0 - i3  + 3.0 * C.xxxx
  //  x4 = x0 - 1.0 + 4.0 * C.xxxx
  float4 x1 = x0 - i1 + C.xxxx;
  float4 x2 = x0 - i2 + C.yyyy;
  float4 x3 = x0 - i3 + C.zzzz;
  float4 x4 = x0 + C.wwww;

  // Permutations
  i = mod289(i);
  float j0 = permute(permute(permute(permute(i.w) + i.z) + i.y) + i.x);
  float4 j1 = permute(permute(permute(permute(
    i.w + float4(i1.w, i2.w, i3.w, 1.0f)) +
    i.z + float4(i1.z, i2.z, i3.z, 1.0f)) +
    i.y + float4(i1.y, i2.y, i3.y, 1.0f)) +
    i.x + float4(i1.x, i2.x, i3.x, 1.0f));

  // Gradients: 7x7x6 points over a cube, mapped onto a 4-cross polytope
  // 7*7*6 = 294, which is close to the ring size 17*17 = 289.
  const float4 ip = float4(1.0f / 294.0f, 1.0f / 49.0f, 1.0f / 7.0f, 0.0f);

  float4 p0 = grad4(j0, ip);
  float4 p1 = grad4(j1.x, ip);
  float4 p2 = grad4(j1.y, ip);
  float4 p3 = grad4(j1.z, ip);
  float4 p4 = grad4(j1.w, ip);

  // Normalise gradients
  float4 norm = taylorInvSqrt(float4(dot(p0, p0), dot(p1, p1), dot(p2, p2), dot(p3, p3)));
  p0 *= norm.x;
  p1 *= norm.y;
  p2 *= norm.z;
  p3 *= norm.w;
  p4 *= taylorInvSqrt(dot(p4, p4));

  // Mix contributions from the five corners
  float3 m0 = max(0.6f - float3(dot(x0, x0), dot(x1, x1), dot(x2, x2)), 0.0f);
  float2 m1 = max(0.6f - float2(dot(x3, x3), dot(x4, x4)), 0.0f);
  m0 = m0 * m0;
  m1 = m1 * m1;
  return 49.0f * (dot(m0 * m0, float3(dot(p0, x0), dot(p1, x1), dot(p2, x2))) +
                  dot(m1 * m1, float2(dot(p3, x3), dot(p4, x4))));
}

// float3  psrdnoise(float2 pos, float2 per, float rot)
// float3  psrdnoise(float2 pos, float2 per)
// float psrnoise(float2 pos, float2 per, float rot)
// float psrnoise(float2 pos, float2 per)
// float3  srdnoise(float2 pos, float rot)
// float3  srdnoise(float2 pos)
// float srnoise(float2 pos, float rot)
// float srnoise(float2 pos)
//
// Periodic (tiling) 2-D simplex noise (hexagonal lattice gradient noise)
// with rotating gradients and analytic derivatives.
// Variants also without the derivative (no "d" in the name), without
// the tiling property (no "p" in the name) and without the rotating
// gradients (no "r" in the name).
//
// This is (yet) another variation on simplex noise. It's similar to the
// version presented by Ken Perlin, but the grid is axis-aligned and
// slightly stretched in the y direction to permit rectangular tiling.
//
// The noise can be made to tile seamlessly to any integer period in x and
// any even integer period in y. Odd periods may be specified for y, but
// then the actual tiling period will be twice that number.
//
// The rotating gradients give the appearance of a swirling motion, and can
// serve a similar purpose for animation as motion along z in 3-D noise.
// The rotating gradients in conjunction with the analytic derivatives
// can make "flow noise" effects as presented by Perlin and Neyret.
//
// float3 {p}s{r}dnoise(float2 pos {, float2 per} {, float rot})
// "pos" is the input (x,y) coordinate
// "per" is the x and y period, where per.x is a positive integer
//    and per.y is a positive even integer
// "rot" is the angle to rotate the gradients (any float value,
//    where 0.0 is no rotation and 1.0 is one full turn)
// The first component of the 3-element return vector is the noise value.
// The second and third components are the x and y partial derivatives.
//
// float {p}s{r}noise(float2 pos {, float2 per} {, float rot})
// "pos" is the input (x,y) coordinate
// "per" is the x and y period, where per.x is a positive integer
//    and per.y is a positive even integer
// "rot" is the angle to rotate the gradients (any float value,
//    where 0.0 is no rotation and 1.0 is one full turn)
// The return value is the noise value.
// Partial derivatives are not computed, making these functions faster.
//
// Author: Stefan Gustavson (stefan.gustavson@gmail.com)
// Version 2016-05-10.
//
// Many thanks to Ian McEwan of Ashima Arts for the
// idea of umath.sing a permutation polynomial.
//
// Copyright (c) 2016 Stefan Gustavson. All rights reserved.
// Distributed under the MIT license. See LICENSE file.
// https://github.com/stegu/webgl-noise

// TODO: One-pixel wide artefacts used to occur due to precision issues with
// the gradient indexing. This is specific to this variant of noise, because
// one axis of the simplex grid is perfectly aligned with the input x axis.
// The errors were rare, and they are now very unlikely to ever be visible
// after a quick fix was introduced: a small offset is added to the y coordinate.
// A proper fix would involve umath.sing round() instead of math.floor() in selected
// places, but the quick fix works fine.
// (If you run into problems with this, please let me know.)
// 2-D tiling simplex noise with rotating gradients and analytical derivative.
/**
 * The first component of the 3-element return vector is the noise value,
 * and the second and third components are the x and y partial derivatives.
 */
float3 psrdnoise(float2 pos, float2 per, float rot)
{
  // Hack: offset y slightly to hide some rare artifacts
  pos.y += 0.01f;
  // Skew to hexagonal grid
  float2 uv = float2(mad(0.5f, pos.y, pos.x), pos.y);

  float2 i0;
  float2 f0 = modf(uv, i0);
  // Traversal order
  float2 i1 = (f0.x > f0.y) ? float2(1.0f, 0.0f) : float2(0.0f, 1.0f);

  // Unskewed grid points in (x,y) space
  float2 p0 = float2(mad(-0.5f, i0.y, i0.x), i0.y);
  float2 p1 = float2(mad(-0.5f, i1.y, p0.x + i1.x), p0.y + i1.y);
  float2 p2 = float2(p0.x + 0.5f, p0.y + 1.0f);

  // Vectors in unskewed (x,y) coordinates from
  // each of the simplex corners to the evaluation point
  float2 d0 = pos - p0;
  float2 d1 = pos - p1;
  float2 d2 = pos - p2;

  // Wrap p0, p1 and p2 to the desired period before gradient hashing:
  // wrap points in (x,y), map to (u,v)
  float3 xw = fmod(float3(p0.x, p1.x, p2.x), per.x);
  float3 yw = fmod(float3(p0.y, p1.y, p2.y), per.y);
  float3 iuw = mad(0.5f, yw, xw);
  float3 ivw = yw;

  // Create gradients from indices
  float2 g0 = rgrad2(float2(iuw.x, ivw.x), rot);
  float2 g1 = rgrad2(float2(iuw.y, ivw.y), rot);
  float2 g2 = rgrad2(float2(iuw.z, ivw.z), rot);

  // Gradients math.dot vectors to corresponding corners
  // (The derivatives of this are simply the gradients)
  float3 w = float3(dot(g0, d0), dot(g1, d1), dot(g2, d2));

  // Radial weights from corners
  // 0.8 is the square of 2/math.sqrt(5), the distance from
  // a grid point to the nearest simplex boundary
  float3 t = 0.8f - float3(dot(d0, d0), dot(d1, d1), dot(d2, d2));

  // Partial derivatives for analytical gradient computation
  float3 dtdx = -2.0f * float3(d0.x, d1.x, d2.x);
  float3 dtdy = -2.0f * float3(d0.y, d1.y, d2.y);

  // Set influence of each surflet to zero outside radius math.sqrt(0.8)
  if (t.x < 0.0f) {
    dtdx.x = 0.0f;
    dtdy.x = 0.0f;
    t.x = 0.0f;
  }
  if (t.y < 0.0f) {
    dtdx.y = 0.0f;
    dtdy.y = 0.0f;
    t.y = 0.0f;
  }
  if (t.z < 0.0f) {
    dtdx.z = 0.0f;
    dtdy.z = 0.0f;
    t.z = 0.0f;
  }

  // Fourth power of t (and third power for derivative)
  float3 t2 = t * t;
  float3 t4 = t2 * t2;
  float3 t3 = t2 * t;

  // Final noise value is:
  // sum of ((radial weights) times (gradient math.dot vector from corner))
  float n = dot(t4, w);

  // Final analytical derivative (gradient of a sum of scalar products)
  float2 dt0 = float2(dtdx.x, dtdy.x) * 4.0f * t3.x;
  float2 dn0 = t4.x * g0 + dt0 * w.x;
  float2 dt1 = float2(dtdx.y, dtdy.y) * 4.0f * t3.y;
  float2 dn1 = t4.y * g1 + dt1 * w.y;
  float2 dt2 = float2(dtdx.z, dtdy.z) * 4.0f * t3.z;
  float2 dn2 = t4.z * g2 + dt2 * w.z;

  return 11.0f * float3(n, dn0 + dn1 + dn2);
}

/**
 * 2-D tiling simplex noise with fixed gradients
 * and analytical derivative.
 * This function is implemented as a wrapper to "psrdnoise",
 * at the math.minimal math.cost of three extra additions.
 */
float3 psrdnoise(float2 pos, float2 per)
{
  return psrdnoise(pos, per, 0.0f);
}

/**
 * 2-D tiling simplex noise with rotating gradients,
 * but without the analytical derivative.
 */
float psrnoise(float2 pos, float2 per, float rot)
{
  // Offset y slightly to hide some rare artifacts
  pos.y += 0.001f;
  // Skew to hexagonal grid
  float2 uv = float2(mad(0.5f, pos.y, pos.x), pos.y);

  float2 i0;
  float2 f0 = modf(uv, i0);
  // Traversal order
  float2 i1 = (f0.x > f0.y) ? float2(1.0f, 0.0f) : float2(0.0f, 1.0f);

  // Unskewed grid points in (x,y) space
  float2 p0 = float2(mad(-0.5f, i0.y, i0.x), i0.y);
  float2 p1 = float2(mad(-0.5f, i1.y, p0.x + i1.x), p0.y + i1.y);
  float2 p2 = float2(p0.x + 0.5f, p0.y + 1.0f);

  // Vectors in unskewed (x,y) coordinates from
  // each of the simplex corners to the evaluation point
  float2 d0 = pos - p0;
  float2 d1 = pos - p1;
  float2 d2 = pos - p2;

  // Wrap p0, p1 and p2 to the desired period before gradient hashing:
  // wrap points in (x,y), map to (u,v)
  float3 xw = fmod(float3(p0.x, p1.x, p2.x), per.x);
  float3 yw = fmod(float3(p0.y, p1.y, p2.y), per.y);
  float3 iuw = mad(0.5f, yw, xw);
  float3 ivw = yw;

  // Create gradients from indices
  float2 g0 = rgrad2(float2(iuw.x, ivw.x), rot);
  float2 g1 = rgrad2(float2(iuw.y, ivw.y), rot);
  float2 g2 = rgrad2(float2(iuw.z, ivw.z), rot);

  // Gradients math.dot vectors to corresponding corners
  // (The derivatives of this are simply the gradients)
  float3 w = float3(dot(g0, d0), dot(g1, d1), dot(g2, d2));

  // Radial weights from corners
  // 0.8 is the square of 2/math.sqrt(5), the distance from
  // a grid point to the nearest simplex boundary
  float3 t = 0.8f - float3(dot(d0, d0), dot(d1, d1), dot(d2, d2));

  // Set influence of each surflet to zero outside radius math.sqrt(0.8)
  t = max(t, 0.0f);

  // Fourth power of t
  float3 t2 = t * t;
  float3 t4 = t2 * t2;

  // Final noise value is:
  // sum of ((radial weights) times (gradient math.dot vector from corner))
  float n = dot(t4, w);

  // Rescale to cover the range [-1,1] reasonably well
  return 11.0f * n;
}

/**
 * 2-D tiling simplex noise with fixed gradients,
 * without the analytical derivative.
 * This function is implemented as a wrapper to "psrnoise",
 * at the math.minimal math.cost of three extra additions.
 */
float psrnoise(float2 pos, float2 per)
{
  return psrnoise(pos, per, 0.0f);
}

/**
 * 2-D non-tiling simplex noise with rotating gradients and analytical derivative.
 * The first component of the 3-element return vector is the noise value,
 * and the second and third components are the x and y partial derivatives.
 */
float3 srdnoise(float2 pos, float rot)
{
  // Offset y slightly to hide some rare artifacts
  pos.y += 0.001f;
  // Skew to hexagonal grid
  float2 uv = float2(mad(0.5f, pos.y, pos.x), pos.y);

  float2 i0;
  float2 f0 = modf(uv, i0);
  // Traversal order
  float2 i1 = (f0.x > f0.y) ? float2(1.0f, 0.0f) : float2(0.0f, 1.0f);

  // Unskewed grid points in (x,y) space
  float2 p0 = float2(mad(-0.5f, i0.y, i0.x), i0.y);
  float2 p1 = float2(mad(-0.5f, i1.y, p0.x + i1.x), p0.y + i1.y);
  float2 p2 = float2(p0.x + 0.5f, p0.y + 1.0f);

  // Vectors in unskewed (x,y) coordinates from
  // each of the simplex corners to the evaluation point
  float2 d0 = pos - p0;
  float2 d1 = pos - p1;
  float2 d2 = pos - p2;

  float3 x = float3(p0.x, p1.x, p2.x);
  float3 y = float3(p0.y, p1.y, p2.y);
  float3 iuw = mad(0.5f, y, x);
  float3 ivw = y;

  // Avoid precision issues in permutation
  iuw = mod289(iuw);
  ivw = mod289(ivw);

  // Create gradients from indices
  float2 g0 = rgrad2(float2(iuw.x, ivw.x), rot);
  float2 g1 = rgrad2(float2(iuw.y, ivw.y), rot);
  float2 g2 = rgrad2(float2(iuw.z, ivw.z), rot);

  // Gradients math.dot vectors to corresponding corners
  // (The derivatives of this are simply the gradients)
  float3 w = float3(dot(g0, d0), dot(g1, d1), dot(g2, d2));

  // Radial weights from corners
  // 0.8 is the square of 2/math.sqrt(5), the distance from
  // a grid point to the nearest simplex boundary
  float3 t = 0.8f - float3(dot(d0, d0), dot(d1, d1), dot(d2, d2));

  // Partial derivatives for analytical gradient computation
  float3 dtdx = -2.0f * float3(d0.x, d1.x, d2.x);
  float3 dtdy = -2.0f * float3(d0.y, d1.y, d2.y);

  // Set influence of each surflet to zero outside radius math.sqrt(0.8)
  if (t.x < 0.0f) {
    dtdx.x = 0.0f;
    dtdy.x = 0.0f;
    t.x = 0.0f;
  }
  if (t.y < 0.0f) {
    dtdx.y = 0.0f;
    dtdy.y = 0.0f;
    t.y = 0.0f;
  }
  if (t.z < 0.0f) {
    dtdx.z = 0.0f;
    dtdy.z = 0.0f;
    t.z = 0.0f;
  }

  // Fourth power of t (and third power for derivative)
  float3 t2 = t * t;
  float3 t4 = t2 * t2;
  float3 t3 = t2 * t;

  // Final noise value is:
  // sum of ((radial weights) times (gradient math.dot vector from corner))
  float n = dot(t4, w);

  // Final analytical derivative (gradient of a sum of scalar products)
  float2 dt0 = float2(dtdx.x, dtdy.x) * 4.0f * t3.x;
  float2 dn0 = t4.x * g0 + dt0 * w.x;
  float2 dt1 = float2(dtdx.y, dtdy.y) * 4.0f * t3.y;
  float2 dn1 = t4.y * g1 + dt1 * w.y;
  float2 dt2 = float2(dtdx.z, dtdy.z) * 4.0f * t3.z;
  float2 dn2 = t4.z * g2 + dt2 * w.z;

  return 11.0f * float3(n, dn0 + dn1 + dn2);
}

/**
 * 2-D non-tiling simplex noise with fixed gradients and analytical derivative.
 * This function is implemented as a wrapper to "srdnoise",
 * at the math.minimal math.cost of three extra additions.
 */
float3 srdnoise(float2 pos)
{
  return srdnoise(pos, 0.0f);
}

/**
 * 2-D non-tiling simplex noise with rotating gradients,
 * without the analytical derivative.
 */
float srnoise(float2 pos, float rot)
{
  // Offset y slightly to hide some rare artifacts
  pos.y += 0.001f;
  // Skew to hexagonal grid
  float2 uv = float2(mad(0.5f, pos.y, pos.x), pos.y);

  float2 i0;
  float2 f0 = modf(uv, i0);
  // Traversal order
  float2 i1 = (f0.x > f0.y) ? float2(1.0f, 0.0f) : float2(0.0f, 1.0f);

  // Unskewed grid points in (x,y) space
  float2 p0 = float2(mad(-0.5f, i0.y, i0.x), i0.y);
  float2 p1 = float2(mad(-0.5f, i1.y, p0.x + i1.x), p0.y + i1.y);
  float2 p2 = float2(p0.x + 0.5f, p0.y + 1.0f);

  // Vectors in unskewed (x,y) coordinates from
  // each of the simplex corners to the evaluation point
  float2 d0 = pos - p0;
  float2 d1 = pos - p1;
  float2 d2 = pos - p2;

  float3 x = float3(p0.x, p1.x, p2.x);
  float3 y = float3(p0.y, p1.y, p2.y);
  float3 iuw = mad(0.5f, y, x);
  float3 ivw = y;

  // Avoid precision issues in permutation
  iuw = mod289(iuw);
  ivw = mod289(ivw);

  // Create gradients from indices
  float2 g0 = rgrad2(float2(iuw.x, ivw.x), rot);
  float2 g1 = rgrad2(float2(iuw.y, ivw.y), rot);
  float2 g2 = rgrad2(float2(iuw.z, ivw.z), rot);

  // Gradients math.dot vectors to corresponding corners
  // (The derivatives of this are simply the gradients)
  float3 w = float3(dot(g0, d0), dot(g1, d1), dot(g2, d2));

  // Radial weights from corners
  // 0.8 is the square of 2/math.sqrt(5), the distance from
  // a grid point to the nearest simplex boundary
  float3 t = 0.8f - float3(dot(d0, d0), dot(d1, d1), dot(d2, d2));

  // Set influence of each surflet to zero outside radius math.sqrt(0.8)
  t = max(t, 0.0f);

  // Fourth power of t
  float3 t2 = t * t;
  float3 t4 = t2 * t2;

  // Final noise value is:
  // sum of ((radial weights) times (gradient math.dot vector from corner))
  float n = dot(t4, w);

  // Rescale to cover the range [-1,1] reasonably well
  return 11.0f * n;
}

/**
 * 2-D non-tiling simplex noise with fixed gradients,
 * without the analytical derivative.
 * This function is implemented as a wrapper to "srnoise",
 * at the math.minimal math.cost of three extra additions.
 * Note: if this kind of noise is all you want, there are faster
 * GLSL implementations of non-tiling simplex noise out there.
 * This one is included mainly for completeness and compatibility
 * with the other functions in the file.
 */
float srnoise(float2 pos)
{
  return srnoise(pos, 0.0f);
}

#endif
