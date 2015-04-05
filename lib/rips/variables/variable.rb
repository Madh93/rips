module Rips
  module Variables

    class Variable 

      attr_reader :length

      # @length = max length of bits
      def initialize (length)
        @length = length
      end

      # Check if value is a register ($?)
      def register? (value)
        value[0] == "$"
      end

      # Check if value is a valid number (...,-1,0,1...)
      def number? (value)
        /\A[-]?\d+\z/ === value
      end

      # Return integer part of value
      def to_i (value)
        value.split('$',2).last.to_i
      end

      # Return error message about incorrent syntax
      def error (value)
        "unexpected `#{value}` (expected a `#{self.class.to_s.split(':').last}` argument like `#{@syntax}`)"
      end      
    end
  end
end