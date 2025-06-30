extends Node2D

@onready var sprite = $Sprite
@onready var anim = $Anim
const minwidth = 40
const maxwidth = 920
const leave_x = -80
var guys = [null, null, null]
var emote = 0
var target_x = leave_x
var leaving = false
var next_target_time = 0
const target_time_variation = 5000

func _ready() -> void:
	pick_random_target()

func set_guy(guyname):
	guys[0] = load("res://Images/Guy" + guyname + "1.png")
	guys[1] = load("res://Images/Guy" + guyname + "2.png")
	guys[2] = load("res://Images/Guy" + guyname + "3.png")
	sprite.texture = guys[emote]

func pick_random_target():
	target_x = minwidth + randi_range(0, (maxwidth-minwidth))
	next_target_time = Time.get_ticks_msec() + randi_range(0, target_time_variation)

func _process(delta: float) -> void:
	if leaving:
		target_x = leave_x
	elif Time.get_ticks_msec() >= next_target_time:
		pick_random_target()
	
	if abs(position.x - target_x) < 5:
		anim.play("RESET")
		if leaving:
			queue_free()
	elif target_x < position.x:
		anim.play("Walk")
		sprite.flip_h = true
		position += Vector2.LEFT * 200.0 * delta
	else:
		anim.play("Walk")
		sprite.flip_h = false
		position += Vector2.RIGHT * 200.0 * delta
