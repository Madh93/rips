require "rips/instructions/instruction"

module Rips
  module Instructions

    class Sesm < Instruction

      attr_reader :variables, :length

      # @variables: types of instruction's variables
      # @length: length in bits for each variable
      def initialize
        super("sesm",Formats::CFormat.new(0b1110))
        @variables = [Variables::Port.new, Variables::Inmediate.new]
        @length = {r2:2, r1:8, op:4, blank:2}
      end
    end
  end  
end