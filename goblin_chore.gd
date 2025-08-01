extends Node2D

@export var blast_texture : Texture2D
@export var done_texture : Texture2D

@onready var smack = $Smack
@onready var failure_sfx = $Failure

@onready var anim1 = $G1/G/Anim
@onready var punch1 = $G1/Punch
@onready var anim2 = $G2/G/Anim
@onready var punch2 = $G2/Punch
@onready var anim3 = $G3/G/Anim
@onready var punch3 = $G3/Punch
@onready var anim4 = $G4/G/Anim
@onready var punch4 = $G4/Punch
@onready var anim5 = $G5/G/Anim
@onready var punch5 = $G5/Punch
@onready var anim6 = $G6/G/Anim
@onready var punch6 = $G6/Punch

var gobs_kill = 0
var g1 = false
var g2 = false
var g3 = false
var g4 = false
var g5 = false
var g6 = false

func apply_controls():
	GameGlobals.controls.clear_controls()
	GameGlobals.controls.set_nice_name("Goblin Removal")
	GameGlobals.controls.apply_control(0, "G", blast_texture)
	GameGlobals.controls.apply_control(1, "O", blast_texture)
	GameGlobals.controls.apply_control(2, "B", blast_texture)
	GameGlobals.controls.apply_control(3, "L", blast_texture)
	GameGlobals.controls.apply_control(4, "I", blast_texture)
	GameGlobals.controls.apply_control(5, "N", blast_texture)
	GameGlobals.controls.apply_control(10, "Enter", done_texture)
	GameGlobals.game.set_popup_text("[center]Beat up the [b][color=red][font_size=30]GOBLIN[/font_size][/color][/b]s.[/center]")

func reset_task():
	anim1.stop()
	anim2.stop()
	anim3.stop()
	anim4.stop()
	anim5.stop()
	anim6.stop()
	anim1.play("Dance")
	anim2.play("Dance")
	anim3.play("Dance")
	anim4.play("Dance")
	anim5.play("Dance")
	anim6.play("Dance")
	g1 = false
	g2 = false
	g3 = false
	g4 = false
	g5 = false
	g6 = false
	gobs_kill = 0

func take_input(sc : String, release = false):
	if sc == "G":
		punch1.play()
	elif sc == "O":
		punch2.play()
	elif sc == "B":
		punch3.play()
	elif sc == "L":
		punch4.play()
	elif sc == "I":
		punch5.play()
	elif sc == "N":
		punch6.play()
	
	if sc == "G" and !g1:
		anim1.play("Die")
		g1 = true
		gobs_kill += 1
		smack.stop()
		smack.play()
	elif sc == "O" and !g2:
		anim2.play("Die")
		g2 = true
		gobs_kill += 1
		smack.stop()
		smack.play()
	elif sc == "B" and !g3:
		anim3.play("Die")
		g3 = true
		gobs_kill += 1
		smack.stop()
		smack.play()
	elif sc == "L" and !g4:
		anim4.play("Die")
		g4 = true
		gobs_kill += 1
		smack.stop()
		smack.play()
	elif sc == "I" and !g5:
		anim5.play("Die")
		g5 = true
		gobs_kill += 1
		smack.stop()
		smack.play()
	elif sc == "N" and !g6:
		anim6.play("Die")
		g6 = true
		gobs_kill += 1
		smack.stop()
		smack.play()
	elif sc == "Enter":
		GameGlobals.task_manager.report_result({
			"quality": float(gobs_kill)/6.0,
			"chore": true
		})
		GameGlobals.task_manager.stop_task()

func release_input(sc : String):
	pass

func failure():
	failure_sfx.play()
