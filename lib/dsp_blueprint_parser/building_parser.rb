# frozen_string_literal: true

module DspBlueprintParser
  # class to orchestrate building parsing
  class BuildingParser
    class << self
      # @param [BlueprintData] blueprint
      # @param [BinaryReader] reader
      # @return [void]
      def process!(blueprint, reader)
        reader.read_i32.times do
          path_num = reader.read_i32
          building = if path_num <= -102
            path_102(reader)
          elsif path_num <= -101
            path_101(reader)
          elsif path_num <= -100
            path_100(reader)
          else
            path_default(reader, path_num)
          end

          blueprint.buildings << building
        end
      end

      private

      # @param [BinaryReader] reader
      # @return [Building]
      def path_102(reader)
        building = Building.new
        building.index = reader.read_i32
        building.item_id = reader.read_i16
        building.model_index = reader.read_i16
        building.area_index = reader.read_i8
        building.local_offset_x = reader.read_single
        building.local_offset_y = reader.read_single
        building.local_offset_z = reader.read_single
        building.yaw = reader.read_single

        if building.item_id > 2000 && building.item_id < 2010
          building.tilt = reader.read_single
          building.pitch = 0.0
          building.local_offset_x2 = building.local_offset_x
          building.local_offset_y2 = building.local_offset_y
          building.local_offset_z2 = building.local_offset_z
          building.yaw2 = building.yaw
          building.tilt2 = building.tilt
          building.pitch2 = 0.0
        elsif building.item_id > 2010 && building.item_id <  2020
          building.tilt = reader.read_single
          building.pitch = reader.read_single
          building.local_offset_x2 = reader.read_single
          building.local_offset_y2 = reader.read_single
          building.local_offset_z2 = reader.read_single
          building.yaw2 = reader.read_single
          building.tilt2 = reader.read_single
          building.pitch2 = reader.read_single
        else
          building.tilt = 0.0
          building.pitch = 0.0
          building.local_offset_x2 = building.local_offset_x
          building.local_offset_y2 = building.local_offset_y
          building.local_offset_z2 = building.local_offset_z
          building.yaw2 = building.yaw
          building.tilt2 = 0.0
          building.pitch2 = 0.0
        end

        building.temp_output_obj_idx = reader.read_i32
        building.temp_input_obj_idx = reader.read_i32
        building.output_to_slot = reader.read_i8
        building.input_from_slot = reader.read_i8
        building.output_from_slot = reader.read_i8
        building.input_to_slot = reader.read_i8
        building.output_offset = reader.read_i8
        building.input_offset = reader.read_i8
        building.recipe_id = reader.read_i16
        building.filter_fd = reader.read_i16

        reader.read_i16.times do
          building.parameters << reader.read_i32
        end

        building
      end

      # @param [BinaryReader] reader
      # @return [Building]
      def path_101(reader)
        building = Building.new
        building.index = reader.read_i32
        building.item_id = reader.read_i16
        building.model_index = reader.read_i16
        building.area_index = reader.read_i8
        building.local_offset_x = reader.read_single
        building.local_offset_y = reader.read_single
        building.local_offset_z = reader.read_single
        building.yaw = reader.read_single

        if building.item_id > 2000 && building.item_id < 2010
          building.tilt = reader.read_single
          building.pitch = 0.0
          building.local_offset_x2 = building.local_offset_x
          building.local_offset_y2 = building.local_offset_y
          building.local_offset_z2 = building.local_offset_z
          building.yaw2 = building.yaw
          building.tilt2 = building.tilt
          building.pitch2 = 0.0
        elsif building.item_id > 2010 && building.item_id < 2020
          building.tilt = reader.read_single
          building.pitch = reader.read_single
          building.local_offset_x2 = reader.read_single
          building.local_offset_y2 = reader.read_single
          building.local_offset_z2 = reader.read_single
          building.yaw2 = reader.read_single
          building.tilt2 = reader.read_single
          building.pitch2 = reader.read_single
        else
          building.tilt = 0.0
          building.pitch = 0.0
          building.local_offset_x2 = building.local_offset_x
          building.local_offset_y2 = building.local_offset_y
          building.local_offset_z2 = building.local_offset_z
          building.yaw2 = building.yaw
          building.tilt2 = 0.0
          building.pitch2 = 0.0
        end

        building.temp_output_obj_idx = reader.read_i32
        building.temp_input_obj_idx = reader.read_i32
        building.output_to_slot = reader.read_i8
        building.input_from_slot = reader.read_i8
        building.output_from_slot = reader.read_i8
        building.input_to_slot = reader.read_i8
        building.output_offset = reader.read_i8
        building.input_offset = reader.read_i8
        building.recipe_id = reader.read_i16
        building.filter_fd = reader.read_i16

        reader.read_i16.times do
          building.parameters << reader.read_i32
        end

        building
      end

      # @param [BinaryReader] reader
      # @return [Building]
      def path_100(reader)
        building = Building.new
        building.index = reader.read_i32
        building.area_index = reader.read_i8
        building.local_offset_x = reader.read_single
        building.local_offset_y = reader.read_single
        building.local_offset_z = reader.read_single
        building.local_offset_x2 = reader.read_single
        building.local_offset_y2 = reader.read_single
        building.local_offset_z2 = reader.read_single
        building.pitch = 0.0
        building.pitch2 = 0.0
        building.yaw = reader.read_single
        building.yaw2 = reader.read_single
        building.tilt = reader.read_single
        building.tilt2 = 0.0
        building.item_id = reader.read_i16
        building.model_index = reader.read_i16
        building.temp_output_obj_idx = reader.read_i32
        building.temp_input_obj_idx = reader.read_i32
        building.output_to_slot = reader.read_i8
        building.input_from_slot = reader.read_i8
        building.output_from_slot = reader.read_i8
        building.input_to_slot = reader.read_i8
        building.output_offset = reader.read_i8
        building.input_offset = reader.read_i8
        building.recipe_id = reader.read_i16
        building.filter_fd = reader.read_i16

        reader.read_i16.times do
          building.parameters << reader.read_i32
        end
        
        building
      end

      # @param [BinaryReader] reader
      # @param [Integer] index
      # @return [Building]
      def path_default(reader, index)
        building = Building.new
        building.index = index
        building.area_index = reader.read_i8
        building.local_offset_x = reader.read_single
        building.local_offset_y = reader.read_single
        building.local_offset_z = reader.read_single
        building.local_offset_x2 = reader.read_single
        building.local_offset_y2 = reader.read_single
        building.local_offset_z2 = reader.read_single
        building.pitch = 0.0
        building.pitch2 = 0.0
        building.yaw = reader.read_single
        building.yaw2 = reader.read_single
        building.tilt = 0.0
        building.tilt2 = 0.0
        building.item_id = reader.read_i16
        building.model_index = reader.read_i16
        building.temp_output_obj_idx = reader.read_i32
        building.temp_input_obj_idx = reader.read_i32
        building.output_to_slot = reader.read_i8
        building.input_from_slot = reader.read_i8
        building.output_from_slot = reader.read_i8
        building.input_to_slot = reader.read_i8
        building.output_offset = reader.read_i8
        building.input_offset = reader.read_i8
        building.recipe_id = reader.read_i16
        building.filter_fd = reader.read_i16

        reader.read_i16.times do
          building.parameters << reader.read_i32
        end
        
        building
      end
    end
  end
end
