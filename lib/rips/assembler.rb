require "rips/instructions"

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

      @input.each do |line|

        parse_input(line)
        exists_instruction

        @instruction = get_instruction
        
        argument_size
        argument_syntax

        # @instruction.set_arguments(cmd[:arguments])

        show
        # @output << @instruction.code
        @line += 1
      end
      
      generate
    end

    # Codification log of instruction
    def show
    end

    # Generate output in "progfile.dat"
    def generate
    end        

    # Split on tokens
    def parse_input (line)
      @cmd = {  name: line.split(' ').first.downcase,
                arguments: line.split(' ',2).pop.delete(' ').split(',') }      
    end

    # Obtain instruction's instance object
    def get_instruction
      Object.const_get("Instructions::#{@cmd[:name].capitalize}").new
    end

    # Exists instruction in Instruction Set?
    def exists_instruction
      if !Instruction::SET.include? (@cmd[:name])
        Error::message( 1, 
                        @line, 
                        @cmd[:name] )
      end
    end

    # Check number of arguments given with expected by instruction
    def argument_size
      if @cmd[:arguments].size != @instruction.args_number
        Error::message( 2, 
                        @line, 
                        @cmd[:name], 
                        @cmd[:arguments].size, 
                        @instruction.args_number )
      end
    end

    # Check if arguments are the same variable type of instruction
    def argument_syntax
    end
  end
end