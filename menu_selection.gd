extends Button

@onready var game_prep = $".."
@export var default_icon : Texture2D

var selected_recipe = null

func _on_pressed() -> void:
	game_prep.open_recipe_list(self)

func set_recipe(recipe):
	selected_recipe = recipe
	if recipe == null:
		icon = default_icon
	else:
		icon = recipe.get("icon", default_icon)
