extends VBoxContainer

# TODO: have new orderes managed by some other game progress related node

func _ready() -> void:
	GameGlobals.orders = self

func clear():
	for c in get_children():
		if !c.is_free():
			c.complete_order(0.0)

func has_free_space():
	for c in get_children():
		if c.is_free():
			return true
	return false

func add_order(order_def, patience):
	for c in get_children():
		if c.is_free():
			c.set_order(order_def, patience)
			return
