require "rips/formats/format"  

module Rips
  module Formats

    class DFormat < Format
      
      attr_reader :args
      
      # @args: all instruction's arguments
      def initialize (opcode)
        super(opcode,3)
        @args = {}
      end
      
      # Pass all arguments at once
      def set_arguments (args)
        @args[:r1], @args[:r2], @args[:r3] = args[2], args[1], args[0]
      end
    end
  end
end