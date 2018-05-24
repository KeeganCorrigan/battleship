module Verify
  def verify_no_ship_in_cell(cell1, cell2, cell3)
    if cell1.ship || cell2.ship || cell3.ship != nil
      return false
    end
    return true
  end

  def get_valid_cell_positions_array(board)
    valid_inputs = board.flatten.map(&:position)
    return valid_inputs
  end

  def count_hits_on_ships(board)
    ship_hits = board.flatten.count do |cell|
      cell.state == 'H'.red
    end
    return ship_hits
  end
end
