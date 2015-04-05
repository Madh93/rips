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

        output = [@opcode.to_bin(@opcode.size)]

        @format.args.each do |key,value|
          output << value.to_bin(@length[key])
        end

        output.insert(-2,@length[:blank]) if (@length.key? :blank)

        output.reverse.join.to_s
      end      

    end
  end  
end