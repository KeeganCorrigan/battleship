require 'colorize'
require './lib/verify'

class FiringSequence
  include Verify
  attr_reader :shots_fired, :game

  def initialize(game)
    @game = game
    @shots_fired = 0
    @speech_counter = 0
  end

  def player_fires_shots
    display_board(@game.computer_board, 'The Anonymous Enemy')
    valid_choice = false
    until valid_choice == true
      puts @game.text.player_firing_turn
      @game.small_pause
      input = @game.get_player_input
      if validate_cell_input(input) == true
        cell = get_cell_state(input, @game.computer_board)
        valid_choice = validate_cell_state(cell)
        if valid_choice == false
          puts @game.text.player_already_fired_on_same_square_text
        end
      else
        puts @game.text.player_invalid_fire_Square_selection_text
      end
    end
    @game.clear_screen
    player_fires(cell)
    firing_counter
  end

  def computer_begs_for_mercy
    if count_hits_on_ships(@game.computer_board) == 1 && @speech_counter == 0
      @game.text.say_have_mercy
      @speech_counter += 1
    elsif count_hits_on_ships(@game.computer_board) == 3 && @speech_counter == 1
      @game.text.we_beg_you_for_peace
      @speech_counter += 1
    elsif count_hits_on_ships(@game.computer_board) == 4 && @speech_counter == 2
      @game.text.we_do_not_deserve_this
      @speech_counter += 1
    end
  end

  def player_fires(cell)
    fire_at_ships(cell)
    change_cell_state(cell, @game.computer_board)
    display_board(@game.computer_board, 'The Anonymous Enemy')
    computer_begs_for_mercy
    puts @game.text.press_enter_to_continue
    @game.player_press_enter
    verify_computer_ship_sunk(cell)
  end

  def computer_validates_shot
    valid_choice = false
    until valid_choice == true
      input = computer_fire_at_ships(@game.player_board)
      cell = get_cell_state(input, @game.player_board)
      valid_choice = validate_cell_state(cell)
    end
    return cell
  end

  def computer_fires_shots
    cell = computer_validates_shot
    @game.clear_screen
    puts @game.text.confirm_computer_firing_location(cell.position)
    @game.small_pause
    fire_at_ships(cell)
    change_cell_state(cell, @game.player_board)
    display_board(@game.player_board, 'The Aggressive Player')
    puts @game.text.press_enter_to_continue
    @game.player_press_enter
    @game.clear_screen
    verify_player_ship_sunk(cell)
  end

  def change_cell_state(cell, board)
    cell_state_hit(cell, board)
    cell_state_miss(cell, board)
  end

  def cell_state_hit(cell, board)
    if cell.state == 'H'.red
      if board == @game.computer_board
        puts @game.text.confirm_player_hit_text
      else
        puts @game.text.confirm_computer_hit_text
      end
      @game.small_pause
      cell.ship.take_hit
    end
  end

  def cell_state_miss(cell, board)
    if cell.state == 'M'
      if board == @game.computer_board
        puts @game.text.confirm_player_miss_text
      else
        puts @game.text.confirm_computer_miss_text
      end
      @game.small_pause
    end
  end

  def get_cell_state(input, board)
    cells = board.flatten.find do |cell|
      cell.position == input
    end
    return cells
  end

  def validate_cell_input(input)
    if get_valid_cell_positions_array(@game.computer_board).include?(input) != true
      return false
    else
      return true
    end
  end

  def validate_cell_state(cell)
    if cell.state != '~'.blue
      return false
    else
      return true
    end
  end

  def fire_at_ships(cell)
    cell.change_state if validate_cell_state(cell) == true
  end

  def computer_fire_at_ships(board)
    get_valid_cell_positions_array(board).sample
  end

  def verify_computer_ship_sunk(cell)
    if !cell.ship.nil?
      if cell.ship.sunk == true
        puts @game.text.confirm_computer_ship_was_sunk(cell.ship.name, cell.ship.size)
        @game.text.you_sunk_my_battleship
        @game.text.suffering_continues
        @game.small_pause
      end
    end
  end

  def verify_player_ship_sunk(cell)
    if !cell.ship.nil?
      if cell.ship.sunk == true
        @game.text.computer_sunk_a_battleship
        puts @game.text.confirm_your_ship_was_sunk(cell.ship.name)
        @game.small_pause
      end
    end
  end

  def firing_counter
    @shots_fired += 1
  end

  def display_board(board, owner)
    puts "      #{owner.upcase}"
    puts "          ===========\n
          . 1 2 3 4  \n
          A #{board[0][0].state} #{board[0][1].state} #{board[0][2].state} #{board[0][3].state}         \n
          B #{board[1][0].state} #{board[1][1].state} #{board[1][2].state} #{board[1][3].state}         \n
          C #{board[2][0].state} #{board[2][1].state} #{board[2][2].state} #{board[2][3].state}           \n
          D #{board[3][0].state} #{board[3][1].state} #{board[3][2].state} #{board[3][3].state}         \n
          ===========\n"
  end
end
