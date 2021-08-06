#include<stdio.h> // define the header file  
#include <stdlib.h>
#include <string.h>
#include "ruby.h"
#include <extconf.h>

typedef struct _node {
  uint length;
  uint *array;
} node;

uint A;
uint B;
uint C;
uint D;

const int S11 = 7;
const int S12 = 12;
const int S13 = 17;
const int S14 = 22;
const int S21 = 5;
const int S22 = 9;
const int S23 = 14;
const int S24 = 20;
const int S31 = 4;
const int S32 = 11;
const int S33 = 16;
const int S34 = 23;
const int S41 = 6;
const int S42 = 10;
const int S43 = 15;
const int S44 = 21;

// ugly, I know
uint ArrayLength = 0;

uint F(uint x, uint y, uint z)
{
    return (uint) (((int) x & (int) y) | (~(int) x & (int) z));
}

uint G(uint x, uint y, uint z)
{
    return (uint) (((int) x & (int) z) | ((int) y & ~(int) z));
}

uint H(uint x, uint y, uint z)
{
    return x ^ y ^ z;
}

uint I(uint x, uint y, uint z)
{
    return y ^ (x | ~z);
}

uint FF(uint a, uint b, uint c, uint d, uint mj, int s, uint ti)
{
    a = a + F(b, c, d) + mj + ti;
    a = a << s | a >> (32 - s);
    a += b;
    return a;
}

uint GG(uint a, uint b, uint c, uint d, uint mj, int s, uint ti)
{
    a = a + G(b, c, d) + mj + ti;
    a = a << s | a >> (32 - s);
    a += b;
    return a;
}

uint HH(uint a, uint b, uint c, uint d, uint mj, int s, uint ti)
{
    a = a + H(b, c, d) + mj + ti;
    a = a << s | a >> (32 - s);
    a += b;
    return a;
}

uint II(uint a, uint b, uint c, uint d, uint mj, int s, uint ti)
{
    a = a + I(b, c, d) + mj + ti;
    a = a << s | a >> (32 - s);
    a += b;
    return a;
}

void MD5_Init()
{
    A = 1732584193U;
    B = 4024216457U;
    C = 2562383102U;
    D = 271734598U;
}

uint * MD5_Append(unsigned char input[], size_t length)
{
    int num1 = 1;
    // int length = input.Length;
    int num2 = length % 64;
    int num3;
    int num4 = 0;
    if (num2 < 56)
    {
        num3 = 55 - num2;
        num4 = length - num2 + 64;
    }
    else if (num2 == 56)
    {
        num3 = 63;
        num1 = 1;
        num4 = length + 8 + 64;
    }
    else
    {
        num3 = 63 - num2 + 56;
        num4 = length + 64 - num2 + 64;
    }

    unsigned char arrayList[num3 + 9 + length];
    uint position = 0;

    for (size_t i = 0; i < length; i++)
    {
        arrayList[position++] = input[i];
    }

    if (num1 == 1)
    {
        arrayList[position++] = (unsigned char) 128;
    }

    for (int index = 0; index < num3; ++index)
    {
        arrayList[position++] = (unsigned char) 0;
    }

    long num5 = (long) length * 8L;
    unsigned char num6 = (unsigned char) ((ulong) num5 & (ulong) 255);
    unsigned char num7 = (unsigned char) ((ulong) num5 >> 8 & (ulong) 255);
    unsigned char num8 = (unsigned char) ((ulong) num5 >> 16 & (ulong) 255);
    unsigned char num9 = (unsigned char) ((ulong) num5 >> 24 & (ulong) 255);
    unsigned char num10 = (unsigned char) ((ulong) num5 >> 32 & (ulong) 255);
    unsigned char num11 = (unsigned char) ((ulong) num5 >> 40 & (ulong) 255);
    unsigned char num12 = (unsigned char) ((ulong) num5 >> 48 & (ulong) 255);
    unsigned char num13 = (unsigned char) ((ulong) num5 >> 56);
    arrayList[position++] = num6;
    arrayList[position++] = num7;
    arrayList[position++] = num8;
    arrayList[position++] = num9;
    arrayList[position++] = num10;
    arrayList[position++] = num11;
    arrayList[position++] = num12;
    arrayList[position++] = num13;

    ArrayLength = num4 / 4;
    uint *numArray = calloc(ArrayLength, sizeof(uint));
    long index1 = 0;
    long index2 = 0;
    for (; index1 < (long) num4; index1 += 4)
    {
        numArray[index2] = (uint) ((int) arrayList[index1] | ((int) arrayList[index1 + 1] << 8) | ((int) arrayList[index1 + 2] << 16) | ((int) arrayList[index1 + 3] << 24));
        ++index2;
    }

    return numArray;
}

