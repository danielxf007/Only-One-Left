extends Node2D
signal board_dimensions_changed(dimensions)
signal cell_dim_changed(cell_dim)
class_name Board
export(Dictionary) var CELL_TEXTURES: Dictionary
export(PackedScene) var CELL_SCENE: PackedScene
var two_d_cell_array: TwoDimensionalArray

func _ready():
	self.two_d_cell_array = TwoDimensionalArray.new(TupleInt.new(0, 0), [])

func get_storage_case(dimension: TupleInt) -> String:
	var case: String = "00"
	var stor_sp: int = dimension.i*dimension.j
	var curr_stor_sp: int = self.two_d_cell_array.get_storage_space()
	if curr_stor_sp == stor_sp:
		case = "01"
	elif curr_stor_sp < stor_sp:
		case = "10"
	elif curr_stor_sp > stor_sp:
		case = "11"
	return case

func create(dimension: TupleInt, r_l_margins: Vector2,
 u_d_margins: Vector2, cell_states: Array) -> void:
	pass

func create_cells_row(n_rows: int) -> void:
	var cell: Cell
	var cell_row: Array
	var current_n_rows: int = self.two_d_cell_array.get_n_rows()
	var current_m_columns: int = self.two_d_cell_array.get_m_columns()
	var y_rows_created: int = 0
	var x_cells_created: int
	while y_rows_created < n_rows-current_n_rows:
		x_cells_created = 0
		cell_row = []
		while x_cells_created < current_m_columns:
			cell = self.CELL_SCENE.instance()
			cell_row.append(cell)
			self.add_child(cell)
			x_cells_created += 1
		self.two_d_cell_array.add_row(cell_row)
		y_rows_created += 1

func create_cells_column(m_columns: int) -> void:
	var cell: Cell
	var cell_column: Array
	var current_n_rows: int = self.two_d_cell_array.get_n_rows()
	var current_m_columns: int = self.two_d_cell_array.get_m_columns()
	var y_columns_created: int = 0
	var x_cells_created: int
	while y_columns_created < m_columns-current_m_columns:
		x_cells_created = 0
		cell_column = []
		while x_cells_created < current_n_rows:
			cell = self.CELL_SCENE.instance()
			cell_column.append(cell)
			self.add_child(cell)
			x_cells_created += 1
		self.two_d_cell_array.add_column(cell_column)
		y_columns_created += 1

func delete_cells_row(n_rows: int) -> void:
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


func delete_cells_column(m_columns: int) -> void:
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

func arrange_cells() -> void:
	pass

func edit_cells_state() -> void:
	pass

func set_cells_dim() -> void:
	pass
