extends Control

@onready var button = $VBoxContainer/Button
@onready var title_label = $VBoxContainer/Label
@onready var price_label = $VBoxContainer/Label2

var price = 0
var callback = null

func set_item(def):
	if def.get("sold_out", false):
		price = 0
		price_label.text = ""
		title_label.text = "SOLD OUT"
		button.icon = null # TODO: sold out graphic
		callback = null
		button.disabled = true
		return
	
	button.disabled = false
	price = def.get("price", 0)
	price_label.text = "$" + str(float(price) / 100.0).pad_decimals(2)
	title_label.text = def.get("title", "Mysterious...")
	button.icon = def.get("icon", null)
	callback = def.get("callback", null)

func _on_button_pressed() -> void:
	if GameGlobals.money >= price:
		GameGlobals.money -= price
		if callback != null:
			callback.call()