void MD5_Trasform(uint x[])
{
    for (int index = 0; index < ArrayLength; index += 16)
    {
        uint a = A;
        uint b = B;
        uint c = C;
        uint d = D;
        a = FF(a, b, c, d, x[index], 7, 3614090360U);
        d = FF(d, a, b, c, x[index + 1], 12, 3906451286U);
        c = FF(c, d, a, b, x[index + 2], 17, 606105819U);
        b = FF(b, c, d, a, x[index + 3], 22, 3250441966U);
        a = FF(a, b, c, d, x[index + 4], 7, 4118548399U);
        d = FF(d, a, b, c, x[index + 5], 12, 1200080426U);
        c = FF(c, d, a, b, x[index + 6], 17, 2821735971U);
        b = FF(b, c, d, a, x[index + 7], 22, 4249261313U);
        a = FF(a, b, c, d, x[index + 8], 7, 1770035416U);
        d = FF(d, a, b, c, x[index + 9], 12, 2336552879U);
        c = FF(c, d, a, b, x[index + 10], 17, 4294925233U);
        b = FF(b, c, d, a, x[index + 11], 22, 2304563134U);
        a = FF(a, b, c, d, x[index + 12], 7, 1805586722U);
        d = FF(d, a, b, c, x[index + 13], 12, 4254626195U);
        c = FF(c, d, a, b, x[index + 14], 17, 2792965006U);
        b = FF(b, c, d, a, x[index + 15], 22, 968099873U);
        a = GG(a, b, c, d, x[index + 1], 5, 4129170786U);
        d = GG(d, a, b, c, x[index + 6], 9, 3225465664U);
        c = GG(c, d, a, b, x[index + 11], 14, 643717713U);
        b = GG(b, c, d, a, x[index], 20, 3384199082U);
        a = GG(a, b, c, d, x[index + 5], 5, 3593408605U);
        d = GG(d, a, b, c, x[index + 10], 9, 38024275U);
        c = GG(c, d, a, b, x[index + 15], 14, 3634488961U);
        b = GG(b, c, d, a, x[index + 4], 20, 3889429448U);
        a = GG(a, b, c, d, x[index + 9], 5, 569495014U);
        d = GG(d, a, b, c, x[index + 14], 9, 3275163606U);
        c = GG(c, d, a, b, x[index + 3], 14, 4107603335U);
        b = GG(b, c, d, a, x[index + 8], 20, 1197085933U);
        a = GG(a, b, c, d, x[index + 13], 5, 2850285829U);
        d = GG(d, a, b, c, x[index + 2], 9, 4243563512U);
        c = GG(c, d, a, b, x[index + 7], 14, 1735328473U);
        b = GG(b, c, d, a, x[index + 12], 20, 2368359562U);
        a = HH(a, b, c, d, x[index + 5], 4, 4294588738U);
        d = HH(d, a, b, c, x[index + 8], 11, 2272392833U);
        c = HH(c, d, a, b, x[index + 11], 16, 1839030562U);
        b = HH(b, c, d, a, x[index + 14], 23, 4259657740U);
        a = HH(a, b, c, d, x[index + 1], 4, 2763975236U);
        d = HH(d, a, b, c, x[index + 4], 11, 1272893353U);
        c = HH(c, d, a, b, x[index + 7], 16, 4139469664U);
        b = HH(b, c, d, a, x[index + 10], 23, 3200236656U);
        a = HH(a, b, c, d, x[index + 13], 4, 681279174U);
        d = HH(d, a, b, c, x[index], 11, 3936430074U);
        c = HH(c, d, a, b, x[index + 3], 16, 3572445317U);
        b = HH(b, c, d, a, x[index + 6], 23, 76029189U);
        a = HH(a, b, c, d, x[index + 9], 4, 3654602809U);
        d = HH(d, a, b, c, x[index + 12], 11, 3873151461U);
        c = HH(c, d, a, b, x[index + 15], 16, 530742520U);
        b = HH(b, c, d, a, x[index + 2], 23, 3299628645U);
        a = II(a, b, c, d, x[index], 6, 4096336452U);
        d = II(d, a, b, c, x[index + 7], 10, 1126891415U);
        c = II(c, d, a, b, x[index + 14], 15, 2878612391U);
        b = II(b, c, d, a, x[index + 5], 21, 4237533241U);
        a = II(a, b, c, d, x[index + 12], 6, 1700485571U);
        d = II(d, a, b, c, x[index + 3], 10, 2399980690U);
        c = II(c, d, a, b, x[index + 10], 15, 4293915773U);
        b = II(b, c, d, a, x[index + 1], 21, 2240044497U);
        a = II(a, b, c, d, x[index + 8], 6, 1873313359U);
        d = II(d, a, b, c, x[index + 15], 10, 4264355552U);
        c = II(c, d, a, b, x[index + 6], 15, 2734768916U);
        b = II(b, c, d, a, x[index + 13], 21, 1309151649U);
        a = II(a, b, c, d, x[index + 4], 6, 4149444226U);
        d = II(d, a, b, c, x[index + 11], 10, 3174756917U);
        c = II(c, d, a, b, x[index + 2], 15, 718787259U);
        b = II(b, c, d, a, x[index + 9], 21, 3951481745U);
        A += a;
        B += b;
        C += c;
        D += d;
    }
}

