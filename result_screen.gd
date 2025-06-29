extends ColorRect

@onready var labels = [$VBoxContainer2/Label, $VBoxContainer2/Label2, $VBoxContainer2/Label3, $Total]
@onready var values = [$VBoxContainer3/Label, $VBoxContainer3/Label2, $VBoxContainer3/Label3, $TotalVal]
@onready var button = $Button

var t = 0.0
const show_time = 0.5
var shown = 0

func finish(base, tips, taxes):
	button.hide()
	for l in labels:
		l.hide()
	for l in values:
		l.hide()
	values[0].text = "$" + str(float(base) / 100.0).pad_decimals(2)
	values[1].text = "$" + str(float(tips) / 100.0).pad_decimals(2)
	values[2].text = "-$" + str(float(taxes) / 100.0).pad_decimals(2)
	values[3].text = "$" + str(float(base+tips-taxes) / 100.0).pad_decimals(2)
	shown = 0
	t = 0
	
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	t += delta
	if shown < 4 and t >= (shown + 1) * show_time:
		labels[shown].show()
		values[shown].show()
		shown += 1
	elif shown == 4 and t >= (shown + 1) * show_time:
		button.show()
		shown += 1

func _on_button_pressed() -> void:
	hide()
	get_parent().main.complete_game()
