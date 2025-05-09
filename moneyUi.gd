extends PanelContainer

@onready var label = $Label
var current = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current < GameGlobals.money:
		current = min(GameGlobals.money, current + (100 * delta))
		update_visual()
	elif current > GameGlobals.money:
		current = max(GameGlobals.money, current - (100 * delta))
		update_visual()

func update_visual():
	label.text = "$" + str(float(current) / 100.0).pad_decimals(2)
