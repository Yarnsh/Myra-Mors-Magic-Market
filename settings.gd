extends PanelContainer

@onready var fullscreen = $MarginContainer/All/Options/Controls/Fullscreen

@onready var master_volume = $MarginContainer/All/Options/Controls/Master
@onready var sfx_volume = $MarginContainer/All/Options/Controls/SFX
@onready var music_volume = $MarginContainer/All/Options/Controls/Music

@onready var test_sfx = $TestSFX

var last_settings = {}

func _ready():
	set_settings_from_dict(read_from_file())
	apply_current_settings()
	last_settings = get_current_settings_dict()

func get_current_settings_dict():
	return {
		"fullscreen": fullscreen.button_pressed,
		"master_volume": master_volume.value,
		"sfx_volume": sfx_volume.value,
		"music_volume": music_volume.value
	}

func set_settings_from_dict(settings):
	fullscreen.button_pressed = settings.get("fullscreen", false)
	master_volume.value = settings.get("master_volume", 66)
	sfx_volume.value = settings.get("sfx_volume", 66)
	music_volume.value = settings.get("music_volume", 66)

func apply_current_settings():
	if fullscreen.button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	AudioServer.set_bus_volume_db(0, linear_to_db(float(master_volume.value)/100.0))
	AudioServer.set_bus_volume_db(1, linear_to_db(float(sfx_volume.value)/100.0))
	AudioServer.set_bus_volume_db(2, linear_to_db(float(music_volume.value)/100.0))

func save_settings():
	last_settings = get_current_settings_dict()
	apply_current_settings()
	write_to_file(last_settings)

func _on_change(value):
	apply_current_settings()

func _on_sfx_value_changed(value: float) -> void:
	test_sfx.play()

func write_to_file(settings):
	var text = JSON.stringify(settings)
	var file = FileAccess.open("user://settings.dat", FileAccess.WRITE)
	file.store_string(text)

func read_from_file():
	var file = FileAccess.open("user://settings.dat", FileAccess.READ)
	if file == null:
		return {}
	var content = file.get_as_text()
	var result = JSON.parse_string(content)
	if result == null:
		return {}
	return result

func _on_done_pressed() -> void:
	save_settings()
	get_parent().main.show()
	hide()
