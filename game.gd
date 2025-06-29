extends Control

var time_between_orders = 2000
var tbo_variation = 5000
@onready var next_order = Time.get_ticks_msec() + 4000
@onready var main = $".."
@onready var timer = $Time
@onready var text_popup = $TaskText
@onready var anim = $AnimationPlayer
@onready var result_screen = $ResultScreen

var order_list = []
var recipes_list = []

var complete = true
var tips_earned = 0.0
var base_earned = 0.0
var taxes_taken = 0.0

func reset():
	complete = false
	next_order = Time.get_ticks_msec() + 4000
	GameGlobals.task_manager.stop_task()
	GameGlobals.orders.clear()
	GameGlobals.controls.clear_controls()
	GameGlobals.prep_stations.clear()
	GameGlobals.current_task = null
	timer.t = 0.0
	
	tips_earned = 0.0
	base_earned = 0.0
	taxes_taken = 0.0

func start():
	set_process(true)
	timer.unpause()
	anim.play("StartGame")

func stop():
	set_process(false)

func set_recipes(recipes):
	recipes_list = recipes
	recipes_list.append_array(GameGlobals.current_chores) # in case we need prep stations for future chores
	order_list = []
	for r in recipes:
		if "task" in r:
			order_list.append(r)
	order_list.append_array(GameGlobals.current_chores)

func trigger_complete():
	complete = true
	GameGlobals.task_manager.stop_task()
	GameGlobals.orders.clear()
	GameGlobals.controls.clear_controls()
	GameGlobals.prep_stations.clear()
	GameGlobals.current_task = null
	timer.pause()
	result_screen.finish(base_earned, tips_earned, taxes_taken)

func _process(delta: float) -> void:
	if !complete:
		var now = Time.get_ticks_msec()
		while now >= next_order:
			# TODO: limit this to whatever is relevant for this level
			if GameGlobals.orders.has_free_space() and len(order_list) > 0:
				var order_def = order_list[randi() % order_list.size()]
				GameGlobals.orders.add_order(order_def, 10000) # TODO: patience determined by game stuff
			
			next_order = next_order + time_between_orders + ((-tbo_variation/2) + randi_range(0, tbo_variation))
		
		if timer.t >= 360.0:
			trigger_complete()

func add_money(m):
	GameGlobals.money += m

func handle_order_result(result):
	if !complete:
		# Figure out how much money we made
		if not result.get("chore", false) and not result.get("failed", false):
			var quality = result.get("quality", 0.0)
			var base_price = result.get("base_price", 100)
			var tip = 0.15 * GameGlobals.vibe * result.get("tip_mult", 1.0)
			var other_mult = 1.0
			
			if GameGlobals.prep_stations.check_requirements({"crystal": 1}):
				GameGlobals.prep_stations.consume({"crystal": 1})
				other_mult = other_mult * 2.0
			
			base_price *= other_mult
			
			base_earned += base_price
			tips_earned += (base_price * tip * quality)
			
			var final_money = base_price + (base_price * tip * quality)
			
			# Taxes
			var taxes = final_money / 2
			final_money -= taxes
			taxes_taken += taxes
			
			add_money(final_money)
		# TODO: negaive effects on failure
