require 'rubygems'
require 'chingu'
require './battlesim_menu'
require './battlesim_play'
include Gosu
include Chingu

class Main < Chingu::Window
  def initialize
    super(1366, 768, true)
    push_game_state(BattleSimMenu)
  end

  def draw
    fill(Color::WHITE, -100)
    super
  end
end

Main.new.show
