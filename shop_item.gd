extends Control

@onready var button = $Button
@onready var title_label = $Label
@onready var price_label = $Label2
@onready var sold = $Sold

var price = 0
var callback = null
var last_def = null

func set_item(def):
	last_def = def
	if def.get("sold_out", false):
		price = 0
		price_label.text = ""
		title_label.text = ""
		button.icon = null
		button.hide()
		callback = null
		button.disabled = true
		sold.show()
		return
	
	button.disabled = false
	price = def.get("price", 0)
	price_label.text = "$" + str(float(price) / 100.0).pad_decimals(2)
	title_label.text = def.get("title", "Mysterious...")
	#button.icon = def.get("icon", null)
	callback = def.get("callback", null)

func _on_button_pressed() -> void:
	if last_def != null:
		if GameGlobals.money >= last_def.get("price", 0):
			GameGlobals.money -= last_def.get("price", 0)
			if last_def.get("callback", null) != null:
				last_def["callback"].call()
		else:
			get_parent().poor_response()

func _on_button_mouse_entered() -> void:
	get_parent().text.item_selected(last_def)

func _on_button_mouse_exited() -> void:
	get_parent().text.hide()
