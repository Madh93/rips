require "rips/variables/variable"

module Rips
  module Variables

    class Register < Variable 

      attr_reader :syntax

      # @syntax: example syntax
      def initialize
        super(4)
        @syntax = "$0-15"
      end

      # Check input variable syntax
      def syntax? (value)

          if !register? (value)
            return false
          end

          # Get integer part
          value = value.split('$',2).last

          # If contains more "$"
          if value.include? "$"
            return false
          # It should have only 1 or 2 digits
          elsif !value.size.between?(1,2) 
            return false
          # If it have 2 digits, first digit doesn't be zero or negative
          elsif (value.size == 2) && (!value[0].match(/-|0/).nil?)
            return false
          # It should be between syntax range
          elsif !value.to_i.between?(0, 2**@length-1)
            return false
          else
            return true
          end        
      end
      
    end
  end
end