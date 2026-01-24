# frozen_string_literal: true

module DspBlueprintParser
  # data class for parsed blueprint
  class BlueprintData
    def initialize
      @areas = []
      @buildings = []
    end

    # @return [DateTime]
    attr_accessor :time

    # @return [String]
    attr_accessor :game_version

    # @return [String]
    attr_accessor :short_description

    # @return [String]
    attr_accessor :description

    # Integer is a const value from IconLayout
    # @return [Integer]
    attr_accessor :icon_layout

    # @return [Integer]
    attr_accessor :icon0

    # @return [Integer]
    attr_accessor :icon1

    # @return [Integer]
    attr_accessor :icon2

    # @return [Integer]
    attr_accessor :icon3

    # @return [Integer]
    attr_accessor :icon4

    # @return [Integer]
    attr_accessor :cursor_offset_x

    # @return [Integer]
    attr_accessor :cursor_offset_y

    # @return [Integer]
    attr_accessor :cursor_target_area

    # @return [Integer]
    attr_accessor :drag_box_size_x

    # @return [Integer]
    attr_accessor :drag_box_size_y

    # @return [Integer]
    attr_accessor :primary_area_idx

    # @return [Array<Area>]
    attr_accessor :areas

    # @return [Array<Building>]
    attr_accessor :buildings

    # @return [Integer]
    attr_accessor :version

    # @return [String, nil]
    attr_accessor :custom_version

    # @return [String, nil]
    attr_accessor :author

    # @return [Array<String>, nil]
    attr_accessor :attributes
  end
end
