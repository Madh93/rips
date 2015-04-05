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
      end
    end
  end
end