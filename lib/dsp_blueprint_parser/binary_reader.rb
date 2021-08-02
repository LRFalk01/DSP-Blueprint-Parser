module DspBlueprintParser
  class BinaryReader
    # @param data [Array<byte>]
    def initialize(data)
      @data = data
      @position = 0
    end

    def read_i32
      get_integer(4, 'l<')
    end

    def read_i16
      get_integer(2, 's<')
    end

    def read_i8
      get_integer(1, 'c')
    end

    def read_single
      get_integer(4, 'e')
    end

    private
    # @param byte_count [Integer]
    # @return [String]
    def get_string(byte_count)
      value = @data[@position..@position + byte_count].pack('C*').force_encoding('UTF-8')
      @position += byte_count

      value
    end

    # @param byte_count [Integer]
    # @param format [String]
    # @return [Integer]
    def get_integer(byte_count, format)
      get_string(byte_count).unpack(format)[0]
    end
  end
end