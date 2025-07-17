extends Node2D

@export var control_texture : Texture2D
@export var done_texture : Texture2D

@onready var write_sfx = $Writing

@export var line1 : Texture2D
@export var line2 : Texture2D
@export var line3 : Texture2D
@export var write1 : Texture2D
@export var write2 : Texture2D
@export var write3 : Texture2D

#@onready var anim = $Anim
@onready var s1 = $Paper/S1
@onready var s2 = $Paper/S2
@onready var s3 = $Paper/S3
@onready var sprites = [s1, s2, s3]

var k_to_idx = {"N":0,"D":1,"S":2}
@onready var lines_unshuffled = [line1, line2, line3]
@onready var lines = [line1, line2, line3]
@onready var writes = [write1, write2, write3]
var strokes = 0
var q = 1.0

func apply_controls():
	GameGlobals.controls.clear_controls()
	GameGlobals.controls.set_nice_name("Fill out your Taxes")
	GameGlobals.controls.apply_control(0, "N", control_texture)
	GameGlobals.controls.apply_control(3, "D", control_texture)
	GameGlobals.controls.apply_control(6, "S", control_texture)
	GameGlobals.controls.apply_control(10, "Enter", done_texture)

func reset_task():
	#anim.play("RESET")
	q = 1.0
	strokes = 0
	lines.shuffle()
	sprites[0].texture = lines[0]
	sprites[1].texture = lines[1]
	sprites[2].texture = lines[2]
	sprites[0].get_child(0).texture = null
	sprites[1].get_child(0).texture = null
	sprites[2].get_child(0).texture = null

func take_input(sc : String, release = false):
	if strokes < 3 and (sc == "N" or sc == "D" or sc == "S"):
		sprites[strokes].get_child(0).texture = writes[k_to_idx[sc]]
		if sprites[strokes].texture != lines_unshuffled[k_to_idx[sc]]:
			q = 0.0
		strokes += 1
		write_sfx.stop()
		write_sfx.play()
		#anim.stop()
		#anim.play("write")
	elif sc == "Enter":
		if strokes < 3:
			q = 0.0
		GameGlobals.task_manager.report_result({
			"quality": q,
			"chore": true,
			"chore_special": "taxes"
		})
		GameGlobals.task_manager.stop_task()

func release_input(sc : String):
	pass
