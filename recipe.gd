extends Button

@onready var list_node = $"../../../../.."
@onready var label = $HBoxContainer/Label
@onready var texture = $HBoxContainer/TextureRect

var our_recipe = null

func _on_pressed() -> void:
	list_node.select_pressed()

func _on_mouse_entered() -> void:
	list_node.recipe_selected(our_recipe)

func set_recipe(recipe):
	our_recipe = recipe
	
	if recipe == null:
		label.text = "Nothing"
		texture.texture = null
		disabled = false
		return
	
	label.text = recipe.get("name", "")
	texture.texture = recipe.get("icon", null)

func _process(delta: float) -> void:
	# having this in process is so wrong man...
	if disabled:
		label.modulate = Color.DIM_GRAY
		texture.modulate = Color.DIM_GRAY
	else:
		label.modulate = Color.WHITE
		texture.modulate = Color.WHITE
