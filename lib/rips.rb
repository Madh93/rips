require "rips/version"
require "rips/assembler"
require "rips/error"

module Rips

  debug=false

  # Check arguments
  if ARGV.include?("-d")
    debug = true
    ARGV.delete("-d")
  elsif ARGV.include?("--debug")
    debug = true
    ARGV.delete("--debug")
  end
  
  Error::message(1) if ARGV.empty?

  # Check for a valid file
  if !File.exist? ARGV[0]
    Error::message(2)
  elsif !File.readable? ARGV[0]
    Error::message(3)
  end

  rips = Assembler.new(debug)

  File.open(ARGV[0], "r") do |f|
    f.each_line do |line|
      rips << line
    end
  end

  rips.run
end
