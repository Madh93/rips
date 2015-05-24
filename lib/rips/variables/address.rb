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
        value.extend(Rips::Utils::StringVariableExtension)
        value.address?(@range)
      end
      
    end
  end
end