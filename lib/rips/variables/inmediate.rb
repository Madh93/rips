require "rips/variables/variable"

module Rips
  module Variables

    class Inmediate < Variable 

      attr_reader :syntax

      # @syntax: example syntax
      def initialize
        super(8)
        @syntax = "-128...127"
      end

      # Check input variable syntax
      def syntax? (value)

        if !number? (value)
          return false
        end      

        value = value.to_i

        # It should be between syntax range
        if !value.to_i.between?(-2**(@length-1),2**(@length-1)-1)
          return false
        else
          return true
        end        
      end
      
    end
  end
end