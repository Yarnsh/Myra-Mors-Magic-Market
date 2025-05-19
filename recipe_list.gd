extends Control

@export var recipe_entry : PackedScene
@onready var recipe_parent = $RecipeList/ScrollContainer/VBoxContainer

var last_button = null

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
		r.set_recipe(GameGlobals.order_definitions[key])
	
	var r = recipe_entry.instantiate()
	recipe_parent.add_child(r)
	r.set_recipe(null)

func update_selected_recipes(orders):
	for c in recipe_parent.get_children():
		if c.our_recipe == null:
			continue
		if c.our_recipe in orders:
			c.disabled = true
		else:
			c.disabled = false

func recipe_selected(recipe):
	if last_button != null:
		last_button.set_recipe(recipe)
		hide()
		last_button = null
