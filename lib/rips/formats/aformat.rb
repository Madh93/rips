require "rips/formats/format"  

module Rips
  module Formats

    class AFormat < Format
      
      attr_reader :args
      
      # @args: all instruction's arguments
      def initialize (opcode)
        super(opcode,0)
        @args = {}
      end
      
    end
  end
end