extends Sprite2D

@onready var par = $"../.."
@onready var anim = $AnimationPlayer
@onready var gain_particle = $Gain
@onready var loss_particle = $Loss

var vibes = [load("res://Images/Vibe0.png"), load("res://Images/Vibe1.png"), load("res://Images/Vibe2.png"), load("res://Images/Vibe3.png")]

func gain():
	gain_particle.restart()
	gain_particle.emitting = true
func lose():
	loss_particle.restart()
	loss_particle.emitting = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var v = floor(min(par.vibe * 2.0, 3.0))
	texture = vibes[v]
	anim.play("default", -1, par.vibe)
