extends Node2D
signal board_changed(dimensions, cell_dim, start_pos)
class_name Board
export(Array) var CELL_TEXTURES: Array
export(PackedScene) var CELL_SCENE: PackedScene
export(float) var CELL_TEXTURE_FILL: float
const HALF: float = 0.5
var two_d_cell_array: TwoDimensionalArray

func _ready():
	self.two_d_cell_array = TwoDimensionalArray.new(TupleInt.new(0, 0), [])
	self.pop_out()

func get_storage_case(dimension: TupleInt) -> String:
	var case: String
	var stor_sp: int = dimension.i*dimension.j
	var curr_stor_sp: int = self.two_d_cell_array.get_storage_space()
	if not curr_stor_sp:
		case = "00"
	elif curr_stor_sp == stor_sp:
		case = "01"
	elif curr_stor_sp < stor_sp:
		case = "10"
	elif curr_stor_sp > stor_sp:
		case = "11"
	return case

func get_view_port_size(r_l_marg: TupleFloat, u_d_marg: TupleFloat) -> Vector2:
	var curr_v_p_sz: Vector2 = self.get_viewport().size
	var width: float = (curr_v_p_sz.x-(r_l_marg.i+r_l_marg.j))
	var height: float = (curr_v_p_sz.y-(u_d_marg.i+u_d_marg.j))
	var new_v_p_sz: Vector2 = Vector2(width, height)
	return new_v_p_sz

func get_cell_dim(view_port_sz: Vector2, board_dim: TupleInt) -> Vector2:
	var width: float = view_port_sz.x/float(board_dim.j)
	var height: float = view_port_sz.y/float(board_dim.i) 
	var cell_dim: Vector2 = Vector2(width, height)
	return cell_dim

func get_start_pos(r_margin: float, d_margin: float, 
cell_dim: Vector2) -> Vector2:
	return Vector2(r_margin+(cell_dim.x*self.HALF),
	d_margin+(cell_dim.y*self.HALF))

func create(dimensions: TupleInt, r_l_margins: TupleFloat,
u_d_margins: TupleFloat) -> void:
	var case: String = self.get_storage_case(dimensions)
	var cell_dim: Vector2
	var start_pos: Vector2
	var current_rows: int
	var current_columns: int
	if case != "01":
		var view_port_sz: Vector2 = self.get_view_port_size(r_l_margins,
		u_d_margins)
		cell_dim = self.get_cell_dim(view_port_sz, dimensions)
		start_pos = self.get_start_pos(r_l_margins.i, u_d_margins.j, cell_dim)
		self.emit_signal("board_changed", dimensions, cell_dim, start_pos)
	match case:
		"00":
			self.create_rows_cell(dimensions)
			self.set_cells_dim(cell_dim)
			self.arrange_cells(cell_dim, start_pos)
		"10":
			current_rows = self.two_d_cell_array.get_n_rows()
			current_columns = self.two_d_cell_array.get_m_columns()
			if current_rows < dimensions.i:
				self.create_rows_cell(dimensions)
			if current_columns < dimensions.j:
				self.create_columns_cell(dimensions)
		"11":
			current_rows = self.two_d_cell_array.get_n_rows()
			current_columns = self.two_d_cell_array.get_m_columns()
			if current_rows > dimensions.i:
				self.delete_rows_cell(dimensions.i)
			if current_columns > dimensions.j:
				self.delete_columns_cell(dimensions.j)
	if case != "01":
		self.set_cells_texture_fill(self.CELL_TEXTURE_FILL)

func create_rows_cell(dimensions: TupleInt) -> void:
	var cell: Cell
	var cell_row: Array
	var current_n_rows: int = self.two_d_cell_array.get_n_rows()
	var y_rows_created: int = 0
	var x_cells_created: int
	while y_rows_created < dimensions.i-current_n_rows:
		x_cells_created = 0
		cell_row = []
		while x_cells_created < dimensions.j:
			cell = self.CELL_SCENE.instance()
			cell_row.append(cell)
			self.add_child(cell)
			x_cells_created += 1
		self.two_d_cell_array.add_row(cell_row)
		y_rows_created += 1
	self.two_d_cell_array.set_dimensions(dimensions)

