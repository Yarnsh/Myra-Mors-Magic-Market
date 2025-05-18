extends PanelContainer

@onready var label = $Label

var t = 0.0

func _process(delta: float) -> void:
	t += delta
	var m = int(t) % 60
	var h = (int(t) / 60) % 24
	var half = "am"
	if h >= 12:
		half = "pm"
	
	h = h % 12
	if h == 0:
		h = 12
	
	label.text = str(h).pad_zeros(2)+":"+str(m).pad_zeros(2)+" "+half
