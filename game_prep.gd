extends Control

@onready var main = $".."
@onready var recipe_list_ui = $RecipeListPanel
@onready var selections = $Selections

func populate_recipes():
	recipe_list_ui.populate_recipes()

func open_recipe_list(rb):
	var orders = []
	for c in selections.get_children():
		if c.selected_recipe != null:
			orders.append(c.selected_recipe)
	recipe_list_ui.update_selected_recipes(orders)
	
	recipe_list_ui.last_button = rb
	recipe_list_ui.show()

func _on_start_button_pressed() -> void:
	var orders = []
	for c in selections.get_children():
		if c.selected_recipe != null:
			orders.append(c.selected_recipe)
	main.start_game(orders)

func _on_shop_button_pressed() -> void:
	main.open_shop()
