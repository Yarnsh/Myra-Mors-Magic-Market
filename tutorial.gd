extends Control

@onready var all_bgs = [$T1, $T2, $T3]
@onready var all = [$T1/S1,$T1/S2,$T1/S3,$T2/S1,$T2/S2,$T2/S3,$T3/S1,$T3/S2,$T3/S3,$T3/S4]
var step = 0

func start():
	show()
	step = 0
	next_step()

func next_step():
	if step == len(all):
		hide()
		get_parent().stop_tutorial()
		return
	
	for a in all:
		a.hide()
	if not all[step].get_parent().visible:
		for b in all_bgs:
			b.hide()
		all[step].get_parent().show()
	all[step].show()
	step += 1

func _on_button_pressed() -> void:
	next_step()
