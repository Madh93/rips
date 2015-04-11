require "rips/variables/variable"

module Rips
  module Variables

    class Inmediate < Variable 

      attr_reader :syntax

      # @syntax: example syntax
      # @range: bit's range for variable
      def initialize(size = 8)
        super(size)
        @range = [-2**(@length-1), 2**(@length-1)-1]
        @syntax = "#{@range[0]}..{@range[1]}"
      end

      # Check input variable syntax
      def syntax? (value)

        # It should be between syntax range
        if number?(value) && between?(value, @range)
          true
        else
          false
        end
      end
      
    end
  end
end