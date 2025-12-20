# frozen_string_literal: true

require 'date'
require 'zlib'
require 'stringio'
require 'base64'
require 'md5f'

require_relative 'dsp_blueprint_parser/version'
require_relative 'dsp_blueprint_parser/blueprint_data'
require_relative 'dsp_blueprint_parser/icon_layout'
require_relative 'dsp_blueprint_parser/area'
require_relative 'dsp_blueprint_parser/building'
require_relative 'dsp_blueprint_parser/binary_reader'
require_relative 'dsp_blueprint_parser/parser'
require_relative 'dsp_blueprint_parser/building_parser'
require_relative 'dsp_blueprint_parser/data_sections'

BLUEPRINT_TYPE = /(BLUEPRINT|DYBP):/

# module to receive a Dyson Sphere Program blueprint string and parse it
module DspBlueprintParser
  class Error < StandardError; end

  # @param str_blueprint [String]
  # @return [BlueprintData]
  def self.parse(str_blueprint)
    return if str_blueprint.size < 28
    return unless str_blueprint.start_with? BLUEPRINT_TYPE

    parser = Parser.new(str_blueprint)
    parser.blueprint
  end

  # @param input [String]
  # @return [Boolean]
  def self.is_valid?(input)
    return false if input.size < 28
    return false unless input.start_with? BLUEPRINT_TYPE

    sections = DataSections.new(input)
    hash = MD5F::compute(sections.hashed_string)

    return sections.hash == hash
  end
end