unsigned char * MD5_Array(unsigned char input[])
{
    MD5_Init();
    uint *append = MD5_Append(input, strlen(input)); //todo length
    MD5_Trasform(append);
    uint numArray1[4] = { A, B, C, D};

    unsigned char *numArray2 = calloc(4 * 4, sizeof(unsigned char));

    int index1 = 0;
    int index2 = 0;
    while (index1 < 4)
    {
        numArray2[index2] = (unsigned char) (numArray1[index1] & (uint) 255);
        numArray2[index2 + 1] = (unsigned char) (numArray1[index1] >> 8 & (uint) 255);
        numArray2[index2 + 2] = (unsigned char) (numArray1[index1] >> 16 & (uint) 255);
        numArray2[index2 + 3] = (unsigned char) (numArray1[index1] >> 24 & (uint) 255);
        ++index1;
        index2 += 4;
    }

    free(append);
    return numArray2;
}

unsigned char * ArrayToHexString(unsigned char input[])
{
    size_t length = 16;
    unsigned char *result = calloc(length * 2, sizeof(unsigned char));

    for (size_t i = 0; i < length; i++)
    {
        sprintf(result+2*i, "%.2X", input[i]);
    }

    return result;
}

unsigned char * Compute(unsigned char message[])
{
    unsigned char * data = MD5_Array(message);
    unsigned char * result = ArrayToHexString(data);

    free(data);
    return result;
}

// int main()   // define the main function
// {
//     unsigned char input[18] = "very large string\0";
//     unsigned char *hex = Compute(input);
//     for (size_t i = 0; i < 32; i++)
//     {
//         printf("%C", hex[i]);
//     }

//     free(hex);
// }

VALUE MD5F = Qnil;  /* Ruby Module */

VALUE rb_print_length(VALUE self, VALUE str) {
    if (RB_TYPE_P(str, T_STRING) == 1) {
        return rb_sprintf("String length: %ld", RSTRING_LEN(str));
    }
    return Qnil;
}

void Init_foobar()
{
    MD5F = rb_define_module("MD5F");
    rb_define_method(MD5F, "print_length", rb_print_length, 1);
}