require './test/test_helper'
require './lib/text.rb'
require './lib/game_flow.rb'

class TextTest < Minitest::Test
  def test_it_exists
    text = Text.new
    assert_instance_of(Text, text)
  end

  def test_confirm_your_ship_was_sunk
    game = GameFlow.new
    text = Text.new
    assert_equal "Your Patrol Boat was sunk. The machines have defended their homeland.", text.confirm_your_ship_was_sunk(game.player_ship_2.name)
  end

  def test_confirm_computer_ship_was_sunk
    game = GameFlow.new
    text = Text.new
    assert_equal "You sunk the Peaceful fishing boat. It took up 2 squares.",
    text.confirm_computer_ship_was_sunk(game.comp_ship_2.name, game.comp_ship_2.size)
  end

  def test_confirm_computer_firing_location
    game = GameFlow.new
    text = Text.new
    cell = game.player_board[0][0].position
    assert_equal "The machines fired at A1.", text.confirm_computer_firing_location(cell)
  end

  def test_number_of_guesses_and_time_text
    game = GameFlow.new
    text = Text.new
    time_start = Time.new.to_i
    sleep(1)
    total_time_played = Time.now.to_i - time_start
    shots_fired = 9
    assert_equal "You fired 9 shots and it took 0 minutes and 1 seconds to complete the game.", text.number_of_guesses_and_time_text(total_time_played, shots_fired)
  end
end
