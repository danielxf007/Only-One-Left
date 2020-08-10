extends Node

class_name TwoDimensionalArray

var dimensions: TupleInt
var array: Array

func _init(dim: TupleInt, arr: Array) -> void:
	self.dimensions = dim
	self.array = arr

func set_dimensions(dim: TupleInt) -> void:
	self.dimensions = dim

func set_n_rows(n_rows: int) -> void:
	self.dimensions.i = n_rows

func set_m_columns(m_columns: int) -> void:
	self.dimensions.j = m_columns

func set_array(arr: Array) -> void:
	self.array = arr

func get_dimensions() -> TupleInt:
	return self.dimensions

func get_array() -> Array:
	return self.array

func add_row(row: Array) -> void:
	self.array.append(row)

func add_column(column: Array) -> void:
	var row: Array
	for index in range(0, column.size()):
		row = self.array[index]
		row.append(column[index])

func delete_row() -> Array:
	return self.array.pop_back()

func delete_column() -> Array:
	var column: Array = []
	for row in self.array:
		column.append(row.pop_back())
	return column

func valid_indexes(row_index: int, column_index: int) -> bool:
	return (UtilFunctions.number_in_range_integer(0, self.dimensions.i-1,
	row_index) and UtilFunctions.number_in_range_integer(0, self.dimensions.j-1,
	column_index))

func get_element(row_index: int, column_index: int):
	if self.valid_indexes(row_index, column_index):
		return self.array[row_index][column_index]
	return null

func is_empty() -> bool:
	return self.array.empty()

func get_storage_space() -> int:
	return self.dimensions.i*self.dimensions.j

func get_n_rows() -> int:
	return self.array.size()

func get_m_columns() -> int:
	var m_columns: int
	if self.is_empty():
		m_columns = 0
	else:
		m_columns = self.array[0].size()
	return m_columns
