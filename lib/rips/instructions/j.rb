require "rips/instructions/instruction"

module Rips
  module Instructions

    class J < Instruction

      attr_reader :variables, :length

      # @variables: types of instruction's variables
      # @length: length in bits for each variable
      def initialize
        super("j",Formats::BFormat.new(0b1001))
        @variables = [Variables::Address.new]
        @length = {r1:10, op:4, blank:2}
      end
    end
  end  
end