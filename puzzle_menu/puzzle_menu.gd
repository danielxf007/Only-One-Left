extends Node2D
signal puzzle_button_was_pressed(cell_states)
signal got_p_dimensions_margins(dimensions, r_l_margins, u_d_margins)
signal got_puzzle_states(puzzle_states)
signal send_change_puzzle_states()
signal puzzle_board_created()
signal board_appeared()
signal appeared(value)
export(float) var R_MARGIN: float
export(float) var L_MARGIN: float
export(float) var U_MARGIN: float
export(float) var D_MARGIN: float
export(Array) var CELL_STATES: Array
var curr_puzzles_states: Array

func _ready():
	self.pop_out()

func _on_Button_pressed():
	self.pop_out()
	self.emit_signal("puzzle_button_was_pressed", self.CELL_STATES)
	self.emit_signal("board_appeared")

func pop_up() -> void:
	self.visible = true
	self.emit_signal("appeared", true)

func pop_out() -> void:
	self.visible = false
	self.emit_signal("appeared", false)


func _on_LevelMenu_got_puzzles_states(puzzles_states: Array) -> void:
	self.curr_puzzles_states = puzzles_states
	self.emit_signal("got_puzzle_states", puzzles_states)


func _on_LevelMenu_got_p_dimensions(dimensions: TupleInt) -> void:
	var r_l_margins: TupleFloat = TupleFloat.new(self.R_MARGIN, self.L_MARGIN)
	var u_d_margins: TupleFloat = TupleFloat.new(self.U_MARGIN, self.D_MARGIN)
	self.emit_signal("got_p_dimensions_margins", dimensions, r_l_margins,
	u_d_margins)


func _on_PuzzleBoard_got_created() -> void:
	self.emit_signal("send_change_puzzle_states")


func _on_PuzzleBoard_cell_states_changed() -> void:
	self.emit_signal("puzzle_board_created")
