extends Button

@onready var controls = $"../../.."
@onready var shortcut_label = $Label
@onready var anim = $AnimationPlayer
@onready var shortcut_event = InputEventKey.new()

func clear():
	disabled = true
	icon = null
	shortcut_label.text = ""
	shortcut.events = []
	anim.play("RESET")

func set_action(image: Texture2D, sc: String):
	disabled = false
	icon = image
	shortcut_label.text = sc
	shortcut_event = InputEventKey.new()
	shortcut_event.set_keycode(OS.find_keycode_from_string(sc))
	shortcut.events.append(shortcut_event)

func _on_pressed() -> void:
	anim.play("Pressed")
	controls.button_pressed(shortcut_label.text)

func _input(event: InputEvent) -> void:
	if event.is_match(shortcut_event, false) and event.is_released():
		_on_button_up()

func _on_button_up() -> void:
	controls.button_released(shortcut_label.text)
