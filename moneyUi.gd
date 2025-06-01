extends PanelContainer

@onready var label = $MarginContainer/Label
var current = 0
@export var digits = 4

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var d = len(str(int(current)))
	var s = max(abs(current - GameGlobals.money), 100)
	if d > 2:
		s = s*2
	if d > 5:
		s = s*2
	if d > 8:
		s = s*2
	if current < GameGlobals.money:
		current = min(GameGlobals.money, current + (delta * s))
		update_visual()
	elif current > GameGlobals.money:
		current = max(GameGlobals.money, current - (delta * s))
		update_visual()

func update_visual():
	var d = len(str(int(current)))
	var l = d
	if d > digits:
		d -= 2
		label.text = "$" + str(current).substr(0, l-2)
		if d > digits:
			label.text = "$" + str(current).substr(0, l-5) + "k"
			d -= 3
			if d > digits:
				label.text = "$" + str(current).substr(0, l-8) + "m"
	else:
		label.text = "$" + str(float(current) / 100.0).pad_decimals(2)
