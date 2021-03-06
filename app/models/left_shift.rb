require 'pry'

module LeftShift

  def shift_element_left(array, idx)
    return array if idx == 0
    if array[idx - 1] == 0 && array[idx] != 0 # do the following; otherwise do nothing
      array[idx - 1] = array[idx]
      array[idx] = 0
      @changed_row = true
    end

    array
  end

  def combine_elements_left(row)
    row.each_index do |idx|
      break if idx == row.length - 1
      if row[idx] != 0
        inner_counter = 1
        while inner_counter < row.length
          break if row[idx + inner_counter] != 0 && row[idx + inner_counter] != row[idx]
          if row[idx] == row[idx + inner_counter]

            @collision_points << [board.index(row), idx]

            row[idx] += row[idx + inner_counter]
            row[idx + inner_counter] = 0
            @changed_row = true
            break
          end
          inner_counter += 1
        end
      end
    end
    row
  end

  def shift_row_left_once(row)
    @changed_row = false
    row.each_index do |square|
      shift_element_left(row, square)
    end
    row
  end

  def shift_row_left(row)
    combine_elements_left(row)
    loop do
      shift_row_left_once(row)
      break if !@changed_row
    end
    row
  end

  def swipe_left(board)
    board.each do |row|
      shift_row_left(row)
    end
  end

end
