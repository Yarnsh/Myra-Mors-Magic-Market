extends Control

@onready var recipe_list_ui = $RecipeListPanel

func open_recipe_list(rb):
	recipe_list_ui.last_button = rb
	recipe_list_ui.show()
