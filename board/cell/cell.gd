extends Sprite
signal was_selected(cell)
signal was_deselected(cell)
class_name Cell
const SELECT_COLORS: Array = ["ffffff", "50ffffff"]
const DISABLED_STATE: String = '000'
export(Dictionary) var TEXTURE_STATE: Dictionary
var current_state: String = '001'
var selected: bool
var coord: TupleInt

func _ready():
	self.texture = self.TEXTURE_STATE[self.current_state]

func set_on_board(board_pos: Vector2, board_coord: TupleInt) -> void:
	self.global_position = board_pos
	self.coord = board_coord

func get_pos() -> Vector2:
	return self.global_position

func get_coord() -> TupleInt:
	return self.coord

func select() -> void:
	self.selected = not self.selected
	self.self_modulate = self.SELECT_COLORS[int(self.selected)]
	if self.selected:
		self.emit_signal("was_selected", self)
	else:
		self.emit_signal("was_deselected", self)

func is_enabled() -> bool:
	return self.current_state != self.DISABLED_STATE
	
func change_state(new_state: String) -> void:
	if self.is_enabled():
		self.texture = self.TEXTURE_STATE[new_state]
		self.current_state = new_state

func set_dim(dimensions: Vector2) -> void:
	var texture_dim: Vector2 = self.texture.get_size()
	self.scale.x = texture_dim.x/dimensions.x
	self.scale.x = texture_dim.y/dimensions.y

func destroy() -> void:
	self.visible = false
	self.queue_free()
