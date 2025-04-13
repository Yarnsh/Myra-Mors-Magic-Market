extends PanelContainer

@onready var order_image = $CurrentOrder
@onready var label = $Number/Label
@onready var button = $Button
@onready var timer = $Button/Timer
@onready var timer_rot = $Button/Timer/Rotator
@export var idx = 1

@onready var order_image_remove_offset = -$BG.size.x + $Number.size.x

var task = null
var resources_needed = {}
var available_time = 0
var last_timer_len = 1000
var was_cooking = false

var current_patience = 10000
var patience_done = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = str(idx)
	order_image.position = Vector2.RIGHT * order_image_remove_offset # this just doesnt work for some reason

func _process(delta: float) -> void:
	timer.visible = is_cooking()
	var t = 1.0 - (float(available_time - Time.get_ticks_msec()) / float(last_timer_len))
	timer_rot.rotation = (PI + PI/2.0) * t
	
	if !is_free():
		var p = 1.0 - (float(patience_done - Time.get_ticks_msec()) / float(current_patience))
		print(p)
		order_image.position = Vector2.RIGHT * (order_image_remove_offset * p)
		if p >= 1.0:
			complete_order()

func _on_button_pressed() -> void:
	# TODO: Holding Station optional tasks?
	if was_cooking:
		if !is_cooking():
			complete_order()
	elif task != null and GameGlobals.current_task == null:
		if GameGlobals.prep_stations.check_requirements(resources_needed):
			GameGlobals.prep_stations.consume(resources_needed)
			GameGlobals.task_manager.start_task(task, self)
	elif resources_needed != null and resources_needed != {}:
		if GameGlobals.prep_stations.check_requirements(resources_needed):
			GameGlobals.prep_stations.consume(resources_needed)
			complete_order()

func is_cooking():
	return Time.get_ticks_msec() < available_time

func set_order(order_def, patience):
	order_image.texture = order_def.get("icon", null)
	task = GameGlobals.task_manager.task_map.get(order_def.get("task", ""), null)
	resources_needed = order_def.get("requirements", {})
	order_image.position = Vector2.ZERO
	current_patience = patience
	patience_done = Time.get_ticks_msec() + patience

func report_result(result):
	# TODO: check for how well it was done
	if "timer" in result:
		available_time = Time.get_ticks_msec() + result["timer"]
		last_timer_len = result["timer"]
		was_cooking = true
	else:
		complete_order()
	print("Order result: ", result)

func complete_order():
	order_image.position = Vector2.RIGHT * order_image_remove_offset
	if GameGlobals.task_manager.current_task_owner == self:
		GameGlobals.task_manager.stop_task()
	task = null
	resources_needed = {}
	was_cooking = false

func is_free():
	return (resources_needed == null or resources_needed == {}) and task == null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(str(idx)) and !Input.is_key_pressed(KEY_TAB):
		_on_button_pressed()
