extends Node2D
signal level_pushed(dimensions, r_l_margins, u_d_margins)
signal got_rules_puzzles(rules, puzzles)
signal puzzle_menu_appeared()
export(int) var N_ROWS: int
export(int) var M_COLUMNS: int
export(float) var R_MARGIN: float
export(float) var L_MARGIN: float
export(float) var U_MARGIN: float
export(float) var D_MARGIN: float
const FILE_NAME: String = "user://puzzles.ini"
const START_SECTION_NAME: String = "LVL_"
var puzzle_config_file: ConfigFile
var curr_section_name: String
var curr_config_file_keys: PoolStringArray

func _ready():
	self.set_puzzle_config_file()

func _on_Button_pressed():
	var new_section_name: String = self.START_SECTION_NAME + str(1)
	self.set_curr_section_name(new_section_name)
	self.set_puzzle_config_file_keys()
	var dimensions: TupleInt = self.get_puzzle_dimensions()
	var r_l_margins: TupleFloat = TupleFloat.new(self.R_MARGIN, self.L_MARGIN)
	var u_d_margins: TupleFloat = TupleFloat.new(self.U_MARGIN, self.D_MARGIN)
	self.emit_signal("level_pushed", dimensions, r_l_margins, u_d_margins)
	self.emit_signal("puzzle_menu_appeared")
	self.visible = false
	self.send_config_file_to_board_game()

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

func get_puzzles() -> Array:
	return self.puzzle_config_file.get_value(self.curr_section_name,
	self.curr_config_file_keys[2])

func get_puzzles_states() -> Array:
	return self.puzzle_config_file.get_value(self.curr_section_name,
	self.curr_config_file_keys[3])

func send_config_file_to_board_game() -> void:
	var rules: Array = self.get_puzzle_rules()
	var puzzles: Array = self.get_puzzles()
	self.emit_signal("got_rules_puzzles", rules, puzzles)
