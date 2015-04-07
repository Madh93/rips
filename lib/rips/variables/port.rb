require "rips/variables/variable"

module Rips
  module Variables
 
    class Port < Variable 

      attr_reader :syntax

      # @syntax: example syntax
      # @range: bit's range for variable
      def initialize(size = 2)
        super(size)
        @syntax = "@0-3"
        @range = [0, 2**@length-1]
        @syntax = "@#{@range[0]}-{@range[1]}"
      end

      # Check input variable syntax
      def syntax? (value)

        if !port?(value)
          return false
        end

        # It should be between syntax range
        if !between?(value, @range)
          return false
        else
          return true
        end         
      end
      
    end
  end
end