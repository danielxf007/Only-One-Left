extends Sprite

class_name PuzzleCell
var textures: Array
var dimensions: Vector2
var current_state: int
var id: int

func set_textures(new_textures: Array) -> void:
	self.textures = new_textures
 
func set_state(new_state: int ) -> void:
	self.current_state = new_state
	self.texture = self.textures[new_state]
	if self.has_to_be_scaled():
		self.adjust_scale()

func set_pos(new_pos: Vector2) -> void:
	self.global_position = new_pos

func get_pos() -> Vector2:
	return self.global_position

func set_dim(dim: Vector2) -> void:
	self.dimensions = dim

func set_id(new_id: int) -> void:
	self.id = new_id

func get_id() -> int:
	return self.id

func has_to_be_scaled() -> bool:
	return self.texture.get_size() != self.dimensions

func adjust_scale() -> void:
	var texture_dim: Vector2 = self.texture.get_size()
	self.scale.x = (dimensions.x/texture_dim.x)
	self.scale.y = (dimensions.y/texture_dim.y)

func destroy() -> void:
	self.visible = false
	self.queue_free()
