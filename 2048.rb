SIZE = 4

$matrix = Array.new(SIZE) { Array.new(SIZE) }


def draw
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

def shift_right
  $matrix.each_index do |y|
    $matrix.first.each_index do |x|
      if x>0
      	if $matrix[y][x] && $matrix[y][x-1]==$matrix[y][x]
          $matrix[y][x] *= 2 
          $matrix[y][x] =nil 
      	end
      end	
    end
    $matrix.first.each_index do |x|
      if x>0
      	if $matrix[y][x] && $matrix[y][x-1]==$matrix[y][x]
          $matrix[y][x] *= 2 
          $matrix[y][x] =nil 
      	end
      end	
    end

  end
end


draw
new_number
draw
new_number
draw
new_number
draw
new_number
draw