extends Control

@export var recipe_entry : PackedScene
@onready var recipe_parent = $RecipeList/ScrollContainer/VBoxContainer

var last_button = null

func _ready() -> void:
	for key in GameGlobals.order_definitions.keys():
		var r = recipe_entry.instantiate()
		recipe_parent.add_child(r)
		r.set_recipe(GameGlobals.order_definitions[key])

func recipe_selected(recipe):
	if last_button != null:
		last_button.set_recipe(recipe)
		hide()
		last_button = null
