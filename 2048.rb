require 'io/console'
SIZE = 4
$punkte = 0
$matrix = Array.new(SIZE) { Array.new(SIZE) }


def draw
  puts "-"*6*SIZE
  puts "#{SIZE}x#{SIZE} - Punkte: #{$punkte}"
  puts "-"*6*SIZE
  $matrix.each do |row|
    row.each do |c|
      print(c ? format("%6d" % c) : "      ")
    end
    print "\n"
  end 
  puts "-"*6*SIZE
end

def new_number
  while true
    row = Random.new.rand(SIZE)
    col = Random.new.rand(SIZE)
    unless $matrix[row][col]
      $matrix[row][col] = (Random.new.rand(2)+1)*2
      break
    end
  end
end


def set_with_direction(x,y,value,direction)
  if direction == :left
    $matrix[y][x] = value
  elsif direction == :right
    $matrix[y][SIZE-1-x] = value
  elsif direction == :up
    $matrix[x][y] = value
  elsif direction == :down
    $matrix[SIZE-1-x][y] = value
  end
end

def get_with_direction(x,y,direction)
  if direction == :left
    $matrix[y][x]
  elsif direction == :right
    $matrix[y][SIZE-1-x]
  elsif direction == :up
    $matrix[x][y]
  elsif direction == :down
    $matrix[SIZE-1-x][y]
  end
end


def shift(direction)
  shifted = false
  (0...SIZE).each do 
    $matrix.each_index do |y|
      $matrix.first.each_index do |x|
        if x>0
          if get_with_direction(x,y,direction) && !get_with_direction(x-1,y,direction)
            set_with_direction(x-1,y,get_with_direction(x,y,direction),direction) 
            set_with_direction(x,y,nil,direction) 
            shifted=true
          end
        end 
      end
    end
  end

  $matrix.each_index do |y|
    $matrix.first.each_index do |x|
      if x>0
      	if get_with_direction(x,y,direction) && get_with_direction(x-1,y,direction)==get_with_direction(x,y,direction)
          $punkte += get_with_direction(x-1,y,direction)*2
          set_with_direction(x-1,y,get_with_direction(x-1,y,direction)*2,direction) 
          set_with_direction(x,y,nil,direction) 
          shifted=true
      	end
      end	
    end
  end

  (0...SIZE).each do 
    $matrix.each_index do |y|
      $matrix.first.each_index do |x|
        if x>0
          if get_with_direction(x,y,direction) && !get_with_direction(x-1,y,direction)
            set_with_direction(x-1,y,get_with_direction(x,y,direction),direction) 
            set_with_direction(x,y,nil,direction) 
            shifted=true
          end
        end 
      end
    end
  end
  return shifted
end


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

def move_possible
  $matrix.each_index do |y|
    $matrix.first.each_index do |x|
      return true unless $matrix[y][x]
    end
  end
  false
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
puts "Game Over, Punkte: #{$punkte}"