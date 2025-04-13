extends VBoxContainer

@onready var name_label = $Label
@onready var button_parent = $ItemList

func _ready() -> void:
	GameGlobals.controls = self
	clear_controls()

func clear_controls():
	name_label.text = ""
	for c in button_parent.get_children():
		c.clear()

func set_nice_name(nn : String):
	name_label.text = nn

func apply_control(position : int, text : String, image : Texture2D):
	button_parent.get_child(position).set_action(image, text)

func button_pressed(key : String):
	print("button_pressed: ", key)
	if GameGlobals.current_task != null:
		GameGlobals.current_task.take_input(key)
