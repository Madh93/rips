require "rips/variables/variable"

module Rips
  module Variables
 
    class Address < Variable 

      attr_reader :syntax

      # @syntax: example syntax
      def initialize
        super(2)
        @syntax = "$0-3"
      end

      # Check input variable syntax
      def syntax? (value)

        if !register? (value)
          return false
        end      

        # Get integer part
        value = value.split('$',2).last        

        if !number? (value)
          return false
        end  

        # It should be between syntax range
        if !value.to_i.between?(0,2**@length-1)
          return false
        else
          return true
        end        
      end
      
    end
  end
end