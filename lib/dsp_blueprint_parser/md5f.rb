
module DspBlueprintParser
  # class to generate DSP custom MD5F hash
  class Md5f
    @a
    @b
    @c
    @d

    @s11 = 7
    @s12 = 12
    @s13 = 17
    @s14 = 22
    @s21 = 5
    @s22 = 9
    @s23 = 14
    @s24 = 20
    @s31 = 4
    @s32 = 11
    @s33 = 16
    @s34 = 23
    @s41 = 6
    @s42 = 10
    @s43 = 15
    @s44 = 21

    def compute(message)
      array_to_hex_string(md5_array(message.force_encoding('UTF-8').each_byte.to_a), true)
    end

    private

    # @param x [Integer]
    # @param y [Integer]
    # @param z [Integer]
    # @return [Integer]
    def f(x, y, z)
      x & y | ~x & z
    end

    # @param x [Integer]
    # @param y [Integer]
    # @param z [Integer]
    # @return [Integer]
    def g(x, y, z)
      x & z | y & ~z
    end

    # @param x [Integer]
    # @param y [Integer]
    # @param z [Integer]
    # @return [Integer]
    def h(x, y, z)
      x ^ y ^ z
    end

    # @param x [Integer]
    # @param y [Integer]
    # @param z [Integer]
    # @return [Integer]
    def i(x, y, z)
      y ^ (x | ~z)
    end

    # @param a[Integer]
    # @param b [Integer]
    # @param c [Integer]
    # @param d [Integer]
    # @param mj [Integer]
    # @param s [Integer]
    # @param ti [Integer]
    def ff(a, b, c, d, mj, s, ti)
      a = a + f(b, c, d) + mj + ti
      a = a << s | a >> 32 - s
      a += b
      a
    end

    # @param a[Integer]
    # @param b [Integer]
    # @param c [Integer]
    # @param d [Integer]
    # @param mj [Integer]
    # @param s [Integer]
    # @param ti [Integer]
    def gg(a, b, c, d, mj, s, ti)
      a = a + g(b, c, d) + mj + ti
      a = a << s | a >> 32 - s
      a += b
      a
    end

    # @param a[Integer]
    # @param b [Integer]
    # @param c [Integer]
    # @param d [Integer]
    # @param mj [Integer]
    # @param s [Integer]
    # @param ti [Integer]
    def hh(a, b, c, d, mj, s, ti)
      a = a + h(b, c, d) + mj + ti
      a = a << s | a >> 32 - s
      a += b
      a
    end

    # @param a[Integer]
    # @param b [Integer]
    # @param c [Integer]
    # @param d [Integer]
    # @param mj [Integer]
    # @param s [Integer]
    # @param ti [Integer]
    def ii(a, b, c, d, mj, s, ti)
      a = a + i(b, c, d) + mj + ti
      a = a << s | a >> 32 - s
      a += b
      a
    end

    def md5_init
      @a = 1_732_584_193
      @b = 4_024_216_457
      @c = 2_562_383_102
      @d = 271_734_598
    end

    # @param input [Array<Integer>]
    # @return [Array<Integer>]
    def md5_append(input)
      num1 = 1
      length = input.size
      num2 = length % 64
      num3 = nil
      num4 = nil
      if num2 < 56
        num3 = 55 - num2
        num4 = length - num2 + 64
      elsif num2 == 56
        num3 = 63
        num1 = 1
        num4 = length + 8 + 64
      else
        num3 = 63 - num2 + 56
        num4 = length + 64 - num2 + 64
      end

      array_list = input.to_a
      array_list << 128 if num1 == 1

      index = 0
      while index < num3
        array_list << 0
        index += 1
      end

      num5 = length * 8
      num6 = num5 & 255
      num7 = num5 >> 8 & 255
      num8 = num5 >> 16 & 255
      num9 = num5 >> 24 & 255
      num10 = num5 >> 32 & 255
      num11 = num5 >> 40 & 255
      num12 = num5 >> 48 & 255
      num13 = num5 >> 56

      array_list << num6
      array_list << num7
      array_list << num8
      array_list << num9
      array_list << num10
      array_list << num11
      array_list << num12
      array_list << num13

      num_array = []
      index = 0
      while index * 4 < num4
        num_array << (array_list[index] || 0 | (array_list[index + 1] || 0 << 8) | (array_list[index + 2] || 0 << 16) | (array_list[index + 3] || 0 << 24))
        index += 1
      end

      num_array
    end

    # @param x [Array<Integer>]
    # @return [Array<Integer>]
    def md5_transform(x)
      puts x.size
      index = 0
      while index < x.size
        a = @a
        b = @b
        c = @c
        d = @d
        a = ff(a, b, c, d, x[index], 7, 3_614_090_360)
        d = ff(d, a, b, c, x[index + 1], 12, 3_906_451_286)
        c = ff(c, d, a, b, x[index + 2], 17, 606_105_819)
        b = ff(b, c, d, a, x[index + 3], 22, 3_250_441_966)
        a = ff(a, b, c, d, x[index + 4], 7, 4_118_548_399)
        d = ff(d, a, b, c, x[index + 5], 12, 1_200_080_426)
        c = ff(c, d, a, b, x[index + 6], 17, 2_821_735_971)
        b = ff(b, c, d, a, x[index + 7], 22, 4_249_261_313)
        a = ff(a, b, c, d, x[index + 8], 7, 1_770_035_416)
        d = ff(d, a, b, c, x[index + 9], 12, 2_336_552_879)
        c = ff(c, d, a, b, x[index + 10], 17, 4_294_925_233)
        b = ff(b, c, d, a, x[index + 11], 22, 2_304_563_134)
        a = ff(a, b, c, d, x[index + 12], 7, 1_805_586_722)
        d = ff(d, a, b, c, x[index + 13], 12, 4_254_626_195)
        c = ff(c, d, a, b, x[index + 14], 17, 2_792_965_006)
        b = ff(b, c, d, a, x[index + 15], 22, 968_099_873)
        a = gg(a, b, c, d, x[index + 1], 5, 4_129_170_786)
        d = gg(d, a, b, c, x[index + 6], 9, 3_225_465_664)
        c = gg(c, d, a, b, x[index + 11], 14, 643_717_713)
        b = gg(b, c, d, a, x[index], 20, 3_384_199_082)
        a = gg(a, b, c, d, x[index + 5], 5, 3_593_408_605)
        d = gg(d, a, b, c, x[index + 10], 9, 38_024_275)
        c = gg(c, d, a, b, x[index + 15], 14, 3_634_488_961)
        b = gg(b, c, d, a, x[index + 4], 20, 3_889_429_448)
        a = gg(a, b, c, d, x[index + 9], 5, 569_495_014)
        d = gg(d, a, b, c, x[index + 14], 9, 3_275_163_606)
        c = gg(c, d, a, b, x[index + 3], 14, 4_107_603_335)
        b = gg(b, c, d, a, x[index + 8], 20, 1_197_085_933)
        a = gg(a, b, c, d, x[index + 13], 5, 2_850_285_829)
        d = gg(d, a, b, c, x[index + 2], 9, 4_243_563_512)
        c = gg(c, d, a, b, x[index + 7], 14, 1_735_328_473)
        b = gg(b, c, d, a, x[index + 12], 20, 2_368_359_562)
        a = hh(a, b, c, d, x[index + 5], 4, 4_294_588_738)
        d = hh(d, a, b, c, x[index + 8], 11, 2_272_392_833)
        c = hh(c, d, a, b, x[index + 11], 16, 1_839_030_562)
        b = hh(b, c, d, a, x[index + 14], 23, 4_259_657_740)
        a = hh(a, b, c, d, x[index + 1], 4, 2_763_975_236)
        d = hh(d, a, b, c, x[index + 4], 11, 1_272_893_353)
        c = hh(c, d, a, b, x[index + 7], 16, 4_139_469_664)
        b = hh(b, c, d, a, x[index + 10], 23, 3_200_236_656)
        a = hh(a, b, c, d, x[index + 13], 4, 681_279_174)
        d = hh(d, a, b, c, x[index], 11, 3_936_430_074)
        c = hh(c, d, a, b, x[index + 3], 16, 3_572_445_317)
        b = hh(b, c, d, a, x[index + 6], 23, 76_029_189)
        a = hh(a, b, c, d, x[index + 9], 4, 3_654_602_809)
        d = hh(d, a, b, c, x[index + 12], 11, 3_873_151_461)
        c = hh(c, d, a, b, x[index + 15], 16, 530_742_520)
        b = hh(b, c, d, a, x[index + 2], 23, 3_299_628_645)
        a = ii(a, b, c, d, x[index], 6, 4_096_336_452)
        d = ii(d, a, b, c, x[index + 7], 10, 1_126_891_415)
        c = ii(c, d, a, b, x[index + 14], 15, 2_878_612_391)
        b = ii(b, c, d, a, x[index + 5], 21, 4_237_533_241)
        a = ii(a, b, c, d, x[index + 12], 6, 1_700_485_571)
        d = ii(d, a, b, c, x[index + 3], 10, 2_399_980_690)
        c = ii(c, d, a, b, x[index + 10], 15, 4_293_915_773)
        b = ii(b, c, d, a, x[index + 1], 21, 2_240_044_497)
        a = ii(a, b, c, d, x[index + 8], 6, 1_873_313_359)
        d = ii(d, a, b, c, x[index + 15], 10, 4_264_355_552)
        c = ii(c, d, a, b, x[index + 6], 15, 2_734_768_916)
        b = ii(b, c, d, a, x[index + 13], 21, 1_309_151_649)
        a = ii(a, b, c, d, x[index + 4], 6, 4_149_444_226)
        d = ii(d, a, b, c, x[index + 11], 10, 3_174_756_917)
        c = ii(c, d, a, b, x[index + 2], 15, 718_787_259)
        b = ii(b, c, d, a, x[index + 9], 21, 3_951_481_745)
        @a += a
        @b += b
        @c += c
        @d += d

        puts @a
        index += 16
        puts index
      end

      [@a, @b, @c, @d]
    end

    # @param input [Array<Integer>]
    # @return [Array<Integer>]
    def md5_array(input)
      md5_init
      num_array1 = md5_transform(md5_append(input))
      num_array2 = []

      binding.pry

      int index1 = 0
      while index1 < num_array1.size
        num_array2 << num_array1[index1] & 255
        num_array2 << num_array1[index1] >> 8 & 255
        num_array2 << num_array1[index1] >> 16 & 255
        num_array2 << num_array1[index1] >> 24 & 255
        index1 += 1
      end

      num_array2
    end

    # @param array [Array<Integer>]
    # @param uppercase [Boolean]
    # @return String
    def array_to_hex_string(array, uppercase)
      result = array.reduce('') { |accumulator, number| accumulator += number.to_s(16) }
      result = result.upcase if uppercase
      result
    end

    # @param input [Integer]
    # @param bits [Integer]
    # @return [Integer]
    def get_complement(input, bits)
      input
        .to_s(2)
        .rjust(bits, '0')
        .each_char
        .reduce('') { |accumulator, character| accumulator += character == '0' ? '1' : '0' }
        .to_i(2)
    end
  end
end