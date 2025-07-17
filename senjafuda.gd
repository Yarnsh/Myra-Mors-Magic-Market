extends Node2D

@export var control_texture : Texture2D
@export var done_texture : Texture2D

@onready var swipe = $Swipe

@onready var anim = $Anim
@onready var wanim = $WrongAnim
@onready var s1 = $Slip/S1
@onready var s2 = $Slip/S2
@onready var s3 = $Slip/S3
@onready var s4 = $Slip/S4
@onready var s5 = $Slip/S5
@onready var sl = [s1, s2, s3, s4, s5]
var strokes = 0

func apply_controls():
	GameGlobals.controls.clear_controls()
	GameGlobals.controls.set_nice_name("Draw the Senjafuda")
	GameGlobals.controls.apply_control(3, "A", control_texture)
	GameGlobals.controls.apply_control(5, "L", control_texture)
	GameGlobals.controls.apply_control(10, "Enter", done_texture)

func reset_task():
	anim.play("RESET")
	strokes = 0
	s1.hide()
	s2.hide()
	s3.hide()
	s4.hide()
	s5.hide()

func take_input(sc : String, release = false):
	if sc == "A":
		if strokes % 2 == 1 and strokes < 5:
			strokes += 1
			sl[strokes-1].show()
			anim.stop()
			anim.play(str(strokes))
			swipe.stop()
			swipe.play()
		else:
			wanim.stop()
			wanim.play("Wrong")
	elif sc == "L":
		if strokes % 2 == 0 and strokes < 5:
			strokes += 1
			sl[strokes-1].show()
			anim.stop()
			anim.play(str(strokes))
			swipe.stop()
			swipe.play()
		else:
			wanim.stop()
			wanim.play("Wrong")
	elif sc == "Enter":
		var q = strokes * 0.2
		GameGlobals.task_manager.report_result({
			"quality": q
		})
		GameGlobals.task_manager.stop_task()

func release_input(sc : String):
	pass
