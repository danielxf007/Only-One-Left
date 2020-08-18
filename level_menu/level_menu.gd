extends Node2D
signal got_g_dimensions(dimensions)
signal got_p_dimensions(dimensions)
signal got_rules_solutions_puzzles(rules, solutions, puzzles)
signal got_puzzles_states(puzzles_states)
signal puzzle_menu_appeared()
const FILE_NAME: String = "user://puzzles.ini"
const START_SECTION_NAME: String = "LVL_"
const K: int = 5
var puzzle_config_file: ConfigFile
var curr_section_name: String
var curr_config_file_keys: PoolStringArray

func _ready():
	self.set_puzzle_config_file()

func _on_Button_pressed():
	var new_section_name: String = self.START_SECTION_NAME + str(7)
	self.set_curr_section_name(new_section_name)
	self.set_puzzle_config_file_keys()
	var dimensions: TupleInt = self.get_puzzle_dimensions()
	var puzzles_states: Array = self.get_puzzles_states()
	var rules: Array = self.get_puzzle_rules()
	var solutions: Array = self.get_puzzle_solutions()
	var puzzles: Array = self.get_puzzles()
# warning-ignore:integer_division
	var p_dimensions: TupleInt = TupleInt.new(puzzles.size()/self.K, self.K)
	self.emit_signal("got_puzzles_states", puzzles_states)
	self.emit_signal("got_p_dimensions", p_dimensions)
	self.emit_signal("got_g_dimensions", dimensions)
	self.emit_signal("got_rules_solutions_puzzles", rules, solutions, puzzles)
	self.emit_signal("puzzle_menu_appeared")
	self.pop_out()

func set_puzzle_config_file() -> void:
	var config: ConfigFile = ConfigFile.new()
	var err = config.load(self.FILE_NAME)
	if err == OK:
		self.puzzle_config_file = config

func set_curr_section_name(new_section_name: String) -> void:
	self.curr_section_name = new_section_name

func set_puzzle_config_file_keys() -> void:
	self.curr_config_file_keys = self.puzzle_config_file.get_section_keys(
		self.curr_section_name)

func get_puzzle_dimensions() -> TupleInt:
	var dimension_arr: Array = self.puzzle_config_file.get_value(
	self.curr_section_name, self.curr_config_file_keys[0])
	var dimensions: TupleInt = TupleInt.new(dimension_arr[0], dimension_arr[1])
	return dimensions

func get_puzzle_rules() -> Array:
	return self.puzzle_config_file.get_value(self.curr_section_name,
	self.curr_config_file_keys[1])

func get_puzzle_solutions() -> Array:
	return self.puzzle_config_file.get_value(self.curr_section_name,
	self.curr_config_file_keys[2])

func get_puzzles() -> Array:
	return self.puzzle_config_file.get_value(self.curr_section_name,
	self.curr_config_file_keys[3])

func get_puzzles_states() -> Array:
	return self.puzzle_config_file.get_value(self.curr_section_name,
	self.curr_config_file_keys[4])

func pop_up() -> void:
	self.visible = true

func pop_out() -> void:
	self.visible = false

func _on_PuzzleMenu_puzzle_board_created() -> void:
	self.emit_signal("puzzle_menu_appeared")
	self.pop_out()
