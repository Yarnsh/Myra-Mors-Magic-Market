extends Control

var time_between_orders = 2000
var tbo_variation = 5000
@onready var next_order = Time.get_ticks_msec() + 4000

func _process(delta: float) -> void:
	var now = Time.get_ticks_msec()
	while now >= next_order:
		# TODO: limit this to whatever is relevant for this level
		if GameGlobals.orders.has_free_space():
			var k = GameGlobals.order_definitions.keys()
			var order_def = GameGlobals.order_definitions[k[randi() % k.size()]]
			GameGlobals.orders.add_order(order_def, 10000) # TODO: patience determined by game stuff
		
		next_order = next_order + time_between_orders + ((-tbo_variation/2) + randi_range(0, tbo_variation))
