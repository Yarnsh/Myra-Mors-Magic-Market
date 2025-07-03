extends Node2D

@onready var anim = $Anim
@onready var text = $MarginContainer/MarginContainer/Label

func say(words):
	text.text = words
	anim.stop()
	anim.play("Say")
