require "rips/variables/variable"

module Rips
  module Variables
 
    class Address < Variable 

      attr_reader :syntax

      # @syntax: example syntax
      # @range: bit's range for variable
      def initialize
        super(10)
        @syntax = "0..1023"
        @range = [0, 2**@length-1]
      end

      # Check input variable syntax
      def syntax? (value)

        if !number?(value)
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