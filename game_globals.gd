extends Node

var task_manager = null
var current_task = null
var controls = null
var orders = null
var prep_stations = null

# Order definitions
var potion_order = {
	"task": "",
	"requirements": {"potion": 1},
	"icon": load("res://Images/PotionOrder.png")
}
var ponder_order = {
	"task": "PonderOrb",
	"requirements": {},
	"icon": load("res://Images/PonderOrbOrder.png")
}
var goblin_chore = {
	"task": "GoblinChore",
	"requirements": {},
	"icon": load("res://Images/GoblinChoreOrder.png")
}

var order_definitions = {
	"potion": potion_order,
	"ponder": ponder_order,
	"goblin": goblin_chore
}
