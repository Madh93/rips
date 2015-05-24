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
        @syntax = "#{@range[0]}..#{@range[1]}"
      end

      # Check input variable syntax
      def valid_syntax? (value)
        value.extend(Rips::Utils::StringVariableExtension)
        value.inmediate? && value.valid_range?(@range)
      end
      
    end
  end
end