extends Node2D
signal got_g_dimensions_margins(dimensions, r_l_margins, u_d_margins)
class_name Game
export(float) var R_MARGIN: float
export(float) var L_MARGIN: float
export(float) var U_MARGIN: float
export(float) var D_MARGIN: float
var curr_rules: Array
var curr_solutions: Array
var curr_puzzles: Array


func _on_LevelMenu_got_g_dimensions(dimensions: TupleInt) -> void:
	var r_l_margins: TupleFloat = TupleFloat.new(self.R_MARGIN, self.L_MARGIN)
	var u_d_margins: TupleFloat = TupleFloat.new(self.U_MARGIN, self.D_MARGIN)
	self.emit_signal("got_g_dimensions_margins", dimensions, r_l_margins,
	u_d_margins)


func _on_LevelMenu_got_rules_solutions_puzzles(rules: Array, solutions: Array,
puzzles: Array) -> void:
	self.curr_rules = rules
	self.curr_solutions = solutions
	self.curr_puzzles = puzzles
