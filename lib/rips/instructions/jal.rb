require "rips/instructions/instruction"

module Rips
  module Instructions

    class Jal < Instruction

      attr_reader :variables, :length

      # @variables: types of instruction's variables
      # @length: length in bits for each variable
      def initialize
        super("jal",Formats::BFormat.new(0b101000))
        @variables = [Variables::Address.new]
        @length = {r1:10, op:6}
      end
    end
  end  
end