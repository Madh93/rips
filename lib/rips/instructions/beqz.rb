require "rips/instructions/instruction"

module Rips
  module Instructions

    class Beqz < Instruction

      attr_reader :variables, :length

      # @variables: types of instruction's variables
      # @length: length in bits for each variable
      def initialize
        super("beqz",Formats::BFormat.new(0b011111))
        @variables = [Variables::Address.new]
        @length = {r1:10, op:6}
      end
    end
  end  
end