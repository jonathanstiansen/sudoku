defmodule SudokuTest do
  use ExUnit.Case, async: true
  import Sudoku
  # Fully solved sudoku
  @row1 [1,2,3,4,5,6,7,8,9]
  @row2 [4,5,6,7,8,9,1,2,3]
  @row3 [7,8,9,1,2,3,4,5,6]
  @row4 [2,3,4,5,6,7,8,9,1] # first 3 shifted by one
  @row5 [5,6,7,8,9,1,2,3,4]
  @row6 [8,9,1,2,3,4,5,6,7]
  @row7 [3,4,5,6,7,8,9,1,2] # first 3 shifted by two
  @row8 [6,7,8,9,1,2,3,4,5]
  @row9 [9,1,2,3,4,5,6,7,8]
  @empty_row for _ <- 1..9, do: nil
  @empty_board [@empty_row, @empty_row, @empty_row, @empty_row, @empty_row, @empty_row, @empty_row, @empty_row, @empty_row]

  test "solved? works" do
  	assert solved?([[nil]]) == false
  end

  test "solved? evaluates to false when cell is empty" do
  	assert solved?([[1]]) == true
  end
 
  test "valid_row? returns valid when row contains only 1 through 9" do
  	# [head | tail] = @row1
  	assert valid_row?(@row1) == true
  end

  test "valid_row? Returns invalid when a row has duplicates" do
  	row = for n <- 1..8, do: n
  	row = row ++[1]

  	assert valid_row?(row) == false
  end

  test "valid_columns? base case" do
  	assert valid_columns?([]) == true
  end

  test "valid_columns? returns false when second column has duplicates" do
	columns = for n <- 1..8, do: [n, n+1]
  	columns = columns ++ [[9,2]]

  	assert valid_columns?(columns) == false
  end

  test "valid_columns? works with multiple correct columns" do
  	correct_columns = for n <- 1..8, do: [n, n+1]

  	assert valid_columns?(correct_columns) == true
  end

  test "valid_boxes? works with empty board", 				do: assert valid_boxes?(@empty_board) == true
  test "valid_boxes? works with single square", 			do: assert valid_boxes?([[1,2,3],[4,5,6],[7,nil,9]]) == true
  test "valid_boxes? false with duplicate number in box", 	do: assert valid_boxes?([[1,2,3],[4,nil,6],[7,nil,1]]) == false
  test "valid_boxes? works with mostly empty cells", 		do: assert valid_boxes?([@empty_row,@row1,@empty_row]) == true

  test "lrotate base case", do: assert lrotate([]), []
  test "lrotate rotates single row to column" do
  	columns = for n <- 1..9, do: [n]

  	assert lrotate([@row1]) == columns
  end

  test "add_row_to_column base base", 					 do: assert add_row_to_columns([],[[1],[2],[3]]) 		== [[1],[2],[3]]
  test "add_row_to_column adds row to empty column", 	 do: assert add_row_to_columns([1,2,3],[]) 		 		== [[1],[2],[3]]
  test "add_row_to_column adds row to filled columns",	 do: assert add_row_to_columns([3,2,1],[[1],[2],[3]]) 	== [[1,3],[2,2],[3,1]] 


end
