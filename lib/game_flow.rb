require './test/test_helper'
require './lib/ship'
require './lib/game_board'
require './lib/text'
require './lib/game_logic'
require './lib/cell'
require './lib/firing_sequence'

class GameFlow

  attr_reader :text, :comp_ship_2, :comp_ship_3, :computer_board, :player_ship_2, :player_ship_3, :player_board, :game_logic, :player

  def initialize
    @text = Text.new
    @comp_ship_2 = Ship.new(2, "Orphaned puppy adventure cruise", "2")
    @comp_ship_3 = Ship.new(3, "Merchant vessel just doing its job", "3")
    @computer_board = GameBoard.new.create_board
    @player_ship_2 = Ship.new(2, "Patrol Boat", "2")
    @player_ship_3 = Ship.new(3, "Destroyer", "3")
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
    if input == 'P' || input == 'PLAY'
      clear_screen
      @time = Time.now.to_i
      return
    elsif input == 'Q'|| input == 'QUIT'
      quit_the_game
    elsif input == 'I' || input == 'INSTRUCTIONS'
      puts text.instruction_text
      game_start
    else
      puts text.invalid_starting_choice_text
      game_start
    end
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

  def verify_no_ship_in_cell(cell1, cell2, cell3)
    if cell1.ship || cell2.ship || cell3.ship != nil
      return false
    end
    return true
  end

  def get_valid_cell_positions_array(board)
    valid_inputs = board.flatten.map do |cell|
      cell.position
    end
    return valid_inputs
  end

  def count_hits_on_ships(board)
    ship_hits = board.flatten.count do |cell|
      cell.state == "H"
    end
    return ship_hits
  end

  def time_calculator
    Time.now.to_i - @time
  end

  def player_wins
    text.say_congratulations
    puts text.congratulations_you_win_text
    puts text.number_of_guesses_and_time_text(time_calculator, shots_fired)
    long_pause
    quit_the_game
  end

  def computer_wins
    puts text.loss_text
    puts text.number_of_guesses_and_time_text(time_calculator, shots_fired)
    long_pause
    long_pause
    quit_the_game
  end

  def win_state(board, board_1, shots_fired)
    if count_hits_on_ships(board) == 5
      player_wins
    elsif count_hits_on_ships(board_1) == 5
      computer_wins
    else
      return false
    end
  end
end
