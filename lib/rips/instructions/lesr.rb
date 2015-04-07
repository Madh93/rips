require "rips/instructions/instruction"

module Rips
  module Instructions

    class Lesr < Instruction

      attr_reader :variables, :length

      # @variables: types of instruction's variables
      # @length: length in bits for each variable
      def initialize
        super("lesr",Formats::CFormat.new(0b1011))
        @variables = [Variables::Register.new, Variables::Port.new]
        @length = {r2:4, r1:2, op:4, blank:6}
      end
    end
  end  
end