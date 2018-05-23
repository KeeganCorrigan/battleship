class FiringSequence
  def initialize(game)
    @game = game
  end

  def player_fires_shots
    valid_choice = false
    until valid_choice == true
      puts @game.text.player_firing_turn
      input = @game.get_player_input
      if validate_cell_input(input) == true
        cell = @game.get_cell_state(input, @game.computer_board)
        valid_choice = validate_cell_state(cell)
        if valid_choice == false
          puts @game.text.player_already_fired_on_same_square_text
        end
      else
        puts @game.text.player_invalid_fire_Square_selection_text
      end
    end
    player_fires(cell)
  end

  def player_fires(cell)
    fire_at_ships(cell)
    change_cell_state(cell, @game.computer_board)
    @game.display_board(@game.computer_board)
    verify_computer_ship_sunk(cell)
  end

  def computer_validates_shot
    valid_choice = false
    until valid_choice == true
      input = computer_fire_at_ships(@game.player_board)
      cell = @game.get_cell_state(input, @game.player_board)
      valid_choice = validate_cell_state(cell)
    end
    return cell
  end

  def computer_fires_shots
    cell = computer_validates_shot
    puts @game.text.confirm_computer_firing_location(cell.position)
    fire_at_ships(cell)
    change_cell_state(cell, @game.player_board)
    @game.display_board(@game.player_board)
    verify_player_ship_sunk(cell)
  end

  def change_cell_state(cell, board)
    cell_state_hit(cell, board)
    cell_state_miss(cell, board)
  end

  def cell_state_hit(cell, board)
    if cell.state == "H"
      if board == @game.computer_board
        puts @game.text.confirm_player_hit_text
      else
        puts @game.text.confirm_computer_hit_text
      end
      cell.ship.take_hit
    end
  end

  def cell_state_miss(cell, board)
    if cell.state == "M"
      if board == @game.computer_board
        puts @game.text.confirm_player_miss_text
      else
        puts @game.text.confirm_computer_miss_text
      end
    end
  end

  def validate_cell_input(input)
    if @game.get_valid_cell_positions_array(@game.computer_board).include?(input) != true
      return false
    else
      return true
    end
  end

  def validate_cell_state(cell)
    if cell.state != "~"
      return false
    else
      return true
    end
  end

  def fire_at_ships(cell)
    if cell.state == "~"
      cell.change_state
    end
  end

  def computer_fire_at_ships(board)
    @game.get_valid_cell_positions_array(board).sample
  end

  def verify_computer_ship_sunk(cell)
    if cell.ship != nil
      if cell.ship.sunk == true
        puts @game.text.confirm_computer_ship_was_sunk(cell.ship.name, cell.ship.size)
      end
    end
  end

  def verify_player_ship_sunk(cell)
    if cell.ship!= nil
      if cell.ship.sunk == true
        puts @game.text.confirm_your_ship_was_sunk(cell.ship.name)
      end
    end
  end
end
