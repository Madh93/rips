require "rips/instructions/instruction"

module Rips
  module Instructions

    class Lest < Instruction

      attr_reader :variables, :length

      # @variables: types of instruction's variables
      # @length: length in bits for each variable
      def initialize
        super("lest",Formats::DFormat.new(0b0111))
        @variables = [Variables::Register.new, Variables::Register.new, Variables::Register.new]
        @length = {r3:4, r2:4, r1:4, op:4}
      end
    end
  end  
end