extends Control

@onready var main = $".."
@onready var recipe_list_ui = $RecipeListPanel
@onready var selections = $Selections

func open_recipe_list(rb):
	recipe_list_ui.last_button = rb
	recipe_list_ui.show()

func _on_start_button_pressed() -> void:
	var orders = []
	for c in selections.get_children():
		if c.selected_recipe != null:
			orders.append(c.selected_recipe)
	main.start_game(orders)

# TODO: de/serialize selected recipes for convenient resets
