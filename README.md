# Rips
[![Gem Version](https://badge.fury.io/rb/rips.svg)](http://badge.fury.io/rb/rips)
[![Dependency Status](https://gemnasium.com/Madh93/rips.svg)](https://gemnasium.com/Madh93/rips)

Simple assembler written in Ruby for a [simple 16-bit CPU written in Verilog](https://github.com/Madh93/scpu/). Based in MIPS syntax with next features:

- 19 basic instructions
- 16 registers ($0-$15)
- 4 I/O ports (@0-@3)
- Support labels
- Support comments

## Requirements

Ruby >=1.9.3

## Installation

    $ gem install rips
    
or download from [RubyGems](https://rubygems.org/gems/rips).

**Optional:** [Rips syntax highlightning package for sublime text 2/3](https://github.com/Madh93/rips-syntax/)

## Usage

    $ rips [OPTIONS] instructions.rips
    
Examples:

    $ rips --debug instructions.rips
    $ rips -d instructions.rips -o instructions
    
## Options

    -d, --debug         Show trace in console
    -o FILE             Output file with binary instructions (by default: progfile.dat)  
    
## Instruction Set

| Name                     | MNENOMIC | FORMAT | OPERATION        | OPCODE |
|--------------------------|----------|--------|------------------|--------|
| Move                     | move     | C      | move $1, $0      | 0000   |
| Not                      | not      | C      | not $1, $0       | 0001   |
| Add                      | add      | D      | add $2, $0, $1   | 0010   |
| Subtract                 | sub      | D      | sub $2, $0, $1   | 0011   |
| And                      | and      | D      | and $2, $0, $1   | 0100   |
| Or                       | or       | D      | or $2, $0, $1    | 0101   |
| Shift right logical      | srl      | D      | srl $2, $3, $1   | 0110   |
| Less than                | lest     | D      | lest $0, $2, $1  | 0111   |
| Jump                     | j        | B      | j label          | 1001   |
| Load Inmediate           | li       | C      | li $0, 10        | 1010   |
| Load from I/O            | lesr     | C      | lesr $0, @0      | 1011   |
| Store I/O from Reg       | sesr     | C      | sesr @0, $0      | 1101   |
| Store I/O from Mem       | sesm     | C      | sesm @0, 10      | 1110   |
| Relative Jump            | ji       | B      | ji 10            | 011000 |
| Jump and Link            | jal      | B      | jal label        | 101000 |
| Jump Register            | jr       | A      | jr               | 111000 |
| Branch z!=0              | bnez     | B      | bnez label       | 001111 |
| Branch z==0              | beqz     | B      | beqz label       | 011111 |
| No Operation             | nop      | A      | nop              | 111111 |
  
## Contributing

1. Fork it ( https://github.com/Madh93/rips/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request