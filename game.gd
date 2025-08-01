extends Control

var base_time_between_orders = 2000
var time_between_chores = 8000
var tbo_variation = 5000
@onready var next_order = Time.get_ticks_msec() + 4000
@onready var next_chore = Time.get_ticks_msec() + 4000 + time_between_chores
@onready var main = $".."
@onready var timer = $Time
@onready var text_popup = $TaskText
@onready var anim = $AnimationPlayer
@onready var fanim = $FunAnim
@onready var result_screen = $ResultScreen
@onready var money = $Money
@onready var customer_prefab = preload("res://customer.tscn")
@onready var customer_parent = $IndoorVisuals/Customers
@onready var vibe_indicator = $Money/Vibe
@onready var board = $IndoorVisuals/Board
@onready var smoke_anim = $IndoorVisuals/Smoke/Anim

@onready var money_sfx = $MoneySFX
@onready var entry_sfx = $EntrySFX

var order_list = []
var chores_list = []
var recipes_list = []

var vibe = 1.0
var vibe_mult = 1.0
var max_vibe = 2.0

var complete = true
var tips_earned = 0.0
var base_earned = 0.0
var taxes_taken = 0.0
var irs_taken = 0.0

var next_incense_check = 0

func _ready() -> void:
	GameGlobals.game = self

func reset():
	complete = false
	next_order = Time.get_ticks_msec() + 8000
	next_chore = Time.get_ticks_msec() + 7000 + time_between_chores
	GameGlobals.task_manager.stop_task()
	GameGlobals.orders.clear()
	GameGlobals.controls.clear_controls()
	GameGlobals.prep_stations.clear()
	GameGlobals.current_task = null
	timer.t = 0.0
	vibe = 1.0
	max_vibe = 1.5 + (0.25 * GameGlobals.orders_count)
	
	tips_earned = 0.0
	base_earned = 0.0
	taxes_taken = 0.0
	irs_taken = 0.0
	
	smoke_anim.play("RESET")

func start():
	set_process(true)
	timer.unpause()
	fanim.play("StartGame")
	anim.play("StartGame")

func stop():
	set_process(false)

func set_popup_text(text):
	text_popup.display(text)
func hide_popup_text():
	text_popup.remove()

func set_recipes(recipes):
	recipes_list = []
	order_list = []
	for r in recipes:
		if r != null:
			recipes_list.append(r)
			if "task" in r:
				order_list.append(r)
	chores_list = GameGlobals.current_chores
	board.populate(recipes)

func trigger_complete():
	complete = true
	GameGlobals.task_manager.stop_task()
	GameGlobals.orders.clear()
	GameGlobals.controls.clear_controls()
	GameGlobals.prep_stations.clear()
	GameGlobals.current_task = null
	timer.pause()
	result_screen.finish(base_earned, tips_earned, taxes_taken, irs_taken)

func _process(delta: float) -> void:
	if !complete:
		var now = Time.get_ticks_msec()
		
		if now > next_incense_check:
			if GameGlobals.prep_stations.check_requirements({"incense": 1}):
				GameGlobals.prep_stations.consume({"incense": 1})
				next_incense_check = now + 20000
		if GameGlobals.prep_stations.check_requirements({"incense": 1}):
			if vibe_mult != 2.0:
				smoke_anim.play("Show")
			vibe_mult = 2.0
		else:
			if vibe_mult != 1.0:
				smoke_anim.play("Hide")
			vibe_mult = 1.0
		
		while now >= next_chore:
			if GameGlobals.orders.has_free_space() and len(chores_list) > 0:
				var order_def = chores_list[randi() % chores_list.size()]
				GameGlobals.orders.add_order(order_def, 6000 + (GameGlobals.orders_count * 4000))
			
			next_chore = next_chore + time_between_chores + ((-tbo_variation/2) + randi_range(0, tbo_variation))
		
		while now >= next_order:
			if GameGlobals.orders.has_free_space() and len(order_list) > 0:
				var order_def = order_list[randi() % order_list.size()]
				var customer = customer_prefab.instantiate()
				customer_parent.add_child(customer)
				customer.set_guy("Cloak")
				GameGlobals.orders.add_order_with_customer(order_def, 6000 + (GameGlobals.orders_count * 4000), customer)
				entry_sfx.stop()
				entry_sfx.play()
			
			var time_between_orders = 6000 / max(0.1, vibe*vibe_mult)
			var variation = time_between_orders * 2.5
			next_order = next_order + time_between_orders + ((-variation/2) + randi_range(0, variation))
		
		if timer.t >= 360.0:
			trigger_complete()

func add_money(m):
	if m > 0:
		money_sfx.play()
		money.play_effects()
	else:
		pass # TODO: money loss effects
	GameGlobals.money += m

func handle_order_result(result):
	if !complete:
		# Figure out how much money we made
		if not result.get("chore", false) and not result.get("failed", false):
			var quality = result.get("quality", 0.0)
			var base_price = result.get("base_price", 100)
			var tip = 0.15 * vibe * vibe_mult * result.get("tip_mult", 1.0)
			var other_mult = 1.0
			
			if GameGlobals.prep_stations.check_requirements({"crystal": 1}):
				GameGlobals.prep_stations.consume({"crystal": 1})
				other_mult = other_mult * 2.0
			
			if quality >= 0.5:
				vibe = max(0.0, min(max_vibe, vibe + ((0.15 * quality) * result.get("vibe_gain_mult", 1.0))))
				vibe_indicator.gain()
			else:
				vibe = max(0.0, min(max_vibe, vibe * (0.5 + (0.8 * quality))))
				vibe_indicator.lose()
			
			base_price *= other_mult
			
			base_earned += base_price
			tips_earned += ceil(base_price * tip * quality)
			
			var final_money = base_price + ceil(base_price * tip * quality)
			
			# Taxes
			if not GameGlobals.tax_free:
				var taxes = floor(final_money / 2)
				final_money -= taxes
				taxes_taken += taxes
			
			add_money(final_money)
		elif not result.get("chore", false) and result.get("failed", false):
			vibe = max(0.0, min(max_vibe, vibe * (0.5)))
			vibe_indicator.lose()
		elif result.get("chore", false):
			if result.get("quality", 0.0) > 0.5:
				if vibe < 1.0:
					vibe = max(0.0, min(max_vibe, vibe + (0.25)))
					vibe_indicator.gain()
				else:
					vibe = max(0.0, min(max_vibe, vibe + (0.05)))
					vibe_indicator.gain()
			else:
				if result.get("chore_special", "") == "taxes":
					add_money(-min(GameGlobals.money, 100000))
					irs_taken += min(GameGlobals.money, 100000)
				else:
					vibe = max(0.0, min(max_vibe, vibe * (0.5)))
					vibe_indicator.lose()

func end_early():
	trigger_complete()
