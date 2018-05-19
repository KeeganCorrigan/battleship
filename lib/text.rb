class Text
  def play_quit_or_instructions_text
    "Would you like to (p)lay, (q)uit, or view the (i)nstructions?"
  end

  def instruction_text
    "At the beginning of the game, the player and computer opponent will place 2 ships on the board(a 2 unit ship, and a 3 unit ship). The board is a 4 x 4 grid, like this:"

    "          ===========\n
          . 1 2 3 4  \n
          A          \n
          B          \n
          C          \n
          D          \n
          ===========\n"

    "*  Ships cannot wrap around the board"
    "------------------"
    "*  Ships cannot overlap"
    "------------------"
    "*  Ships can be laid either horizontally or vertically"
    "------------------"
    "*  Coordinates must correspond to the first and last units of the ship. (IE: You can’t place a two unit ship at “A1 A3”)"
    "------------------"
    "To place a ship, use the following format: A1, A2"
    "------------------"
    "You will go first and will pick a square, typing it in by reference of column reference, row number (A3 for example). This represents firing a missile directly at that square. If the computer player has any part of one of their ships positioned on this square the map will update with an H. The computer will then fire and the player will be informed if it was a hit or a miss and they will see an updated. Once all ships on one side have been sunk the game is over."
  end

  def begin_play_text
    "I have laid out my ships on the grid."
    "You now need to layout your two ships."
    "The first is two units long and the"
    "second is three units long."
    "The grid has A1 at the top left and D4 at the bottom right."
  end

  def invalid_starting_choice_text
    "Listen to my directions better."
  end

  def player_places_two_unit_ship_text
    "Enter the squares for the two-unit ship:"
  end

  def player_places_three_unit_ship_text
    "Enter the squares for your three-unit ship:"
  end

  def invalid_ship_placement_text
    "You have chosen poorly. Try again"
  end

  def ship_wraps_around_board_text
    "The ship can not wrap around the board"
  end

  def ship_is_incorrect_number_of_squares
    "Your ship is the wrong number of squares"
  end

  def player_firing_turn
    "It's your turn to fire, pick a square:"
  end

  def player_invalid_fire_Square_selection_text
    "That square is invalid."
  end

  def player_already_fired_on_same_sqaure_text
    "You have already fired on that square."
  end

  def confirm_player_hit_text
    "That's a hit. You killed #{rand(2..100)} sailors."
  end

  def confirm_player_miss_text
    "It's a miss. You failed to kill someone's family member."
  end

  def confirm_computer_hit_text
    "The computer hit you. The sentient machines killed #{rand(2..100)} sailors."
  end

  def confirm_computer_miss_text
    "The computer missed you. The AI is very simple."
  end

  def congratulations_you_win_text
    "You have destroyed the last remnants of the enemies civilian vessels. Yay."
  end

  def loss_text
    "You failed to destroy a simple machine. And died in the process."
  end

  def play_again_text
    "Would you like to play again?"
  end

  def number_of_guesses_and_time_text
    #add interpolation for guesses and time
    "You took this many guesses and it took this long"
  end
end
