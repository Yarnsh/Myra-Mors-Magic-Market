extends Node2D

@export var control_texture : Texture2D
@export var done_texture : Texture2D

@onready var hmm = $Hmm

@onready var anim = $Anim
@onready var sprites_parent = $C1
var selected = -1
const good_list = [0, 3, 6]

func apply_controls():
	GameGlobals.controls.clear_controls()
	GameGlobals.controls.set_nice_name("Ponder the Orb")
	GameGlobals.controls.apply_control(0, "P", control_texture)
	GameGlobals.controls.apply_control(10, "Enter", done_texture)
	GameGlobals.game.set_popup_text("[center][b][color=red][font_size=30]P[/font_size][/color][/b]onder until you land on a good result.[/center]")

func reset_task():
	anim.play("RESET")
	selected = -1
	for c in sprites_parent.get_children():
		c.hide()

func take_input(sc : String, release = false):
	if sc == "P":
		anim.stop()
		anim.play("Ponder")
		hmm.stop()
		hmm.play()
		if selected < 0:
			selected = randi_range(0, len(sprites_parent.get_children())-1)
		else:
			selected = (selected + 1) % len(sprites_parent.get_children())
		var i = 0
		for c in sprites_parent.get_children():
			if i == selected:
				c.show()
			else:
				c.hide()
			i += 1
	elif sc == "Enter":
		var q = 0.0
		if selected >= 0:
			q = 0.1
		if selected in good_list:
			q = 1.0
		GameGlobals.task_manager.report_result({
			"quality": q,
			"tip_mult": 3.0
		})
		GameGlobals.task_manager.stop_task()

func release_input(sc : String):
	pass
