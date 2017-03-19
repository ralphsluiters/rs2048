require 'io/console'
require './logic.rb'

def read_char
  STDIN.echo = false
  STDIN.raw!

  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end
ensure
  STDIN.echo = true
  STDIN.cooked!

  return input
end


new_number
while move_possible do
  draw
  shifted = case read_char
  when "\e[A"
    shift(:up)
  when "\e[B"
    shift(:down)
  when "\e[C"
    shift(:right)
  when "\e[D"
    shift(:left)
  when "\u0003"
    puts "CONTROL-C, Punkte: #{$punkte}"
    exit 0
  when "\e"
    puts "ESCAPE, Punkte: #{$punkte}"
    exit 0
  end
  new_number if shifted
end#while
draw
puts "Game Over, Punkte: #{$punkte}"