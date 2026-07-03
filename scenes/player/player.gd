extends CharacterBody2D

@export var speed: float = 80.0

var _interactables_in_range: Array[Interactable] = []


func _physics_process(_delta: float) -> void:
	var input_direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and not _interactables_in_range.is_empty():
		_interactables_in_range[0].interact()


func _on_interaction_area_area_entered(area: Area2D) -> void:
	if area is Interactable:
		_interactables_in_range.append(area)


func _on_interaction_area_area_exited(area: Area2D) -> void:
	if area is Interactable:
		_interactables_in_range.erase(area)
