require "rips/version"
require "rips/assembler"
require "rips/error"

module Rips
  class RipsLauncher

    # @argv: input's arguments
    # @debug: switch to show trace in console
    # @source: source file with Rips instructions
    # @output: output file with binary instructions
    def initialize
      @argv = ARGV
      @debug = debug_mode?
      @source = source_file
      @output = output_file

      run
    end

    private

    # Check debug mode 
    def debug_mode?
      @argv.include?("-d") || @argv.include?("--debug")
    end

    # Check if it's a valid input file
    def source_file
      source = @argv.find{|x| /\.input$/ =~ x }  ##### CAMBIIIAAAR POR .RIIIIPPPPSSS
      Error::message(1) if source.nil? 
      Error::message(2) if !File.exist?(source)
      Error::message(3) if !File.readable?(source)
      return source
    end

    # Check cmdline options (now only output)
    def output_file
      if @argv.include?("-o")
        out = @argv[(@argv.index("-o"))+1]  
        Error::message(9) if out.nil? || out == @source || out == "-d" || out == "--debug"
        return out
      else
        return "progfile.dat"
      end
    end

    # Read input file
    def read
      File.open(@source, "r") do |f|
        f.each_line do |line|
          @rips << line
        end
      end
    end

    # Launch Rips assembler
    def run
      @rips = Assembler.new(@debug)
      read
      @rips.run(@output)
    end

  end
end