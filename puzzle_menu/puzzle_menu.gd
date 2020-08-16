extends Node2D
signal puzzle_button_was_pressed(cell_states)
signal got_puzzle_states(puzzle_states)
signal board_appeared()
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

func pop_out() -> void:
	self.visible = false


func _on_LevelMenu_got_puzzles_states(puzzles_states: Array) -> void:
	self.curr_puzzles_states = puzzles_states
	self.emit_signal("got_puzzle_states", puzzles_states)
