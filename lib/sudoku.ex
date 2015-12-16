defmodule Sudoku do
	@moduledoc """
	Sudoku is a deductive game played where a board consists of (generally) a 9 * 9 grid. 

	The board consists of 9 columns, and 9 rows. A board is also made up of a 3*3 square called a box. 
	Each different column, and each row must have no duplicate numbers between 1 and 9. Each box must not either
	"""




	@typedoc "Cell is either an integer or nil, which represents not being chosen yet"
	@type cell :: integer | nil
	@type row :: [cell]
	@type board :: [row]
	@doc """
	Returns the solved board or false if no board is possible
	"""
	@spec solve(board) :: board | false
	def solve(board), do: solve_with_piece(board, 0, 0)

	@doc """
	Adds an available number (based on the row) to the board at row, and column
	Starting at 0,0 and increasing by row THEN column
	"""
	@spec solve_with_piece(board, integer, integer) :: board | false
	def solve_with_piece(board, row, column) when row > 9 or column > 9 do 
		if valid?(board) do
			board
		else
			false
		end
	end
	
	def solve_with_piece(board, row, column) do
		numbers = available_numbers(board, row, column)
		for n <- numbers do

		end
	end

	@spec available_numbers(board, integer, integer)::[integer]
	defp available_numbers(board, row, column) do 
		# Get row, available_at_row(board, row)
		
	end
	defp available_at_row(), do: {}
	@doc """
	Given a full board, returns true if board has a acceptable answer
	"""
	@spec valid?(board)::boolean
	def valid? full_board do
		valid_rows? full_board &&
		valid_columns? full_board &&
		valid_boxes? full_board
	end


	def lrotate(board), do: _lrotate([], board)
	defp _lrotate(new_board, []), do: new_board
	defp _lrotate(new_board, [head|tail]), do: _lrotate( add_row_to_columns(head, new_board) , tail)

	@spec add_row_to_columns(row, board)::board
	def add_row_to_columns([], board), do: board
	def add_row_to_columns(row, []) do
		list_of_empty_lists = for _ <- 1..length(row), do: []
		add_row_to_columns(row, list_of_empty_lists)
	end

	# TODO: Extract functionality
	def add_row_to_columns row, board do
		board
		|> Stream.zip(row)
		|> Enum.map(fn{arr, n} -> arr ++ [n] end)
	end

	@doc "Checks rows 3, and 3 columns at time to determine if they contain no duplicates"
	@spec valid_boxes?(board) :: boolean
	def valid_boxes?([]), do: true
	def valid_boxes?([_]), do: raise ArgumentError,"number of rows must be divisble by 3, was 1"
	def valid_boxes?([_,_]), do: raise ArgumentError,"number of rows must be divisble by 3, was 2"
	def valid_boxes?([row1, row2, row3|tail]) do
		rows_have_valid_boxes?(row1, row2, row3) && valid_boxes?(tail)
	end

	@spec rows_have_valid_boxes?(row, row, row) :: boolean
	defp rows_have_valid_boxes?([],[],[]), do: true
	defp rows_have_valid_boxes?(row1, row2, row3) do
		[c1, c2, c3 |rest_row1] = row1
		[c4, c5, c6 |rest_row2] = row2
		[c7, c8, c9 |rest_row3] = row3
		!any_none_nil_duplicates?([c1,c2,c3,c4,c5,c6,c7,c8,c9]) &&
			rows_have_valid_boxes?(rest_row1, rest_row2, rest_row3)
	end

	@spec any_none_nil_duplicates?([cell]) :: boolean
	def any_none_nil_duplicates?(args) do
		args
		|>  Enum.filter(&(&1 != nil))
		|> _any_duplicates?
	end
	# @spec _any_duplicates?(row) :: boolean
	defp _any_duplicates?([]), do: false
	defp _any_duplicates?([head|tail]) do
		Enum.member?(tail, head) || _any_duplicates?(tail)
	end

	@spec valid_columns?(board)::boolean
	def valid_columns?(board), 	do: valid_rows?( lrotate(board) )
	@spec valid_rows?(board)::boolean
	def valid_rows?(board), 	do: Enum.all? board, &valid_row?/1
	@spec valid_row?(row)::boolean
	def valid_row?(row), do: _valid_row?([], row)

	@spec _valid_row?([integer], row)::boolean
	defp _valid_row?(_ , []), do: true
	defp _valid_row?(previous_numbers ,[head|tail]) do
		if Enum.member?(previous_numbers, head) do
			false
		else
			_valid_row?([head | previous_numbers], tail)
		end
	end

	@spec solved?(board)::boolean
	def solved?(board), do: board |> Enum.any? &row_has_available?/1

	@spec row_has_available?([cell]):: boolean
	defp row_has_available?(cells), do: not Enum.any? cells, &(&1 == nil)

	# Get tuple elements
	# elem({:a, :b, :c}, 1) => :a
	# put_elem({:a, :b, :c}, 1, :d) => :d
	# alias Module.Type, as: NicerName or alias Module.Type  is the same as: alais Module.Type, as: Type
	# require Module allows all macros available to that module to be accessed
	# import Module is used when we want to use all of it withoiut using the fully qualified name
	# - you can add a ', only: [function_name: arity]' or ',except: [function_name: arity]' to include/exclude specific types.
	# - 
	# Stream is like the enum type when you will be immediately processing the result: http://pminten.github.io/blog/2013/09/05/elixirs-enumerable/
	## Stream.map coll, &fn/1 |> Enum.filter(&1, &filter_fn/1)
	# Types: http://elixir-lang.org/docs/stable/elixir/Kernel.Typespec.html
	# the ambersand is for directives, like @spec, @type, etc.
	# Signitures are described as function(args) :: output_type
	# Custom types can be:
	# @typedoc """ This is a some new fancy type and it gives a number of how much I rate a word"
	# @type my_word_rating:: {String.t, number}
	# You can make a type private with @typep
	# With types we can use this: http://www.erlang.org/doc/man/dialyzer.html
	# # There are also @moduledocs, @doc for functions
	# Can be made explicit with: @spec function(args) :: output_type
	# Compound types: [integer], {number, String.t}, probably %{val:number, etc..}
	
	#eligible guard clauses: http://elixir-lang.org/getting-started/case-cond-and-if.html#expressions-in-guard-clauses
	
	# Interfaces can be defined with the: 
	# defmodule Name do ... and each signiture defined with @callback must be implemented
	# You specify that behaviour in your module by saying @behaviour MyModule 
	# Stay anon:
	# fn(args) -> args end
	# Iterators:
	# Enum.map my_list, some_func
	# First class named functions (procs?)
	# e.g. of square function in Math module:
	# &Math.square/arg_number
	# Partial functions in elixir:
	# Say we want to multiply everything by 2
	# Enum.map [1,2,3,4], &(&1 * 2) # or sumation
	# List.foldl [1,2,3,4,5], BASECASE, &(&1 + &2)
	# Call proc with:
	# my_func.(args)
	# cases:
	# cond do
	# case1 ->
	# 	result
	# case 2 -> 
	# 	result2
	# true ->
	# 	default result
	# end
	# Cond and If statements: Falsey = nil, false. If statements only do booleans
	# 
	# sending messages
	# pid = Kernel.self

	# send pid, {:hello}

	# receive do
	#   {:hello} -> :ok
	#   other -> other
	# after
	#   10 -> :timeout
	# end

	# Directives
	# @moduledoc, @vsn VERSION_NUMBER, @before_compile: will inject code pre-compile
	# @spec: specification for a function; @callback - provides a specification for the behaviour callback
	# @opaque: defines an opaque type to be used by @spec

	# doctests:
	# iex> Math.sum(1,2)
	# 3

	# function_name/arity represents a specific instance of a fucntion, we can also get based on this
	# fun = &Math.zero?/1
	# is_function fun
	# fun.(0)
	# Looks like there is a special "capture operator" &: http://elixir-lang.org/docs/stable/elixir/Kernel.SpecialForms.html#&/1
	# 

################## 
	# Types
	# Functions
	# def Sudoku(list_of_cells) do 

	# end
	# Helpers
end