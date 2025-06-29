extends Area2D

signal clicked

func _input(event: InputEvent) -> void:
	if is_visible_in_tree() and event.is_action_pressed("Click"):
		var query := PhysicsPointQueryParameters2D.new()
		query.collide_with_areas = true
		query.collide_with_bodies = false
		query.position = (event as InputEventMouse).global_position
		var result := get_world_2d().direct_space_state.intersect_point(query)
		var in_the_area := false
		for entry in result:
			if entry.collider == self:
				clicked.emit()
				break
