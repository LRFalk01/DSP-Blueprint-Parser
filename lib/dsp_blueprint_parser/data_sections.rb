# frozen_string_literal: true

module DspBlueprintParser
  # Data Sections
  #
  # Given a raw DSP Blueprint sting this returns readability
  # usable data on the string
  class DataSections
    # @param str_blueprint [String]
    def initialize(str_blueprint)
      @str_blueprint = str_blueprint
      @first_quote_loc = @str_blueprint.index('"')
      @second_quote_loc = @str_blueprint[(@first_quote_loc + 1)..].index('"') + @first_quote_loc
    end

    # @return [Array<String>]
    def header_segments
      @header_segments ||= @str_blueprint[10..@first_quote_loc - 1].split(',')
    end

    # @return [Array<Integer>] array of bytes, 0..255
    def decompressed_body
      @decompressed_body ||=
        @str_blueprint[@first_quote_loc + 1..@second_quote_loc]
        .then(&Base64.method(:decode64))
        .then(&StringIO.method(:new))
        .then(&Zlib::GzipReader.method(:new))
        .each_byte
        .to_a
    end
  end
end
