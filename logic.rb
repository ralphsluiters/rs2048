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

def zur_seite(direction)
  shifted = false
  found = true
  while found do
    found = false 
    $matrix.each_index do |y|
      $matrix.first.each_index do |x|
        if x>0
          if get_with_direction(x,y,direction) && !get_with_direction(x-1,y,direction)
            set_with_direction(x-1,y,get_with_direction(x,y,direction),direction) 
            set_with_direction(x,y,nil,direction) 
            shifted = true
            found = true
          end
        end 
      end
    end
  end
  return shifted
end


def shift(direction)
  shifted = false
  shifted = zur_seite(direction) || shifted

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

  shifted = zur_seite(direction) || shifted
  return shifted
end


def shift_possible
  $matrix.each_index do |y|
    $matrix.first.each_index do |x|
      return true if x>0 && $matrix[y][x]==$matrix[y][x-1]
      return true if y>0 && $matrix[y][x]==$matrix[y-1][x]
    end
  end
  false
end


def empty_field
  $matrix.each_index do |y|
    $matrix.first.each_index do |x|
      return true unless $matrix[y][x]
    end
  end
  return false
end


def move_possible
  return empty_field || shift_possible
end
