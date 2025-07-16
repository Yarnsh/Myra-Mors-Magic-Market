extends Node2D

@onready var punch = $Punch
@onready var anim = $Punch/Anim

func _ready() -> void:
	punch.modulate = Color.TRANSPARENT

func play():
	punch.stop()
	punch.play("default")
	anim.stop()
	anim.play("punch")
