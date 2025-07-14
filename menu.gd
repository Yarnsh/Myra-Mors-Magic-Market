extends Control

@onready var main = $Main
@onready var settings = $Settings

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Menu"):
		if visible:
			if main.visible:
				GameGlobals.menu_up = false
				hide()
			else:
				settings.save_settings()
				settings.hide()
				main.show()
		else:
			GameGlobals.menu_up = true
			show()

func _on_settings_pressed() -> void:
	main.hide()
	settings.show()
