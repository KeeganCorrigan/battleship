class FiringSequence
  def initialize(game)
    @game = game
  end

  def fire_shots
    valid_choice = false
    until valid_choice == true
      puts @game.text.player_firing_turn
      input = @game.get_player_input
      if validate_cell_input(input) == true
        cell = @game.get_cell_state(input, @game.computer_board)
        valid_choice = validate_cell_state(cell)
      end
    end
    player_fires(cell)
  end

  def player_fires(cell)
    @game.fire_at_ships(cell)
    change_cell_state(cell)
    @game.display_board(@game.computer_board)
  end

  def change_cell_state(cell)
    if cell.state == "H"
      puts @game.text.confirm_player_hit_text
      cell.ship.take_hit
    elsif cell.state == "M"
      puts @game.text.confirm_player_miss_text
    end
  end

  def validate_cell_input(input)
    if @game.get_valid_cell_positions_array(@game.computer_board).include?(input) != true
      puts @game.text.player_invalid_fire_Square_selection_text
      return false
    else
      return true
    end
  end

  def validate_cell_state(cell)
    if cell.state != "~"
      puts @game.text.player_already_fired_on_same_sqaure_text
      return false
    else
      return true
    end
  end
end
