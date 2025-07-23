extends Node2D

@export var control_texture1 : Texture2D
@export var control_texture2 : Texture2D
@export var control_texture3 : Texture2D
@export var control_texture1b : Texture2D
@export var control_texture2b : Texture2D
@export var control_texture3b : Texture2D

@export var done_texture : Texture2D
@export var prepped_icon : Texture2D

@onready var lighter = $Lighter
@onready var put_thing = $PutThing
@onready var done_sfx = $Done

@onready var i1 = $I1
@onready var i2 = $I2
@onready var i3 = $I3
@onready var b1 = $IB1
@onready var p1 = $IB1/GPUParticles2D
@onready var b2 = $IB2
@onready var p2 = $IB2/GPUParticles2D
@onready var b3 = $IB3
@onready var p3 = $IB3/GPUParticles2D

func apply_controls():
	GameGlobals.controls.clear_controls()
	GameGlobals.controls.set_nice_name("Light some Incense")
	GameGlobals.controls.apply_control(3, "I", control_texture1)
	GameGlobals.controls.apply_control(4, "N", control_texture2)
	GameGlobals.controls.apply_control(5, "C", control_texture3)
	GameGlobals.controls.apply_control(10, "Enter", done_texture)
	GameGlobals.game.set_popup_text("[center]Place and light each stick of [b][color=red][font_size=30]INC[/font_size][/color][/b]ense.[/center]")

func reset_task():
	i1.hide()
	i2.hide()
	i3.hide()
	b1.hide()
	b2.hide()
	b3.hide()

func take_input(sc : String, release = false):
	if sc == "I":
		if i1.visible:
			p1.restart()
			b1.show()
			lighter.stop()
			lighter.play()
		else:
			i1.show()
			put_thing.stop()
			put_thing.play()
			GameGlobals.controls.apply_control(3, "I", control_texture1b)
	elif sc == "N":
		if i2.visible:
			p2.restart()
			b2.show()
			lighter.stop()
			lighter.play()
		else:
			i2.show()
			put_thing.stop()
			put_thing.play()
			GameGlobals.controls.apply_control(4, "N", control_texture2b)
	elif sc == "C":
		if i3.visible:
			p3.restart()
			b3.show()
			lighter.stop()
			lighter.play()
		else:
			i3.show()
			put_thing.stop()
			put_thing.play()
			GameGlobals.controls.apply_control(5, "C", control_texture3b)
	elif sc == "Enter":
		var q = 0.0
		if b1.visible and b2.visible and b3.visible:
			q = 1.0
			done_sfx.play()
		GameGlobals.task_manager.report_result({
			"resource_name": "incense",
			"resource_count": 3,
			"icon": prepped_icon,
			"quality": q
		})
		GameGlobals.task_manager.stop_task()

func release_input(sc : String):
	pass
