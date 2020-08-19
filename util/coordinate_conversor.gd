extends Node
signal got_cell(cell_coord)
class_name CoordinateConversor
const HALF: float = 0.5
var board_dim: TupleInt
var board_top_left_start_pos: Vector2
var cell_dim: Vector2
var enabled: bool

func set_board_dim(new_board_dim: TupleInt) -> void:
	self.board_dim = new_board_dim

func set_board_top_left_start_pos(new_board_top_left_start_pos: Vector2) -> void:
	self.board_top_left_start_pos = new_board_top_left_start_pos

func set_cell_dim(new_cell_dim: Vector2) -> void:
	self.cell_dim = new_cell_dim

func set_enabled(new_value: bool) -> void:
	self.enabled = new_value
	self.set_process_input(new_value)

func get_upper_bound_x() -> float:
	return self.board_top_left_start_pos.x+self.cell_dim.x*(self.board_dim.j+1)

func get_upper_bound_y() -> float:
	return self.board_top_left_start_pos.y+self.cell_dim.y*(self.board_dim.i+1)

func pos_in_board(pos: Vector2) -> bool:
	return (UtilFunctions.number_in_range_float(
	self.board_top_left_start_pos.x, self.get_upper_bound_x(), pos.x) and 
	UtilFunctions.number_in_range_float(self.board_top_left_start_pos.y,
	self.get_upper_bound_y(), pos.y))

func get_cell_indexes(pos: Vector2) -> TupleInt:
	var vector: Vector2 = pos - self.board_top_left_start_pos
	var row_index: int = int(floor(vector.y/self.cell_dim.y))
	var column_index: int = int(floor(vector.x/self.cell_dim.x))
	var indexes: TupleInt = TupleInt.new(row_index, column_index)
	return indexes

func send_board_cell(event_pos:Vector2) -> void:
		if self.pos_in_board(event_pos):
			var cell_indexes: TupleInt = self.get_cell_indexes(event_pos)
			self.emit_signal("got_cell", cell_indexes)

func _input(event):
	if event is InputEventScreenTouch and not self.state:
		var event_pos: Vector2 = event.position
		self.send_board_cell(event_pos)
	elif event is InputEventMouseButton and not self.state:
		if event.get_button_index() == BUTTON_LEFT:
			var event_pos: Vector2 = event.position
			self.send_board_cell(event_pos)
