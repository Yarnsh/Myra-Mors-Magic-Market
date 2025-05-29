extends Control

var task_map = {}
var current_task_owner = null
@onready var game = $".."

func _ready() -> void:
	GameGlobals.task_manager = self
	for c in get_children():
		register_task(c.name, c)

func register_task(task_name : String, task):
	task_map[task_name] = task

func start_task(task, task_owner):
	stop_task()
	current_task_owner = task_owner
	GameGlobals.current_task = task
	task.reset_task()
	task.apply_controls()
	task.show()

func report_result(result):
	if current_task_owner != null:
		current_task_owner.report_result(result)

func stop_task():
	if GameGlobals.current_task != null:
		game.text_popup.remove()
		GameGlobals.controls.clear_controls()
		GameGlobals.current_task.reset_task()
		GameGlobals.current_task.hide()
		GameGlobals.current_task = null
