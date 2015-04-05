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
      end
    end
  end
end