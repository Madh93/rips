require "rips/error"

module Rips
  module Utils
    module StringAssemblerExtension

      # Delete spaces and tabs
      def del(regexp)
        gsub(regexp,'')
      end

      # Delete spaces and tabs
      def del!(regexp)
        gsub!(regexp,'')
      end

      # Return integer part of arguments of an instruction
      def arg_to_i
        (/\A[-]?\d+\z/ === self) ? self.to_i : self.slice(1..-1).to_i
      end

      # Check if string is a comment
      def comment?
        self[0] == "#"
      end

      # Check if string is a label
      def label?(line)
        if (!self.empty?) && (self[0] != "#") && (self[-1] == ":")
          label = self.scan(/\w+:/)
          if (label.size == 1)
            return true
          elsif (label.size > 1)
            Error::message(8, line+1, self) 
          end
        end
      end

      # Check if string is a instruction
      def instruction?
        (!self.empty?) && (self[0] != "#") && (self.scan(/\w+:/).empty?)
      end

 
    end
  end
end