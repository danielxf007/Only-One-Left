extends Node2D
signal puzzle_button_was_pressed(cell_states)
signal board_appeared()
export(Array) var CELL_STATES: Array

func _ready():
	self.visible = false

func _on_Button_pressed():
	self.visible = false
	self.emit_signal("puzzle_button_was_pressed", self.CELL_STATES)
	self.emit_signal("board_appeared")


func _on_LevelMenu_puzzle_menu_appeared():
	self.visible = true
