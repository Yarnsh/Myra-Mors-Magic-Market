extends Node2D

@export var control_texture : Texture2D
@export var done_texture : Texture2D
@export var prepped_icon : Texture2D

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
	GameGlobals.controls.apply_control(3, "I", control_texture)
	GameGlobals.controls.apply_control(4, "N", control_texture)
	GameGlobals.controls.apply_control(5, "C", control_texture)
	GameGlobals.controls.apply_control(10, "Enter", done_texture)

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
		else:
			i1.show()
	elif sc == "N":
		if i2.visible:
			p2.restart()
			b2.show()
		else:
			i2.show()
	elif sc == "C":
		if i3.visible:
			p3.restart()
			b3.show()
		else:
			i3.show()
	elif sc == "Enter":
		var q = 0.0
		if b1.visible and b2.visible and b3.visible:
			q = 1.0
		GameGlobals.task_manager.report_result({
			"resource_name": "incense",
			"resource_count": 3,
			"icon": prepped_icon,
			"quality": q
		})
		GameGlobals.task_manager.stop_task()

func release_input(sc : String):
	pass
