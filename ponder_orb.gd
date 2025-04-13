extends Node2D

@export var control_texture : Texture2D
@export var done_texture : Texture2D

@onready var anim = $Anim
@onready var cat = $C1/Sprite2D

func apply_controls():
	GameGlobals.controls.clear_controls()
	GameGlobals.controls.set_nice_name("Ponder the Orb")
	GameGlobals.controls.apply_control(0, "P", control_texture)
	GameGlobals.controls.apply_control(10, "Enter", done_texture)

func reset_task():
	anim.play("RESET")
	cat.modulate.a = 0.0

func take_input(sc : String):
	print("Task input: ", sc)
	if sc == "P":
		anim.stop()
		anim.play("Ponder")
		cat.modulate.a = min(1.0, cat.modulate.a + 0.2)
	elif sc == "Enter":
		GameGlobals.task_manager.report_result({
			"quality": cat.modulate.a
		})
		GameGlobals.task_manager.stop_task()
