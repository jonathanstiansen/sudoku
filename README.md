Sudoku
======

*Sudoku* is a deductive game played where a board consists of (generally) a 9 * 9 grid. 

	The board consists of 9 columns, and 9 rows. A board is also made up of a 3*3 square called a box. 
	Each different column, and each row must have no duplicate numbers between 1 and 9. Each box must not either

	This is mostly statically checked so you can use dialyzer - first navigate outside of your folders that are version controlled:
	
	```bash
		$ git clone https://github.com/jeremyjh/dialyxir.git
		$ cd dialyxir/
		$ mix archive.build
		$ mix archive.install
		$ mix dialyzer.plt
	```

	Now inside of the project you can run: 
	
		```bash $ mix dialyzer ```

	I run tests automatically source of how: https://chodounsky.net/2015/06/16/running-exunit-tests-when-file-changes/
	I use mix test.watch to run my tests automatically:
	
		```bash $ mix test.watch ```

	TODO: 

		- write solve tests
		- finish solve
		- Refactor many of the methods to better Enum methods, like reduce 
		- Remove 'test.watch' dependancy from production set
