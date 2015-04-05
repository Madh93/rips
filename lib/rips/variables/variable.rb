module Rips
  module Variables

    class Variable 

      attr_reader :length

      # @length = max length of bits
      def initialize (length)
        @length = length
      end
    end
  end
end