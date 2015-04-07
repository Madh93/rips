require "rips/instructions/instruction"

module Rips
  module Instructions

    class Jr < Instruction

      attr_reader :variables, :length

      # @variables: types of instruction's variables
      # @length: length in bits for each variable
      def initialize
        super("jr",Formats::AFormat.new(0b111000))
        @variables = []
        @length = {op:6, blank:10}
      end
    end
  end  
end