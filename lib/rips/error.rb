module Rips
  module Error

    MESSAGES = 
      [ "RASM ERROR (0). Unknown problem." ]

    def self.message (num, *args)
      puts MESSAGES[num] % args
      exit
    end
  end
end