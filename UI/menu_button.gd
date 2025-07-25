extends Control

@onready var anim = $Continue/Anim
@onready var rattle = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_continue_mouse_entered() -> void:
	rattle.stop()
	rattle.play()
	anim.play("Extend")

func _on_continue_mouse_exited() -> void:
	rattle.stop()
	rattle.play()
	anim.play("Retract")
