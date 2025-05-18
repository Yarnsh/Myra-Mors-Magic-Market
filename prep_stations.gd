extends HBoxContainer

@export var prep_station_prefab : PackedScene

func _ready() -> void:
	GameGlobals.prep_stations = self

func check_requirements(req : Dictionary):
	return _compare(req, false)

func consume(req):
	return _compare(req, true)

func _compare(req : Dictionary, consume : bool):
	var req_copy = req.duplicate()
	for c in get_children():
		if c.resource_name in req_copy:
			var crc = c.resource_count
			if c.is_cooking():
				continue
			if crc > 0:
				if consume:
					c.take_resource(req_copy[c.resource_name])
				req_copy[c.resource_name] = req_copy[c.resource_name] - crc
				if req_copy[c.resource_name] <= 0:
					req_copy.erase(c.resource_name)
	return req_copy == {}

func clear():
	for c in get_children():
		c.clear()
		remove_child(c)
		c.queue_free()
	
	for i in range(GameGlobals.prep_station_count):
		var c = prep_station_prefab.instantiate()
		c.idx = i+1
		add_child(c)
