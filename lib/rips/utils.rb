module Rasm

  class Integer
    def to_bin(width)
      num = '%0*b' % [width, self]
      num.gsub('.','1')
    end
  end

end