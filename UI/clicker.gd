extends Area2D

signal clicked

var mouse_in = false

# TODO: add some kind of global check for if buttons can work, so we can do cutscenes easier

func _process(delta: float) -> void:
	if is_visible_in_tree() and GameGlobals.allow_area_clicks():
		var query := PhysicsPointQueryParameters2D.new()
		query.collide_with_areas = true
		query.collide_with_bodies = false
		query.position = get_global_mouse_position()
		var result = get_world_2d().direct_space_state.intersect_point(query)
		var in_the_area = false
		for entry in result:
			if entry.collider == self:
				in_the_area = true
				break
		mouse_in = in_the_area
	else:
		mouse_in = false

func _input(event: InputEvent) -> void:
	if is_visible_in_tree() and GameGlobals.allow_area_clicks() and event.is_action_pressed("Click"):
		var query := PhysicsPointQueryParameters2D.new()
		query.collide_with_areas = true
		query.collide_with_bodies = false
		query.position = (event as InputEventMouse).global_position
		var result := get_world_2d().direct_space_state.intersect_point(query)
		for entry in result:
			if entry.collider == self:
				clicked.emit()
				break
