module Rips
  module Utils
    module IntegerExtension

      def to_bin(width)
        if self < 0
          '%0*b' % [width, (2**width-1) - ~self]
        else
          '%0*b' % [width, self]
        end
      end
    
    end
  end
end