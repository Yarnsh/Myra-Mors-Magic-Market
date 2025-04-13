extends VBoxContainer

enum PREP_TYPE {PREP_CAULDRON, PREP_ENCHANTING, PREP_OUTSIDE}

@export var idx = 1
@export var prep_type : PREP_TYPE
@export var default_image : Texture2D

@onready var label = $Label/Label
@onready var resource_label = $Button/Label
@onready var button = $Button
@onready var timer = $Button/Timer
@onready var timer_rot = $Button/Timer/Rotator

var resource_name = ""
var resource_count = 0
var available_time = 0
var last_timer_len = 1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = str(idx)
	if prep_type == PREP_TYPE.PREP_CAULDRON:
		label.text = label.text + " C"
	elif prep_type == PREP_TYPE.PREP_ENCHANTING:
		label.text = label.text + " E"
	elif prep_type == PREP_TYPE.PREP_OUTSIDE:
		label.text = label.text + " O"
	button.icon = default_image
	resource_label.text = ""

func _process(delta: float) -> void:
	timer.visible = is_cooking()
	var t = 1.0 - (float(available_time - Time.get_ticks_msec()) / float(last_timer_len))
	timer_rot.rotation = (PI + PI/2.0) * t

func _on_button_pressed() -> void:
	if GameGlobals.current_task == null and resource_count <= 0:
		if prep_type == PREP_TYPE.PREP_CAULDRON:
			GameGlobals.task_manager.start_task(GameGlobals.task_manager.task_map["CauldronPrepStationTask"], self)
		elif prep_type == PREP_TYPE.PREP_ENCHANTING:
			GameGlobals.task_manager.start_task(GameGlobals.task_manager.task_map["EnchantingPrepStationTask"], self)
		elif prep_type == PREP_TYPE.PREP_OUTSIDE:
			GameGlobals.task_manager.start_task(GameGlobals.task_manager.task_map["OutsidePrepStationTask"], self)

func report_result(result):
	# TODO: possibly check for messing it up for some effects?
	# TODO: if result involves a timer, set one
	print("PrepStation: ", name, ", ",result)
	if result.get("quality", 1.0) < 1.0:
		# TODO: visual for the prep failing
		return
	button.icon = result.get("icon", null)
	resource_name = result.get("resource_name", "")
	resource_count = result.get("resource_count", 0)
	resource_label.text = str(resource_count)
	if "timer" in result:
		available_time = Time.get_ticks_msec() + result["timer"]
		last_timer_len = result["timer"]

func is_cooking():
	return Time.get_ticks_msec() < available_time

func take_resource(count):
	resource_count -= count
	if resource_count <= 0:
		resource_label.text = ""
		button.icon = default_image
	else:
		resource_label.text = str(resource_count)
	
	if resource_count < 0:
		return count + resource_count
	return count

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(str(idx)) and Input.is_key_pressed(KEY_TAB):
		_on_button_pressed()
