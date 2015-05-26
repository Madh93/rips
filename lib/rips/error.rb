module Rips
  module Error

    MESSAGES = 
      [ "RIPS ERROR (0). Unknown problem.",
        "RIPS ERROR (1). Invalid input file (try `rips file.rips`).",
        "RIPS ERROR (2). Doesn't exist file or directory.",
        "RIPS ERROR (3). Permission denied to read file.",
        "RIPS ERROR (4). In line %d: doesn't exist `%s` instruction in Instruction Set.",
        "RIPS ERROR (5). In line %d: for `%s` instruction wrong number of arguments (%d for %d).",
        "RIPS ERROR (6). In line %d: syntax error, %s.",
        "RIPS ERROR (7). In line %d: There is already a label called `%s`.",
        "RIPS ERROR (8). In line %d: Unknown syntax for label `%s` (try `labelname:`).",
        "RIPS ERROR (9). Invalid output file." ]

    def self.message (num, *args)
      puts MESSAGES[num] % args
      exit
    end
  end
end