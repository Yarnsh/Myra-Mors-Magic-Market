extends Node2D

@onready var moneyui = $"../../Money"
@onready var grab = $Punch
@onready var coin = $AnimatedSprite2D
@onready var parent = get_parent()
@onready var clicker = $Clicker

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if randf() > 0.5:
		coin.play_backwards("default")
	coin.set_frame_and_progress(randi()%16, 0.0)
	clicker.ignore_allow = true
	grab.rotation = (randf() * PI/2.0) - (PI/4.0)
	if randf() > 0.5:
		grab.scale = grab.scale * Vector2(-1,1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if global_position.y > parent.global_position.y:
		queue_free()
	position += Vector2.DOWN * delta * 300.0


func _on_clicker_clicked() -> void:
	clicker.hide()
	GameGlobals.money += 5
	moneyui.play_effects()
	grab.show()
	grab.play()
	coin.hide()


func _on_anim_animation_finished(anim_name: StringName) -> void:
	queue_free()
