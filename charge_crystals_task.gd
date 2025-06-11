extends Node2D

@export var control_texture : Texture2D
@export var done_texture : Texture2D
@export var prepped_icon : Texture2D

@onready var anim = $Anim
@onready var anim2 = $Anim2
var charge = 0

func apply_controls():
	GameGlobals.controls.clear_controls()
	GameGlobals.controls.set_nice_name("Charge the Crystal")
	GameGlobals.controls.apply_control(0, "C", control_texture)
	GameGlobals.controls.apply_control(10, "Enter", done_texture)

func reset_task():
	anim.play("RESET")
	charge = 0

func take_input(sc : String, release = false):
	if sc == "C":
		anim.stop()
		anim.play("Ponder")
		if charge < 10:
			anim2.stop()
			anim2.play("Ponder")
		charge += 1
		if charge == 10:
			anim2.stop()
			anim2.play("shining")
	elif sc == "Enter":
		var q = 0.0
		if charge >= 10:
			q = 1.0
		GameGlobals.task_manager.report_result({
			"resource_name": "crystal",
			"resource_count": 8,
			"icon": prepped_icon,
			"quality": q
		})
		GameGlobals.task_manager.stop_task()
