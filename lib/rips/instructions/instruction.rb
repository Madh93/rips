require "rips/instructions/set"
require "rips/formats"
require "rips/variables"

module Rips
  module Instructions

    class Instruction

      # @name: mnemonic name
      # @type: instruction format
      def initialize (name, type)
        @name,@type = name,type
      end

      # Return number of arguments
      def args_number
        @type.args_number
      end      
    end
  end  
end