extends Node2D

@onready var game = $"../.."
@export var control_texture : Texture2D

func apply_controls():
	GameGlobals.controls.clear_controls()
	GameGlobals.controls.set_nice_name("Prepare")
	
	var i = 0
	for o in game.recipes_list:
		if "prep_key" in o:
			GameGlobals.controls.apply_control(i, o["prep_key"], o.get("prep_icon", control_texture))
			i += 1
	
	GameGlobals.controls.apply_control(7, "Enter", control_texture)

func reset_task():
	pass

func take_input(sc : String, release = false):
	if sc == "Enter":
		GameGlobals.task_manager.report_result({"quality": 0.0})
		GameGlobals.task_manager.stop_task()
		return
	
	for o in game.recipes_list:
		if o.get("prep_key", "NOT A KEY") == sc:
			GameGlobals.task_manager.start_task(GameGlobals.task_manager.task_map[o.get("prep_task", "PotionPrep")], GameGlobals.task_manager.current_task_owner)
			break

func release_input(sc : String):
	pass
