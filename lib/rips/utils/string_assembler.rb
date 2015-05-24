module Rips
  module Utils
    module StringAssemblerExtension

      def del(regexp)
        gsub(regexp,'')
      end

      def del!(regexp)
        gsub!(regexp,'')
      end

      def saludo
        puts "hola"
      end

      # Return integer part of arguments of an instruction
      def arg_to_i
        (/\A[-]?\d+\z/ === self) ? self.to_i : self.slice(1..-1).to_i
      end




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
    end
  end
end