require './lib/game_flow'

class Text
  def play_quit_or_instructions_text
    "Would you like to (p)lay, (q)uit, or view the (i)nstructions?"
  end

  def instruction_text
    "At the beginning of the game, the player and computer opponent will place 2 ships on the board(a 2 unit ship, and a 3 unit ship). The board is a 4 x 4 grid, like this:

               ===========\n
          . 1 2 3 4  \n
          A          \n
          B          \n
          C          \n
          D          \n
          ===========\n

     *  Ships cannot wrap around the board\n
     ------------------\n
     *  Ships cannot overlap\n
     ------------------
     *  Ships can be laid either horizontally or vertically\n
     ------------------
     *  Coordinates must correspond to the first and last units of the ship. (IE: You can’t place a two unit ship at “A1 A3”)\n
     ------------------
    To place a ship, use the following format: A1, A2\n
    ------------------
    You will go first and will pick a square, typing it in by reference of column reference, row number (A3 for example). This represents firing a missile directly at that square. If the computer player has any part of one of their ships positioned on this square the map will update with an H. The computer will then fire and the player will be informed if it was a hit or a miss and they will see an updated game board. Once all ships on one side have been sunk the game is over."
  end

  def begin_play_text
    "I have laid out my ships on the grid. You now need to layout your two ships. The first is two units long and the second is three units long.
    The grid has A1 at the top left and D4 at the bottom right. Enter your choices like: A1 A2"
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

  def invalid_input
    "Try again in the right format: A1 A2"
  end

  def ship_diagonal_placement_text
    "Ships couldn't possibly go diagonal. Try again"
  end

  def ship_length_incorrect_or_wrap_attempt
    "Your ship is the wrong number of cells or you're trying to wrap it around the board. Cut it out"
  end

  def ships_can_not_overlap
    "No submarines. Ships can't overlap!"
  end

  def player_firing_turn
    "It's your turn to fire, pick a cell:"
  end

  def player_invalid_fire_Square_selection_text
    "That square is invalid."
  end

  def player_already_fired_on_same_square_text
    "You have already fired on that square."
  end

  def confirm_player_hit_text
    "That's a hit. You killed #{rand(2..100)} sailors."
  end

  def confirm_player_miss_text
    "It's a miss. You failed to kill someone's family member."
  end

  def confirm_your_ship_was_sunk(ship_name)
    "Your #{ship_name} was sunk. The machines have defended their homeland."
  end

  def confirm_computer_ship_was_sunk(ship_name, size)
    "You sunk the #{ship_name}. It took up #{size} squares."
  end

  def you_sunk_my_battleship
    `say You Sunk My Battleship`
  end

  def computer_sunk_a_battleship
    `say The water muffles your sailors screams as they sink to the bottom`
  end

  def confirm_computer_firing_location(cell)
    "The machines fired at #{cell}."
  end

  def confirm_computer_hit_text
    "The computer hit you. The sentient machines killed #{rand(2..100)} sailors."
  end

  def confirm_computer_miss_text
    "The computer missed you. The AI is doing its best."
  end

  def press_enter_to_continue
    "PRESS ENTER TO CONTINUE. Please. If not for me, for yourself."
  end

  def say_congratulations
    `say Congratulations You have continued the cycle of violence for another generation`
  end

  def congratulations_you_win_text
    "You have destroyed the last remnants of the enemies civilian vessels. Yay."
  end

  def loss_text
    "You failed to destroy a simple machine. And died in the process."
  end

  def number_of_guesses_and_time_text(time, shots_fired)
    "You fired #{shots_fired} shots and it took #{time / 60} minutes and #{time % 60} seconds to complete the game."
  end

  def battleship_ascii
    "                                     |__
                                     |/
                                     ---
                                     / | [
                              !      | |||
                            _/|     _/|-++'
                        +  +--|    |--|--|_ |-
                     { /|__|  |/__|  |--- |||__/
                    +---------------___[}-_===_.'____
                ____`-' ||___-{]_| _[}-  |     |_[___==--                _
 __..._____--==/___]_|__|_____________________________[___==--____,------' . 7
|                                                                     BB-61 /
 o_________________________________________________________________________|"
  end
end
