require "rips/variables/variable"

module Rips
  module Variables
 
    class Address < Variable 

      attr_reader :syntax

      # @syntax: example syntax
      # @range: bit's range for variable
      def initialize(size = 10)
        super(size)
        @range = [0, 2**@length-1]
        @syntax = "#{@range[0]}..#{@range[1]} | label"
      end

      # Check input variable syntax
      def valid_syntax? (value)

        if (number?(value)) && (between?(value, @range))
          true
        elsif value.is_a?(String)
          true
        else
          false
        end
      end
    end
  end
end