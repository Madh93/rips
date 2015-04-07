require "rips/instructions/instruction"

module Rips
  module Instructions

    class Li < Instruction

      attr_reader :variables, :length

      # @variables: types of instruction's variables
      # @length: length in bits for each variable
      def initialize
        super("li",Formats::CFormat.new(0b1010))
        @variables = [Variables::Register.new, Variables::Inmediate.new]
        @length = {r2:4, r1:8, op:4}
      end
    end
  end  
end