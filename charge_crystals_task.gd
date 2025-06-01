extends Node2D

@export var control_texture : Texture2D
@export var done_texture : Texture2D

@onready var anim = $Anim
var charge = 0

func apply_controls():
	GameGlobals.controls.clear_controls()
	GameGlobals.controls.set_nice_name("Charge the Crystal")
	GameGlobals.controls.apply_control(0, "C", control_texture)
	GameGlobals.controls.apply_control(10, "Enter", done_texture)

func reset_task():
	anim.play("RESET")
	charge = 0

func take_input(sc : String):
	if sc == "C":
		anim.stop()
		anim.play("Ponder")
		charge += 1
	elif sc == "Enter":
		var q = 0.0
		if charge >= 10:
			q = 1.0
		GameGlobals.task_manager.report_result({
			"icon": null, #TODO
			"resource_name": "crystal",
			"resource_count": 8,
			"quality": q
		})
		GameGlobals.task_manager.stop_task()
