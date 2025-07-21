extends Control

@onready var main = $".."
@onready var recipe_list_ui = $RecipeListPanel
@onready var selections = $Selections
@onready var chores_label = $Visuals/Chores
@onready var manim = $Visuals/Anim

@onready var exit_sfx = $ExitSFX

func populate_recipes():
	recipe_list_ui.populate_recipes()
	chores_label.text = "Watch out for:\n"
	for c in GameGlobals.current_chores:
		chores_label.text += c["name"]
		if c != GameGlobals.current_chores[-1]:
			chores_label.text += ", "

func open_recipe_list(rb, recipe):
	recipe_list_ui.last_button = rb
	recipe_list_ui.recipe_selected(recipe)
	
	var orders = []
	for c in selections.get_children():
		if c.selected_recipe != null:
			orders.append(c.selected_recipe)
	recipe_list_ui.update_selected_recipes(orders)
	
	recipe_list_ui.show()

func _on_start_button_pressed() -> void:
	manim.play("Leaving")
	exit_sfx.play()
	var recipes = []
	for c in selections.get_children():
		if c.selected_recipe != null:
			recipes.append(c.selected_recipe)
	main.start_game(recipes)

func _on_shop_button_pressed() -> void:
	manim.play("Leaving")
	main.open_shop()


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Returning":
		manim.play("Thinking")
