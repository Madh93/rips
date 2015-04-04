require "rips/version"
require "rips/assembler"
require "rips/error"

module Rips

  # Check for a valid file
  if ARGV.empty?
    Error::message(1)
  elsif !File.exist? ARGV[0]
    Error::message(2)
  elsif !File.readable? ARGV[0]
    Error::message(3)
  end

  rips = Assembler.new

  File.open(ARGV[0], "r") do |f|
    f.each_line do |line|
      rips << line
    end
  end

  rips.run
end
