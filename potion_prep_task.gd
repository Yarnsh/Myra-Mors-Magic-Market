extends Node2D

@export var r_texture : Texture2D
@export var g_texture : Texture2D
@export var b_texture : Texture2D
@export var y_texture : Texture2D
@export var done_texture : Texture2D
@export var prepped_icon : Texture2D

@onready var c_anim = $CauldronAnim
@onready var pr = $PotionRed
@onready var pb = $PotionBlue
@onready var py = $PotionYellow
@onready var pg = $PotionGreen

func apply_controls():
	GameGlobals.controls.clear_controls()
	GameGlobals.controls.set_nice_name("Potion of Potions")
	GameGlobals.controls.apply_control(0, "R", r_texture)
	GameGlobals.controls.apply_control(2, "G", g_texture)
	GameGlobals.controls.apply_control(6, "B", b_texture)
	GameGlobals.controls.apply_control(8, "Y", y_texture)
	GameGlobals.controls.apply_control(10, "Enter", done_texture)

func reset_task():
	c_anim.play("RESET")
	pr.show()
	pb.show()
	py.show()
	pg.show()

func take_input(sc : String, release = false):
	if sc == "B":
		if pb.visible:
			c_anim.stop()
			c_anim.play("ItemAdded")
		pb.hide()
	elif sc == "Y":
		if py.visible:
			c_anim.stop()
			c_anim.play("ItemAdded")
		py.hide()
	elif sc == "R":
		if pr.visible:
			c_anim.stop()
			c_anim.play("ItemAdded")
		pr.hide()
	elif sc == "G":
		if pg.visible:
			c_anim.stop()
			c_anim.play("ItemAdded")
		pg.hide()
	elif sc == "Enter":
		var quality = 0.0
		if !pr.visible:
			quality += 0.25
		if !pg.visible:
			quality += 0.25
		if !pb.visible:
			quality += 0.25
		if !py.visible:
			quality += 0.25
		GameGlobals.task_manager.report_result({
			"icon": prepped_icon,
			"resource_name": "potion",
			"resource_count": 4,
			"timer": 3000,
			"quality": quality
		})
		GameGlobals.task_manager.stop_task()
