extends Control

@onready var main = $Main
@onready var settings = $Settings
@onready var myra_sprite = $Main/Myra/Myra
@onready var endday = $Main/EndDayButton
@onready var bg = $BG
var started = false

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

func _on_continue_pressed() -> void:
	if !started:
		get_parent().first_start()
	elif visible:
		if main.visible:
			GameGlobals.menu_up = false
			hide()
	started = true

func _on_end_day_pressed() -> void:
	GameGlobals.menu_up = false
	hide()
	day_going(false)
	GameGlobals.game.end_early()

func day_going(going):
	endday.visible = going

func _on_instructions_pressed() -> void:
	get_parent().start_tutorial()