func create_columns_cell(dimensions: TupleInt) -> void:
	var cell: Cell
	var cell_column: Array
	var current_m_columns: int = self.two_d_cell_array.get_m_columns()
	var y_columns_created: int = 0
	var x_cells_created: int
	while y_columns_created < dimensions.j-current_m_columns:
		x_cells_created = 0
		cell_column = []
		while x_cells_created < dimensions.i:
			cell = self.CELL_SCENE.instance()
			cell_column.append(cell)
			self.add_child(cell)
			x_cells_created += 1
		self.two_d_cell_array.add_column(cell_column)
		y_columns_created += 1
	self.two_d_cell_array.set_dimensions(dimensions)

func delete_rows_cell(n_rows: int) -> void:
	var cell: Cell
	var cell_row: Array
	var current_n_rows: int = self.two_d_cell_array.get_n_rows()
	var y_rows_deleted: int = 0
	while y_rows_deleted < current_n_rows-n_rows:
		cell_row = self.two_d_cell_array.delete_row()
		for index in range(0, cell_row.size()):
			cell = cell_row[index]
			cell.destroy()
		y_rows_deleted += 1
	self.two_d_cell_array.set_n_rows(n_rows)


func delete_columns_cell(m_columns: int) -> void:
	var cell: Cell
	var cell_column: Array
	var current_m_columns: int = self.two_d_cell_array.get_m_columns()
	var y_columns_deleted: int = 0
	while y_columns_deleted < current_m_columns-m_columns:
		cell_column = self.two_d_cell_array.delete_column()
		for index in range(0, cell_column.size()):
			cell = cell_column[index]
			cell.destroy()
		y_columns_deleted += 1
	self.two_d_cell_array.set_m_columns(m_columns)

func set_cells_dim(new_dimensions: Vector2) -> void:
	var cell: Cell
	for row in self.two_d_cell_array.get_array():
		for column_index in range(0, row.size()):
			cell = row[column_index]
			cell.set_dim(new_dimensions)

func arrange_cells(cell_dim: Vector2, start_pos: Vector2) -> void:
	var cell: Cell
	var row_offset: float
	var column_offset: float
	var n_rows: int = self.two_d_cell_array.get_n_rows()
	var m_columns: int = self.two_d_cell_array.get_m_columns()
	var cell_pos: Vector2
	var x_pos: float
	var y_pos: float
	for row_index in range(0, n_rows):
		row_offset = cell_dim.y*row_index
		y_pos = start_pos.y + row_offset
		for column_index in range(0, m_columns):
			cell = self.two_d_cell_array.get_element(row_index, column_index)
			column_offset = cell_dim.x*column_index
			x_pos = start_pos.x + column_offset
			cell_pos = Vector2(x_pos, y_pos)
			cell.set_pos(cell_pos)

func change_cells_state(cell_states: Array) -> void:
	var cell: Cell
	var n_rows: int = self.two_d_cell_array.get_n_rows()
	var m_columns: int = self.two_d_cell_array.get_m_columns()
	var index = 0
	var texture: Texture
	for row_index in range(0, n_rows):
		for column_index in range(0, m_columns):
			cell = self.two_d_cell_array.get_element(row_index, column_index)
			texture = self.CELL_TEXTURES[cell_states[index]]
			cell.set_state(cell_states[index], texture)
			index += 1

func set_cells_texture_fill(cell_texture_fill: float) -> void:
	var cell: Cell
	var n_rows: int = self.two_d_cell_array.get_n_rows()
	var m_columns: int = self.two_d_cell_array.get_m_columns()
	for row_index in range(0, n_rows):
		for column_index in range(0, m_columns):
			cell = self.two_d_cell_array.get_element(row_index, column_index)
			cell.set_texture_fill(cell_texture_fill)

func pop_up() -> void:
	self.visible = true

func pop_out() -> void:
	self.visible = false
