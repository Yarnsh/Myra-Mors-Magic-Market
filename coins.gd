extends Node2D

@export var coin_scene : PackedScene
var next_coin = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Time.get_ticks_msec() > next_coin:
		spawn_coin()
		next_coin = Time.get_ticks_msec() + 100 + (randf()*600)

func spawn_coin():
	var coin = coin_scene.instantiate()
	add_child(coin)
	coin.global_position = Vector2(660 + ((randf()*400) - 200), -60)
