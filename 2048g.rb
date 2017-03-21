require 'gosu'
require './logic.rb'

FELD = 64

module ZOrder
  Background, Game, UI = *0..2
end



class GameWindow < Gosu::Window
  def initialize()
    super(FELD*SIZE, FELD*SIZE+20)#, fullscreen: true )
    self.caption = "RS 2048"
    @font = Gosu::Font.new(20)
    @font_big = Gosu::Font.new(36)
    new_number
  end

  def update
    shifted = false
    if Gosu::button_down?(Gosu::KbEscape) || Gosu::button_down?(Gosu::KbQ)
      exit(0)
    end
    if Gosu::button_down? Gosu::KbLeft
      shifted=shift(:left)
     sleep 0.4
    end
    if Gosu::button_down? Gosu::KbRight
      shifted=shift(:right)
      sleep 0.4
    end
    if Gosu::button_down? Gosu::KbUp
      shifted=shift(:up)
      sleep 0.4
    end
    if Gosu::button_down?(Gosu::KbDown)
      shifted=shift(:down)
      sleep 0.4
    end

    if shifted
      if move_possible
        new_number
        shifted=false
      else
        exit(0)
      end
    end


  end



  def draw
    Gosu::draw_rect(0, 20, FELD*SIZE, FELD*SIZE, 0xff_eeeeee, ZOrder::UI, :additive)
    @font.draw("#{SIZE}x#{SIZE} - Punkte: #{$punkte}", 0, 0, ZOrder::UI, 1.0, 1.0, 0xff_ffffff)
    $matrix.each_index do |y|
      $matrix.first.each_index do |x|
        Gosu::draw_rect(FELD*x+1, FELD*y+21,FELD-2,FELD-2, 0xff_000000+$matrix[y][x]**2, ZOrder::UI, :additive) if $matrix[y][x]
        @font_big.draw($matrix[y][x], x*FELD, y*FELD+30, ZOrder::UI, 1.0, 1.0, 0xff_493D26)
      end
    end 
  end


end

window = GameWindow.new()
window.show
