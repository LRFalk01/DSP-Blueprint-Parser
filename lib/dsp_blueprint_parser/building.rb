module DspBlueprintParser
    class Building
        def initialize
            @parameters = Array.new
        end

        # @return [Integer]
        attr_accessor :index

        # @return [Integer]
        attr_accessor :area_index
        
        # @return [Float]
        attr_accessor :local_offset_x
        
        # @return [Float]
        attr_accessor :local_offset_y
        
        # @return [Float]
        attr_accessor :local_offset_z
        
        # @return [Float]
        attr_accessor :local_offset_x2
        
        # @return [Float]
        attr_accessor :local_offset_y2
        
        # @return [Float]
        attr_accessor :local_offset_z2
        
        # @return [Float]
        attr_accessor :yaw
        
        # @return [Float]
        attr_accessor :yaw2
        
        # @return [Integer]
        attr_accessor :item_id
        
        # @return [Integer]
        attr_accessor :model_index
        
        # @return [Integer]
        attr_accessor :temp_output_obj_idx
        
        # @return [Integer]
        attr_accessor :temp_input_obj_idx
        
        # @return [Integer]
        attr_accessor :output_to_slot
        
        # @return [Integer]
        attr_accessor :input_from_slot
        
        # @return [Integer]
        attr_accessor :output_from_slot
        
        # @return [Integer]
        attr_accessor :input_to_slot
        
        # @return [Integer]
        attr_accessor :output_offset
        
        # @return [Integer]
        attr_accessor :input_offset
        
        # @return [Integer]
        attr_accessor :recipe_id
        
        # @return [Integer]
        attr_accessor :filter_fd
        
        # @return [Array<Integer>]
        attr_accessor :parameters
    end
end