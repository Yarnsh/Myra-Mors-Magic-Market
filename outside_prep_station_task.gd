extends Node2D

@export var control_texture : Texture2D

func apply_controls():
	GameGlobals.controls.clear_controls()
	GameGlobals.controls.set_nice_name("Prepare")
	# TODO: take this from what ingredients we have for this level
	GameGlobals.controls.apply_control(0, "P", control_texture)

func reset_task():
	pass

func take_input(sc : String):
	# TODO: start different tasks depending on what we picked
	# Start the new task with the prep station as the owner
	GameGlobals.task_manager.start_task(GameGlobals.task_manager.task_map["PotionPrep"], GameGlobals.task_manager.current_task_owner)

func _on_visibility_changed() -> void:
	$CanvasLayer.visible = visible
