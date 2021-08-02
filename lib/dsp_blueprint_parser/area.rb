module DspBlueprintParser
    class Area
        # @return [Integer]
        attr_accessor :index

        # @return [Integer]
        attr_accessor :parent_index
        
        # @return [Integer]
        attr_accessor :tropic_anchor
        
        # @return [Integer]
        attr_accessor :area_segments
        
        # @return [Integer]
        attr_accessor :anchor_local_offset_x
        
        # @return [Integer]
        attr_accessor :anchor_local_offset_y
        
        # @return [Integer]
        attr_accessor :width
        
        # @return [Integer]
        attr_accessor :height
    end
end