extends Control

@onready var label = $ItemExplainer/MetalBorder/MarginContainer/Label

var last_def = null

func item_selected(def):
	show()
	label.text = def.get("description", "I don't know what this is...")
	last_def = def
