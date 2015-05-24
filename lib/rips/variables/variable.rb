require "rips/utils"

module Rips
  module Variables

    class Variable 

      attr_reader :length

      # @length = max length of bits
      def initialize (length)
        @length = length
      end

      # Return error message about incorrent syntax
      def error (value)
        "unexpected `#{value}` (expected a `#{self.class.to_s.split(':').last}` argument like `#{@syntax}`)"
      end

    end
  end
end