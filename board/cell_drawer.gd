extends Node2D

var board_dim: TupleInt
var board_cell_dim: Vector2
var board_start_pos: Vector2
export(String) var LINE_COLOR: String
export(bool) var FILL_RECT: bool
export(float) var LINE_WIDTH: float


func _on_Board_board_changed(dimensions, cell_dim, start_pos):
	self.board_dim = dimensions
	self.board_cell_dim = cell_dim
	self.board_start_pos = start_pos - (cell_dim/2)
	self.update()

func _draw():
	var rect: Rect2
	var row_offset: float
	var column_offset: float
	var x_pos: float
	var y_pos: float
	var pos: Vector2
	for row_index in range(0, self.board_dim.i):
		row_offset = self.board_cell_dim.y*row_index
		y_pos = self.board_start_pos.y + row_offset
		for column_index in range(0, self.board_dim.j):
			column_offset = self.board_cell_dim.x*column_index
			x_pos = self.board_start_pos.x + column_offset
			pos = Vector2(x_pos, y_pos)
			rect =  Rect2(pos, self.board_cell_dim)
			self.draw_rect(rect, self.LINE_COLOR, self.FILL_RECT,
			self.LINE_WIDTH)
