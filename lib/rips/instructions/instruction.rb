require "rips/instructions/set"

module Rips
  module Instructions

    class Instruction

      # @name: mnemonic name
      # @type: instruction format
      def initialize (name, type)
        @name,@type = name,type
      end
    end
  end  
end