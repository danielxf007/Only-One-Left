extends Sprite

class_name PuzzleCell
var dimensions: Vector2
var current_state: int
var texture_fill: float

func set_state(new_state: int, new_texture: Texture) -> void:
	self.current_state = new_state
	self.texture = new_texture
	if self.has_to_be_scaled():
		self.adjust_scale()

func set_pos(new_pos: Vector2) -> void:
	self.global_position = new_pos

func get_pos() -> Vector2:
	return self.global_position

func set_dim(dim: Vector2) -> void:
	self.dimensions = dim

func set_texture_fill(new_texture_fill: float) -> void:
	self.texture_fill = new_texture_fill

func has_to_be_scaled() -> bool:
	return self.texture.get_size() != self.dimensions

func adjust_scale() -> void:
	var texture_dim: Vector2 = self.texture.get_size()
	self.scale.x = (dimensions.x/texture_dim.x)*self.texture_fill
	self.scale.y = (dimensions.y/texture_dim.y)*self.texture_fill

func destroy() -> void:
	self.visible = false
	self.queue_free()
