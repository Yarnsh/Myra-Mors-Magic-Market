extends Control

var time_between_orders = 2000
var tbo_variation = 5000
@onready var next_order = Time.get_ticks_msec() + 4000
@onready var main = $".."
@onready var timer = $Time

var order_list = []

func reset():
	next_order = Time.get_ticks_msec() + 4000
	GameGlobals.task_manager.stop_task()
	GameGlobals.orders.clear()
	GameGlobals.controls.clear_controls()
	GameGlobals.prep_stations.clear()
	GameGlobals.current_task = null
	timer.t = 0.0

func start():
	set_process(true)

func stop():
	set_process(false)

func set_orders(orders):
	order_list = orders
	order_list.append_array(GameGlobals.current_chores)

func trigger_complete():
	main.complete_game()

func _process(delta: float) -> void:
	var now = Time.get_ticks_msec()
	while now >= next_order:
		# TODO: limit this to whatever is relevant for this level
		if GameGlobals.orders.has_free_space() and len(order_list) > 0:
			var order_def = order_list[randi() % order_list.size()]
			GameGlobals.orders.add_order(order_def, 10000) # TODO: patience determined by game stuff
		
		next_order = next_order + time_between_orders + ((-tbo_variation/2) + randi_range(0, tbo_variation))
	
	if timer.t >= 30.0:
		trigger_complete()
