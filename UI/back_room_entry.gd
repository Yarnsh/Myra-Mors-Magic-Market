extends Sprite2D

@onready var anim = $Anim
@onready var clicker = $BackRoomClicker
@onready var back_enter_sfx = $"../BackEnterSFX"

func available():
	return GameGlobals.prep_station_count > 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if available() and clicker.mouse_in:
		anim.play("MouseOver")
	else:
		anim.play("RESET")

func _on_back_room_clicker_clicked() -> void:
	if available():
		back_enter_sfx.play()
		get_parent().get_parent().open_shop2()
