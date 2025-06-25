extends Sprite2D

@onready var clicker = $Clicker
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

func _input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("Click"):
		var query := PhysicsPointQueryParameters2D.new()
		query.collide_with_areas = true
		query.collide_with_bodies = false
		query.position = (event as InputEventMouse).global_position
		var result := get_world_2d().direct_space_state.intersect_point(query)
		var in_the_area := false
		for entry in result:
			if entry.collider == clicker:
				set_emotion(2)
				break
