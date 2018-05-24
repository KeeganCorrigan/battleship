require './test/test_helper'
require './lib/ship'
require './lib/game_board'
require './lib/text'
require './lib/game_logic'
require './lib/cell'
require './lib/firing_sequence'
require './lib/verify'
require 'colorize'

class GameFlow
  include Verify
  attr_reader :text, :comp_ship_2, :comp_ship_3, :computer_board, :player_ship_2, :player_ship_3, :player_board, :game_logic, :player

  def initialize
    @text = Text.new
    @comp_ship_2 = Ship.new(2, "Orphaned puppy adventure cruise", "2")
    @comp_ship_3 = Ship.new(3, "Merchant vessel just doing its job", "3")
    @computer_board = GameBoard.new.create_board
    @player_ship_2 = Ship.new(2, "Patrol Boat", '2')
    @player_ship_3 = Ship.new(3, "Destroyer", '3')
    @player_board = GameBoard.new.create_board
    @game_logic = GameLogic.new
    @time = nil
  end

  def game_start
    puts text.play_quit_or_instructions_text
    input = get_player_input
    quit_play_or_read(input)
  end

  def quit_play_or_read(input)
    if %w[P PLAY].include?(input)
      clear_screen
      puts text.battleship_ascii
      @time = Time.now.to_i
      return
    elsif %w[Q QUIT].include?(input)
      quit_the_game
    elsif %w[I INSTRUCTIONS].include?(input)
      puts text.instruction_text
    else
      puts text.invalid_starting_choice_text
    end
    game_start
  end

  def quit_the_game
    exit
  end

  def get_player_input
    gets.upcase.chomp
  end

  def player_press_enter
    input = gets
    until input == "\n"
      input = gets
    end
  end

  def small_pause
    sleep(1)
  end

  def long_pause
    sleep(2)
  end

  def clear_screen
    puts `clear`
  end

  # def verify_no_ship_in_cell(cell1, cell2, cell3)
  #   if cell1.ship || cell2.ship || cell3.ship != nil
  #     return false
  #   end
  #   return true
  # end

  def time_calculator
    Time.now.to_i - @time
  end

  def player_wins(shots_fired)
    text.say_congratulations
    puts text.congratulations_you_win_text
    puts text.number_of_guesses_and_time_text(time_calculator, shots_fired)
    long_pause
    quit_the_game
  end

  def computer_wins(shots_fired)
    puts text.loss_text
    puts text.number_of_guesses_and_time_text(time_calculator, shots_fired)
    long_pause
    long_pause
    quit_the_game
  end

  def win_state(board, board_1, shots_fired)
    if count_hits_on_ships(board) == 5
      player_wins(shots_fired)
    elsif count_hits_on_ships(board_1) == 5
      computer_wins(shots_fired)
    else
      return false
    end
  end
end
