extends Button

@export var bg : Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_mouse_exited() 

func _on_mouse_entered() -> void:
	bg.modulate = Color.WHITE

func _on_mouse_exited() -> void:
	bg.modulate = Color.DIM_GRAY
