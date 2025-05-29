extends Control

@onready var time = $"../../Time"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation_degrees = (90.0 * (time.t / 360.0)) - 45.0
