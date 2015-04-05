module Rips
  module Formats

    class Format

      attr_reader :opcode, :args_number
      
      # @opcode = operation code in binary
      # @args_number = number of format's arguments
      def initialize (opcode, args_number)
        @opcode, @args_number = opcode, args_number
      end
    end
  end
end