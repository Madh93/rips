module Rips
  module Utils
    module StringVariableExtension

      # Check if value is a valid number (...,-1,0,1...)
      def number? (value)
        /\A[-]?\d+\z/ === value
      end

      # Check if value is between in permitted range
      def valid_range? (range)
        if number?(self.slice(1..-1))
          self.to_i.between?(range[0], range[1])
        else 
          self.slice(1..-1).to_i.between?(range[0], range[1])
        end
      end      

      # Check if value is a valid inmediate (...,-1,0,1...)
      def inmediate?
        number?(self)
      end      

      # Check if value is a register ($0..15)
      def register?
        (self[0] == "$") && number?(self.slice(1..-1))
      end

      # Check if value is a port (@0..3)
      def port?
        (self[0] == "@") && number?(self.slice(1..-1))
      end 

      # Check if value is an address (0..127 | label)
      def address? (range)
        (self.is_a?(String)) || (number?(self.slice(1..-1)) && valid_range?(range))
      end
      
    end
  end
end