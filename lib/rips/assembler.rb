module Rips
  class Assembler
    
    # @input: array with assembly instructions
    # @output: array with coded instructions
    # @cmd: line split on tokens (name + arguments)
    # @instruction: instruction instance
    # @line: number of file's line
    def initialize
      @input = []
      @output = []
      @cmd
      @instruction
      @line = 1      
    end

    # Stores each new line of file
    def << (value)
      @input << value.strip
    end

    # Analyze and translate each instruction
    def run
    end

    # Codification log of instruction
    def show
    end

    # Generate output in "progfile.dat"
    def generate
    end    

  end
end