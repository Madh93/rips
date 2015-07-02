require "rips/instructions/instruction"

module Rips
  module Instructions

    class Print < Instruction

      attr_reader :variables, :length

      # @variables: types of instruction's variables
      # @length: length in bits for each variable
      def initialize
        super("print",Formats::BFormat.new(0b1100))
        @variables = [Variables::Register.new]
        @length = {r1:4, op:4, blank:8}
      end
    end
  end  
end