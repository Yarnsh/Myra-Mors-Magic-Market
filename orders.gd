extends VBoxContainer

@export var order_slot_prefab : PackedScene

func _ready() -> void:
	GameGlobals.orders = self

func clear():
	for c in get_children():
		if !c.is_free():
			c.complete_order(0.0)
		remove_child(c)
		c.queue_free()
	
	for i in range(GameGlobals.orders_count):
		var c = order_slot_prefab.instantiate()
		c.idx = (i+1)%10
		add_child(c)

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
