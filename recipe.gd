extends Button

@onready var list_node = $"../../../.."
@onready var label = $HBoxContainer/Label
@onready var texture = $HBoxContainer/TextureRect

var our_recipe = null

func _on_pressed() -> void:
	list_node.recipe_selected(our_recipe)

func set_recipe(recipe):
	our_recipe = recipe
	label.text = recipe.get("name", "")
	# TODO: use a square recipe icon of some kind
	texture.texture = recipe.get("icon", null)
