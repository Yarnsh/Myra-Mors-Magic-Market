extends Node2D

@export var r_texture : Texture2D
@export var g_texture : Texture2D
@export var b_texture : Texture2D
@export var y_texture : Texture2D
@export var done_texture : Texture2D
@export var prepped_icon : Texture2D

@onready var plop = $Plop

@onready var c_anim = $CauldronAnim
@onready var pr = $PotionRed/AnimationPlayer
var pr_in = false
@onready var pb = $PotionBlue/AnimationPlayer
var pb_in = false
@onready var py = $PotionYellow/AnimationPlayer
var py_in = false
@onready var pg = $PotionGreen/AnimationPlayer
var pg_in = false

func apply_controls():
	GameGlobals.controls.clear_controls()
	GameGlobals.controls.set_nice_name("Potion of Healing")
	GameGlobals.controls.apply_control(0, "R", r_texture)
	GameGlobals.controls.apply_control(2, "H", g_texture)
	GameGlobals.controls.apply_control(6, "B", b_texture)
	GameGlobals.controls.apply_control(8, "L", y_texture)
	GameGlobals.controls.apply_control(10, "Enter", done_texture)
	GameGlobals.game.set_popup_text("[center]Drop in a [b][color=red][font_size=30]R[/font_size][/color][/b]uby, [b][color=red][font_size=30]H[/font_size][/color][/b]erbs, a [b][color=red][font_size=30]L[/font_size][/color][/b]emon, and a [b][color=red][font_size=30]B[/font_size][/color][/b]reakfast sandwich.[/center]")

func reset_task():
	c_anim.play("RESET")
	pr.play("RESET")
	pr_in = false
	pb.play("RESET")
	pb_in = false
	py.play("RESET")
	py_in = false
	pg.play("RESET")
	pg_in = false

func take_input(sc : String, release = false):
	if sc == "B":
		if !pb_in:
			c_anim.stop()
			c_anim.play("ItemAdded")
			plop.stop()
			plop.play()
			pb.play("Dunk")
		pb_in = true
	elif sc == "L":
		if !py_in:
			c_anim.stop()
			c_anim.play("ItemAdded")
			plop.stop()
			plop.play()
			py.play("Dunk")
		py_in = true
	elif sc == "R":
		if !pr_in:
			c_anim.stop()
			c_anim.play("ItemAdded")
			plop.stop()
			plop.play()
			pr.play("Dunk")
		pr_in = true
	elif sc == "H":
		if !pg_in:
			c_anim.stop()
			c_anim.play("ItemAdded")
			plop.stop()
			plop.play()
			pg.play("Dunk")
		pg_in = true
	elif sc == "Enter":
		var quality = 0.0
		if pr_in:
			quality += 0.25
		if pg_in:
			quality += 0.25
		if pb_in:
			quality += 0.25
		if py_in:
			quality += 0.25
		GameGlobals.task_manager.report_result({
			"icon": prepped_icon,
			"resource_name": "potion",
			"resource_count": 4,
			"timer": 3000,
			"quality": quality
		})
		GameGlobals.task_manager.stop_task()

func release_input(sc : String):
	pass
