# frozen_string_literal: true
require 'date'
require "zlib"
require 'stringio'
require 'base64'

require_relative "dsp_blueprint_parser/version"
require_relative "dsp_blueprint_parser/blueprint_data"
require_relative "dsp_blueprint_parser/icon_layout"
require_relative "dsp_blueprint_parser/area"
require_relative "dsp_blueprint_parser/building"
require_relative 'dsp_blueprint_parser/binary_reader'

module DspBlueprintParser
  SECONDS_AT_EPOC = 62135596800.freeze

  class Error < StandardError; end

  # @param str_blueprint [String]
  def self.parse(str_blueprint)
    return if str_blueprint.size < 28
    return unless str_blueprint.start_with? 'BLUEPRINT:'

    header_end = str_blueprint.index('"')
    header = str_blueprint[10..header_end - 1]
    header_segments = header.split(',')

    blueprint = BlueprintData.new

    blueprint.icon_layout = header_segments[1].to_i
    blueprint.icon0 = header_segments[2].to_i
    blueprint.icon1 = header_segments[3].to_i
    blueprint.icon2 = header_segments[4].to_i
    blueprint.icon3 = header_segments[5].to_i
    blueprint.icon4 = header_segments[6].to_i

    blueprint.time = ticks_to_epoch(header_segments[8].to_i)
    blueprint.game_version = header_segments[9]
    blueprint.short_description = CGI.unescape(header_segments[10])
    blueprint.description = CGI.unescape(header_segments[11])

    blueprint_end = str_blueprint[header_end + 1..-1].index('"') + header_end + 1
    blueprint_compressed = str_blueprint[header_end + 1..blueprint_end - 1]

    gz = Zlib::GzipReader.new(StringIO.new(Base64.decode64(blueprint_compressed)))
    blueprint_decompressed = gz.each_byte.to_a

    reader = BinaryReader.new(blueprint_decompressed)

    blueprint.version = reader.read_i32
    blueprint.cursor_offset_x = reader.read_i32
    blueprint.cursor_offset_y = reader.read_i32
    blueprint.cursor_target_area = reader.read_i32
    blueprint.drag_box_size_x = reader.read_i32
    blueprint.drag_box_size_y = reader.read_i32
    blueprint.primary_area_idx = reader.read_i32

    area_length = reader.read_i8
    area_index = 0
    blueprint.areas = Array.new

    while area_index < area_length
      area = Area.new
      area.index = reader.read_i8
      area.parent_index = reader.read_i8
      area.tropic_anchor = reader.read_i16
      area.area_segments = reader.read_i16
      area.anchor_local_offset_x = reader.read_i16
      area.anchor_local_offset_y = reader.read_i16
      area.width = reader.read_i16
      area.height = reader.read_i16

      blueprint.areas[area_index] = area
      area_index += 1
    end

    binding.pry
  end

  # @param ticks [Integer]
  # @return [DateTime]
  def self.ticks_to_epoch(ticks)
    # 10mil ticks per second
    seconds = ticks / 10_000_000

    Time.at(seconds - SECONDS_AT_EPOC)
  end

  # Your code goes here...
  #
  #
end
