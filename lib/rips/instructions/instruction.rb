require "rips/instructions/set"
require "rips/formats"
require "rips/variables"

module Rips
  module Instructions

    class Instruction

      # @name: mnemonic name
      # @format: instruction format
      def initialize (name, format)
        @name,@format = name,format
        @opcode = format.opcode
      end

      # Return number of arguments
      def args_number
        @format.args_number
      end      

      # Pass all arguments at once
      def set_arguments (args)
        @format.set_arguments(args)
      end

      # Coding to Machine Code
      def code
      end      

    end
  end  
end