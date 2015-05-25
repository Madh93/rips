require "rips/instructions"

class String
  include Rips::Utils::StringAssemblerExtension
end

class Array
  include Rips::Utils::ArrayExtension
end

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

    private

    # Store number line for each instruction
    def find_instructions
      @input.each_with_index do |line,i|
        if line.instruction?
          @instructions << i+1
        end
      end
    end

    # Store labels and number line 
    def find_labels
      @input.each_with_index do |line, i|
        if line.label?(i)
          label = line.split(":")[0]
          if !@labels.include?(label)
            @labels[label] = [*@instructions.each_with_index].search{|x, _| x >= i}.last
          else
            Error::message(7, i+1, line) 
          end
        end
      end
    end

    # Split on tokens
    def parse_input (line)

      if line.comment?
        @cmd[:comments] = line
      else
        @cmd[:name] = line.instruction_name
        if (@cmd[:name] == "jr ") || (@cmd[:name] == "nop ")
          @cmd[:arguments] = []
        else
          @cmd[:arguments] = line.instruction_arguments(@cmd[:name])
        end
        @cmd[:comments] = line.instruction_comments
        @cmd[:comments].insert(0,"#") if !@cmd[:comments].empty?
      end
    end

    # Obtain instruction's instance object
    def get_instruction
      Rips::Instructions.const_get("#{@cmd[:name].capitalize}").new
    end

    # Exists instruction in Instruction Set?
    def exists_instruction?
      if Instructions::SET.include? (@cmd[:name])
        @instruction = get_instruction
      else
        Error::message(4, @line, @cmd[:name] )
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
    
    # Check number of arguments given with expected by instruction
    def argument_size?  
      if @cmd[:arguments].size != @instruction.args_number
        Error::message( 5, 
                        @line, 
                        @cmd[:name], 
                        @cmd[:arguments].size, 
                        @instruction.args_number )
      end
    end

    # Check if arguments are the same variable type of instruction
    def argument_syntax?
      @instruction.variables.each_with_index do |var,i|
        if var.valid_syntax? @cmd[:arguments][i]
          @cmd[:arguments][i] = @cmd[:arguments][i].arg_to_i
        else
          Error::message(6, @line, var.error(@cmd[:arguments][i]) )     
        end
      end
    end

    # Codification log of instruction
    def show (i)
      puts  "@#{@line}:" \
            "\t#{@output[i].scan(/.{4}|.+/).join("_") unless @instruction.nil?}" \
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

    public

    # Stores each new line of file
    def << (value)
      @input << value.strip
    end

    # Analyze and translate each instruction
    def run

      find_instructions
      find_labels

      @input.each do |line|
        if (line.instruction?) || (line.comment?)
          parse_input(line)
          @instruction = nil
          # If it's a comment -> show but not work with it
          if line.instruction?
            
            exists_instruction?
            parse_label
            argument_size?
            argument_syntax?

            @instruction.set_arguments(@cmd[:arguments])
            @output << @instruction.code
          end
          show(@output.size-1) if @debug
        end
        @line += 1
      end
      
      generate
    end
  end
end