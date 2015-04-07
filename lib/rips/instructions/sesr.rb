require "rips/instructions/instruction"

module Rips
  module Instructions

    class Sesr < Instruction

      attr_reader :variables, :length

      # @variables: types of instruction's variables
      # @length: length in bits for each variable
      def initialize
        super("sesr",Formats::CFormat.new(0b1101))
        @variables = [Variables::Port.new, Variables::Register.new]
        @length = {r2:2, r1:4, op:4, blank:6}
      end
    end
  end  
end