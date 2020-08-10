extends Node2D
signal level_pushed(dimensions, r_l_margins, u_d_margins)
signal puzzle_menu_appeared()
export(int) var N_ROWS: int
export(int) var M_COLUMNS: int
export(float) var R_MARGIN: float
export(float) var L_MARGIN: float
export(float) var U_MARGIN: float
export(float) var D_MARGIN: float

func _on_Button_pressed():
	var dimensions: TupleInt = TupleInt.new(self.N_ROWS, self.M_COLUMNS)
	var r_l_margins: TupleFloat = TupleFloat.new(self.R_MARGIN, self.L_MARGIN)
	var u_d_margins: TupleFloat = TupleFloat.new(self.U_MARGIN, self.D_MARGIN)
	self.emit_signal("level_pushed", dimensions, r_l_margins, u_d_margins)
	self.emit_signal("puzzle_menu_appeared")
	self.visible = false
