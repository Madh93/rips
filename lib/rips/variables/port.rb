require "rips/variables/variable"

module Rips
  module Variables
 
    class Port < Variable 

      attr_reader :syntax

      # @syntax: example syntax
      # @range: bit's range for variable
      def initialize(size = 2)
        super(size)
        @range = [0, 2**@length-1]
        @syntax = "@#{@range[0]}-#{@range[1]}"
      end

      # Check input variable syntax
      def valid_syntax? (value)

        # It should be between syntax range
        if port?(value) && between?(value, @range)
          true
        else
          false
        end       
      end
      
    end
  end
end