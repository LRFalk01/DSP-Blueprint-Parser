# frozen_string_literal: true

module DspBlueprintParser
  # class to orchestrate parsing
  class Parser
    SECONDS_AT_EPOC = 62_135_596_800
    URI_PARSER = URI::Parser.new.freeze

    # @param [String] str_blueprint
    def initialize(str_blueprint)
      @data_sections = DataSections.new(str_blueprint)
    end

    # @return [BlueprintData]
    def blueprint
      @blueprint ||= BlueprintData.new.tap do |blueprint|
        parse_metadata(blueprint)
        parse_areas(blueprint)
        parse_buildings(blueprint)
      end
    end

    private

    # @return [Array<String>]
    def header_segments
      @header_segments ||= @data_sections.header_segments
    end

    # @return [BinaryReader]
    def reader
      @reader ||= BinaryReader.new(@data_sections.decompressed_body)
    end

    # @param ticks [Integer]
    # @return [Time]
    def ticks_to_epoch(ticks)
      # 10mil ticks per second
      seconds = ticks / 10_000_000

      Time.at(seconds - SECONDS_AT_EPOC)
    end

    # @param [BlueprintData] blueprint
    def parse_areas(blueprint)
      reader.read_i8.times do
        area = Area.new
        area.index = reader.read_i8
        area.parent_index = reader.read_i8
        area.tropic_anchor = reader.read_i16
        area.area_segments = reader.read_i16
        area.anchor_local_offset_x = reader.read_i16
        area.anchor_local_offset_y = reader.read_i16
        area.width = reader.read_i16
        area.height = reader.read_i16

        blueprint.areas << area
      end
    end

    # @param [BlueprintData] blueprint
    def parse_buildings(blueprint)
      BuildingParser.process!(blueprint, reader)
    end

    # @param [BlueprintData] blueprint
    def parse_metadata(blueprint)
      header_version = header_segments[0].gsub(':', '').to_i

      blueprint.icon_layout = header_segments[1].to_i
      blueprint.icon0 = header_segments[2].to_i
      blueprint.icon1 = header_segments[3].to_i
      blueprint.icon2 = header_segments[4].to_i
      blueprint.icon3 = header_segments[5].to_i
      blueprint.icon4 = header_segments[6].to_i

      blueprint.time = ticks_to_epoch(header_segments[8].to_i)
      blueprint.game_version = header_segments[9]

      blueprint.short_description = uri_unescape(header_segments[10])

      if header_version >= 1
        blueprint.author = uri_unescape(header_segments[11])
        blueprint.custom_version = uri_unescape(header_segments[12])
        blueprint.attributes = uri_unescape(header_segments[13])&.split(';')
        blueprint.description = uri_unescape(header_segments[14])
      elsif header_segments[11]
        blueprint.description = uri_unescape(header_segments[11])
      end

      blueprint.version = reader.read_i32
      blueprint.cursor_offset_x = reader.read_i32
      blueprint.cursor_offset_y = reader.read_i32
      blueprint.cursor_target_area = reader.read_i32
      blueprint.drag_box_size_x = reader.read_i32
      blueprint.drag_box_size_y = reader.read_i32
      blueprint.primary_area_idx = reader.read_i32
    end

    # @param input [String, nil]
    # @return [String, nil]
    def uri_unescape(input)
      return nil if input.nil?

      URI_PARSER.unescape(input)
    end
  end
end
