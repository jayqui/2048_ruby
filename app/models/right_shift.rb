module RightShift

  def shift_element_right(array, idx)
    return array if idx == array.length - 1
    if array[idx + 1] == 0 && array[idx] != 0 # do the following; otherwise do nothing
      array[idx + 1] = array[idx]
      array[idx] = 0
      @changed_row = true
    end

    array
  end

  def combine_elements_right(row)
    row.to_enum.with_index.reverse_each do |ele, idx|
      break if idx == 0
      if row[idx] != 0
        inner_counter = 1
        while idx - inner_counter >= 0
          break if row[idx - inner_counter] != 0 && row[idx - inner_counter] != row[idx]
          if row[idx] == row[idx - inner_counter]

            @collision_points << [board.index(row), idx]

            row[idx] += row[idx - inner_counter]
            row[idx - inner_counter] = 0
            @changed_row = true
            break
          end
          inner_counter += 1
        end
      end
    end
    row
  end

  def shift_row_right_once(row)
    @changed_row = false
    row.each_index do |square|
      shift_element_right(row, square)
    end
    row
  end

  def shift_row_right(row)
    combine_elements_right(row)
    loop do
      shift_row_right_once(row)
      break if !@changed_row
    end
    row
  end

  def swipe_right(board)
    board.each do |row|
      shift_row_right(row)
    end
  end

end
