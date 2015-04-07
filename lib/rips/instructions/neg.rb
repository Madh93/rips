require "rips/instructions/instruction"

module Rips
  module Instructions

    class Neg < Instruction

      attr_reader :variables, :length

      # @variables: types of instruction's variables
      # @length: length in bits for each variable
      def initialize
        super("neg",Formats::CFormat.new(0b0110))
        @variables = [Variables::Register.new, Variables::Register.new]
        @length = {r2:4, r1:4, op:4, blank:4}
      end
    end
  end  
end