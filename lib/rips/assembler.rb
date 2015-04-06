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
      @cmd = {}
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

        # If line is empty -> next line
        if !line.empty?

          parse_input(line)
          @instruction = nil

          # If it's a comment -> show but not work with it
          if line[0] != "#"

            exists_instruction
            @instruction = get_instruction
            
            argument_size
            argument_syntax

            @instruction.set_arguments(@cmd[:arguments])
            @output << @instruction.code
          end
          show
        end        
        @line += 1
      end
      
      generate
    end

    # Codification log of instruction
    def show

      # If line was a comment -> @instruction should be nil
      if @instruction.nil?
        codification = ""
      else
        codification = @instruction.code.scan(/.{4}|.+/).join("_")
      end

      puts  "@#{@line}:" \
            "\t#{codification}" \
            "\t#{@cmd[:comments]}"
    end

    # Generate output in "progfile.dat"
    def generate
      File.open("progfile.dat", "w") do |f|
        @output.each do |line|
          f.puts line
        end
      end        
    end        

    # Split on tokens
    def parse_input (line)

      if line[0] == "#"
        @cmd[:comments] = line
      else
        @cmd[:name] = line.split("#").first.split(" ").first
        @cmd[:arguments] = line.split("#").first.split(@cmd[:name])
        if !@cmd[:arguments].empty?
          @cmd[:arguments] = @cmd[:arguments].pop.split("#").first.delete(" ").split(",")
        end
        @cmd[:comments] = line.split("#").slice(1..-1).join
        @cmd[:comments].insert(0,"#") if !@cmd[:comments].empty?
      end

    end

    # Obtain instruction's instance object
    def get_instruction
      Object.const_get("Rips::Instructions::#{@cmd[:name].capitalize}").new
    end

    # Exists instruction in Instruction Set?
    def exists_instruction
      if !Instructions::SET.include? (@cmd[:name])
        Error::message( 4, 
                        @line, 
                        @cmd[:name] )
      end
    end

    # Check number of arguments given with expected by instruction
    def argument_size
      if @cmd[:arguments].size != @instruction.args_number
        Error::message( 5, 
                        @line, 
                        @cmd[:name], 
                        @cmd[:arguments].size, 
                        @instruction.args_number )
      end
    end

    # Check if arguments are the same variable type of instruction
    def argument_syntax
      @instruction.variables.each_with_index do |var,i|
        if var.syntax? @cmd[:arguments][i]
          @cmd[:arguments][i] = var.to_i(@cmd[:arguments][i])
        else
          Error::message( 6,
                          @line,
                          var.error(@cmd[:arguments][i]) )     
        end
      end
    end
  end
end