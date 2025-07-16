extends Node2D

@export var control_texture : Texture2D
@export var done_texture : Texture2D

@onready var anim = $Anim
@onready var hammer = $Hammer
@onready var h_r = hammer.rotation
var q = 0.0
var strength = 0.0
var holding = false

func apply_controls():
	GameGlobals.controls.clear_controls()
	GameGlobals.controls.set_nice_name("Bong the Gong")
	GameGlobals.controls.apply_control(4, "G", control_texture)
	GameGlobals.controls.apply_control(10, "Enter", done_texture)

func reset_task():
	anim.play("RESET")
	q = 0.0
	strength = 0.0
	holding = false

func take_input(sc : String):
	if sc == "G":
		holding = true
	elif sc == "Enter":
		GameGlobals.task_manager.report_result({
			"quality": q,
			"vibe_gain_mult": 5.0 * q
		})
		GameGlobals.task_manager.stop_task()

func release_input(sc : String):
	if sc == "G":
		if holding:
			q = max(q, strength)
			holding = false
			if strength < 1.0 and q < 1.0:
				anim.stop()
				anim.play("Ding")
			else:
				anim.play("Bong")

func _process(delta: float) -> void:
	if holding:
		strength = min(1.0, strength + delta)
	else:
		strength = max(0.0, strength - (delta * 15.0))
	hammer.rotation = h_r + (strength * PI)
