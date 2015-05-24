module Rips
  module Utils
    module StringVariableExtension

      # Check if value is a valid number (...,-1,0,1...)
      def number?
        /\A[-]?\d+\z/ === self
      end      

      # Check if value is a register ($0..15)
      def register?
        (self[0] == "$") && self.slice(1..-1).number?
      end

      # Check if value is a port (@0..3)
      def port?
        (self[0] == "@") && self.slice(1..-1).number?
      end 

    end
  end
end