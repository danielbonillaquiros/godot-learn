extends Node2D

@onready var _ground: TileMapLayer = $Ground
@onready var _camera: Camera2D = $Player/Camera2D


func _ready() -> void:
	var used_rect: Rect2i = _ground.get_used_rect()
	var tile_size: Vector2i = _ground.tile_set.tile_size
	var top_left: Vector2 = _ground.to_global(Vector2(used_rect.position * tile_size))
	var bottom_right: Vector2 = _ground.to_global(Vector2(used_rect.end * tile_size))
	_camera.limit_left = int(top_left.x)
	_camera.limit_top = int(top_left.y)
	_camera.limit_right = int(bottom_right.x)
	_camera.limit_bottom = int(bottom_right.y)
