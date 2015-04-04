require "rips/version"
require "rips/assembler"

module Rips

  rips = Assembler.new

  File.open(ARGV[0], "r") do |f|
    f.each_line do |line|
      rips << line
    end
  end

  rips.run
end
