require "rips/instructions/set"
require "rips/formats"
require "rips/variables"
require "rips/utils"
    
class Integer
  include Rips::Utils::IntegerExtension
end

module Rips
  module Instructions

    class Instruction

      # @name: mnemonic name
      # @format: instruction format
      # @output: array with coded instruction
      def initialize (name, format)
        @name,@format = name,format
        @opcode = format.opcode
        @output = []
      end

      private

      # Add blanks (0 values) for instructions with free space
      def add_blank
        if @variables.empty?
          @output.push(0.to_bin(@length[:blank]))
        elsif @variables.size == 1
          @output.insert(-2,0.to_bin(@length[:blank]))
        else
          @output.insert(-@variables.size,0.to_bin(@length[:blank]))
        end
      end

      public

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

        # Add opcode
        @output = [@opcode.to_bin(@length[:op])]

        # Add arguments
        @format.args.each do |key,value|
          @output << value.to_bin(@length[key])
        end

        # Add blanks
        if (@length.key? :blank)
          add_blank
        end

        @output.reverse.join.to_s
      end      

    end
  end  
end