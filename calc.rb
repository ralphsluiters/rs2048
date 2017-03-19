require './logic.rb'
last_number=nil
dir=0
(1..10000).each do |count|
if move_possible
  new_number if empty_field
  dir = Random.new.rand(11) if count % SIZE == 0 
  shifted = case dir
  when 0..4
    shift(:up)
  when 5..9
    shift(:right)
  else
    shift(:down)
  end
  new_number if shifted
else
  last_number ||=count
end#if
end#do


draw
if move_possible
  puts "Punkte: #{$punkte}"
else
  puts "Game Over, Punkte: #{$punkte}, Züge: #{last_number}"
end