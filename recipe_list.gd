extends Control

@export var recipe_entry : PackedScene
@onready var recipe_parent = $HBoxContainer/RecipeList/ScrollContainer/VBoxContainer
@onready var desc_label = $HBoxContainer/Desc/Desc/MarginContainer/Label
@onready var desc_image = $HBoxContainer/Desc/TextureRect

var last_button = null
var last_recipe = null

func _ready() -> void:
	populate_recipes()

func populate_recipes():
	last_button = null
	for c in recipe_parent.get_children():
		recipe_parent.remove_child(c)
		c.queue_free()
	for key in GameGlobals.unlocked_recipes:
		var r = recipe_entry.instantiate()
		recipe_parent.add_child(r)
		r.set_recipe(GameGlobals.recipe_definitions[key])
	
	var r = recipe_entry.instantiate()
	recipe_parent.add_child(r)
	r.set_recipe(null)

func update_selected_recipes(orders):
	for c in recipe_parent.get_children():
		if c.our_recipe == null:
			continue
		if c.our_recipe in orders and last_recipe != c.our_recipe:
			c.disabled = true
		else:
			c.disabled = false

func recipe_selected(recipe):
	last_recipe = recipe
	if recipe == null:
		desc_label.text = "Pick what you want to sell today"
		desc_image.texture = null
	else:
		desc_label.text = recipe.get("description", "Pick what you want to sell today")
		desc_image.texture = recipe.get("chalk_icon", null)

func select_pressed() -> void:
	if last_button != null:
		last_button.set_recipe(last_recipe)
		hide()
		last_button = null
