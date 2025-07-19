extends Node2D

@onready var fire = $S1
@onready var f_scale = fire.scale
@onready var water = $Water
@onready var water2 = $Water2
@onready var smoke = $Smoke
@onready var anim = $Anim

@onready var water_sfx = $WaterSFX
@onready var fire_sfx = $FireSFX
@onready var extinguish_sfx = $ExtinguishSFX

@export var control_texture : Texture2D
@export var done_texture : Texture2D

var strength = 1.0
var holding = false

func apply_controls():
	GameGlobals.controls.clear_controls()
	GameGlobals.controls.set_nice_name("Put out the fire!!!")
	GameGlobals.controls.apply_control(4, "W", control_texture)
	GameGlobals.controls.apply_control(10, "Enter", done_texture)
	fire_sfx.play()

func reset_task():
	strength = 1.0
	holding = false
	fire.scale = f_scale
	fire.show()
	smoke.hide()
	water.hide()
	water2.hide()
	water_sfx.stop()
	fire_sfx.stop()

func take_input(sc : String):
	if sc == "W":
		holding = true
		anim.play("sprayed")
		water_sfx.play()
	elif sc == "Enter":
		GameGlobals.task_manager.report_result({
			"quality": 1.0 - strength,
			"chore": true
		})
		GameGlobals.task_manager.stop_task()

func release_input(sc : String):
	if sc == "W":
		if holding:
			holding = false
			anim.play("RESET")
			water_sfx.stop()

func _process(delta: float) -> void:
	if holding:
		water.show()
		water2.show()
		strength = max(0.0, strength - delta * 0.33)
		if strength <= 0.0:
			if !smoke.visible:
				smoke.show()
				smoke.restart()
				extinguish_sfx.play()
			fire.hide()
			fire_sfx.stop()
	else:
		water.hide()
		water2.hide()
		if strength > 0.0:
			strength = min(1.0, strength + delta)
	fire.scale = f_scale - (f_scale * (1.0 - strength) * 0.5)
