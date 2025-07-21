extends Button

@onready var game_prep = $"../.."
@export var default_icon : Texture2D
@onready var label = $Label
@onready var sfx = $SFX

var selected_recipe = null

func _on_pressed() -> void:
	game_prep.open_recipe_list(self, selected_recipe)

func set_recipe(recipe):
	selected_recipe = recipe
	if recipe == null:
		icon = default_icon
		label.text = ""
	else:
		icon = recipe.get("chalk_icon", default_icon)
		label.text = recipe.get("name", "Something :P")
		sfx.play()
