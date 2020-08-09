extends Node

class_name TwoDimensionalArray

var dimensions: TupleInt
var array: Array

func _init(dim: TupleInt, arr: Array):
	self.dimensions = dim
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

func delete_row(row_index: int) -> void:
	self.array.remove(row_index)

func delete_column(column_index: int) -> void:
	for row in self.array:
		row.remove(column_index)

func valid_indexes(indexes: TupleInt) -> bool:
	return (UtilFunctions.number_in_range_integer(0, self.dimensions.i-1,
	indexes.i) and UtilFunctions.number_in_range_integer(0, self.dimensions.j-1,
	indexes.j))

func get_element(indexes: TupleInt):
	if self.valid_indexes(indexes):
		return self.array[indexes.i][indexes.j]
	return null
