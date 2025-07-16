extends Node2D

@onready var punch = $Punch
@onready var anim = $Punch/Anim
@onready var sfx = $AudioStreamPlayer

func _ready() -> void:
	punch.modulate = Color.TRANSPARENT

func play():
	punch.stop()
	punch.play("default")
	anim.stop()
	anim.play("punch")
	sfx.stop()
	sfx.play()
