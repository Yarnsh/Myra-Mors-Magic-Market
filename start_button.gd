extends Button

func _ready() -> void:
	_on_mouse_exited()

func _on_mouse_entered() -> void:
	modulate = Color.WHITE

func _on_mouse_exited() -> void:
	modulate = Color.DIM_GRAY
