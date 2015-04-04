module Rips
  module Error

    MESSAGES = 
      [ "RIPS ERROR (0). Unknown problem.",
        "RIPS ERROR (1). No input file (try `rips file.rips`).",
        "RIPS ERROR (2). Doesn't exist file or directory.",
        "RIPS ERROR (3). Permission denied to read file." ]

    def self.message (num, *args)
      puts MESSAGES[num] % args
      exit
    end
  end
end