require "rips/instructions"

module Rips
  class Assembler
    
    # @debug: switch to show trace in console
    # @input: array with assembly instructions
    # @output: array with coded instructions
    # @cmd: line split on tokens (name + arguments)
    # @instruction: instruction instance
    # @instructions: array with line for each instruction
    # @labels: name and number line of label
    # @line: number of file's line
    def initialize (debug)
      @debug = debug
      @input = []
      @output = []
      @cmd = {}
      @instruction
      @instructions = [] 
      @labels = {}
      @line = 1  
    end

    # Store labels and number line 
    def find_labels

      @input.each_with_index do |line, i|
        if (!line.empty?) && (line[0] != "#")
          label = line.scan(/\w+:/)
          if (label.size == 1) && (line[-1] == ":")

            if !@labels.include?(label.to_s.split(":").first)
              if RUBY_VERSION >= "2"
                @labels[label.to_s.split(":").first] = [*@instructions.each_with_index].bsearch{|x, _| x >= i}.last
              else
                @labels[label.to_s.split(":").first] = [*@instructions.each_with_index].find{|x, _| x >= i}.last
              end
            else
              Error::message(7, i+1, label.to_s.split(":").first) 
            end

          elsif ((label.size > 1) || (line[-1] != ":") && (!@instructions.include?(i+1)))
            Error::message(8, i+1, line) 
          end
        end
      end
    end

    # Store number line for each instruction
    def find_instructions

      @input.each_with_index do |line,i|
        if (!line.empty?) && (line.scan(/\w+:/).empty?) && (line[0] != "#")
          @instructions << i+1
        end
      end
    end

    # Stores each new line of file
    def << (value)
      @input << value.strip
    end

    # Analyze and translate each instruction
    def run

      find_instructions
      find_labels

      @input.each do |line|

        # If line is empty -> next line
        # Or if not is a label
        if (!line.empty?) && (line.scan(/\w+:/).empty?)

          parse_input(line)
          @instruction = nil

          # If it's a comment -> show but not work with it
          if line[0] != "#"

            exists_instruction
            @instruction = get_instruction

            parse_label
            
            argument_size
            argument_syntax

            @instruction.set_arguments(@cmd[:arguments])
            @output << @instruction.code
          end
          show if @debug
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
        @cmd[:name] = line.split("#").first.split(" ").first.downcase
        @cmd[:arguments] = line.split("#").first.split("#{@cmd[:name]} ")
        if !@cmd[:arguments].empty?
          @cmd[:arguments] = @cmd[:arguments].pop.split("#").first.del(/\s+|\t+/).split(",")
        end
        if @cmd[:arguments].first == "jr" ||
           @cmd[:arguments].first == "nop"
           @cmd[:arguments] = []
        end
        @cmd[:comments] = line.split("#").slice(1..-1).join
        @cmd[:comments].insert(0,"#") if !@cmd[:comments].empty?
      end
    end

    # Translate label's name to instruction's number
    def parse_label
      if (@instruction.is_a? Rips::Instructions::Beqz) ||
         (@instruction.is_a? Rips::Instructions::Bnez) ||
         (@instruction.is_a? Rips::Instructions::J) ||
         (@instruction.is_a? Rips::Instructions::Jal)

          @cmd[:arguments] = [@labels[@cmd[:arguments].first].to_s]
      end
    end

    # Obtain instruction's instance object
    def get_instruction
      Rips::Instructions.const_get("#{@cmd[:name].capitalize}").new
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