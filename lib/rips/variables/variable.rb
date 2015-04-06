module Rips
  module Variables

    class Variable 

      attr_reader :length

      # @length = max length of bits
      def initialize (length)
        @length = length
      end

      # Check if value is a register ($0..15)
      def register? (value)
        (value[0] == "$") && number?(value.slice(1..-1))
      end

      # Check if value is a port (@0..3)
      def port? (value)
        (value[0] == "@") && number?(value.slice(1..-1))
      end      

      # Check if value is a valid number (...,-1,0,1...)
      def number? (value)
        /\A[-]?\d+\z/ === value
      end

      # Check if value is between in permitted range
      def between? (value, range)
        to_i(value).between?(range[0], range[1])
      end      

      # Return integer part of value
      def to_i (value)
        number?(value) ? value.to_i : value.slice(1..-1).to_i
      end

      # Return error message about incorrent syntax
      def error (value)
        "unexpected `#{value}` (expected a `#{self.class.to_s.split(':').last}` argument like `#{@syntax}`)"
      end      
    end
  end
end