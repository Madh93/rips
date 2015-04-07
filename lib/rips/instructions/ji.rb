require "rips/instructions/instruction"

module Rips
  module Instructions

    class Ji < Instruction

      attr_reader :variables, :length

      # @variables: types of instruction's variables
      # @length: length in bits for each variable
      def initialize
        super("ji",Formats::BFormat.new(0b011000))
        @variables = [Variables::Inmediate.new(10)]
        @length = {r1:10, op:6}
      end
    end
  end  
end