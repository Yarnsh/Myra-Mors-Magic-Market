extends Sprite2D

@onready var anim = $Anim
var emotes = [
	load("res://Images/horatius-1.png"),
	load("res://Images/horatius-2.png"),
	load("res://Images/horatius-3.png"),
	load("res://Images/horatius-4.png"),
]

func set_emotion(e):
	anim.stop()
	anim.play("Bounce")
	
	texture = emotes[e]
