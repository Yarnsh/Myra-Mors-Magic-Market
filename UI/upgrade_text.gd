extends Control

@onready var label = $ItemExplainer/MarginContainer/Label

var last_def = null

func item_selected(def):
	show()
	label.text = def.get("description", "I don't know what this is...")
	last_def = def

func _on_buy_pressed() -> void:
	if last_def != null:
		if GameGlobals.money >= last_def.get("price", 0):
			GameGlobals.money -= last_def.get("price", 0)
			if last_def.get("callback", null) != null:
				last_def["callback"].call()
