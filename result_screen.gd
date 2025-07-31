extends ColorRect

@onready var labels = [$Shake/VBoxContainer2/Label, $Shake/VBoxContainer2/Label2, $Shake/VBoxContainer2/Label3, $Shake/Total]
@onready var values = [$Shake/VBoxContainer3/Label, $Shake/VBoxContainer3/Label2, $Shake/VBoxContainer3/Label3, $Shake/TotalVal]
@onready var button = $Shake/Button
@onready var anim = $Anim
@onready var boom_sfx = $BoomSFX
@onready var ding_sfx = $DingSFX
@onready var done_sfx = $DoneSFX

var t = 0.0
const show_time = 0.35
var shown = 0

func finish(base, tips, taxes, irs):
	boom_sfx.play()
	button.hide()
	for l in labels:
		l.hide()
	for l in values:
		l.hide()
	values[0].text = "$" + str(float(base) / 100.0).pad_decimals(2)
	values[1].text = "$" + str(float(tips) / 100.0).pad_decimals(2)
	values[2].text = "-$" + str(float(taxes+irs) / 100.0).pad_decimals(2)
	values[3].text = "$" + str(float(base+tips-(taxes+irs)) / 100.0).pad_decimals(2)
	shown = 0
	t = -(show_time * 2.0)
	
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if visible:
		t += delta
		if shown < 4 and t >= (shown + 1) * show_time:
			labels[shown].show()
			values[shown].show()
			anim.play("Shake")
			boom_sfx.play()
			shown += 1
		elif shown == 4 and t >= (shown + 1) * show_time:
			button.show()
			ding_sfx.play()
			shown += 1

func _on_button_pressed() -> void:
	done_sfx.play()
	hide()
	get_parent().main.complete_game()
