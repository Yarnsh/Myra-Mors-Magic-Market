extends Sprite2D

@onready var clicker = $Clicker
@onready var anim = $Anim
@onready var speech = $"../SpeechBubble"
@onready var mumble = $"../../Mumble3"

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

func _on_clicker_clicked() -> void:
	set_emotion(2)
	speech.say("Oy...")
	mumble.play()
