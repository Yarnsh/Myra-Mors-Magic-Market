extends Node

var task_manager = null
var current_task = null
var controls = null
var orders = null
var prep_stations = null

var money = 50
var prep_station_count = 0
var orders_count = 2

var unlocked_recipes = []

# Order definitions
var potion_order = {
	"name": "Potion",
	"task": "",
	"requirements": {"potion": 1},
	"icon": load("res://Images/PotionOrder.png"),
	"prep_key": "P",
	"prep_task": "PotionPrep"
}
var ponder_order = {
	"name": "Future Reading",
	"task": "PonderOrb",
	"requirements": {},
	"icon": load("res://Images/PonderOrbOrder.png"),
	"description": "Predict their future, aim for some good news for a big tip!"
}
var goblin_chore = {
	"name": "Goblins are about",
	"task": "GoblinChore",
	"requirements": {},
	"icon": load("res://Images/GoblinChoreOrder.png")
}

var order_definitions = {
	"potion": potion_order,
	"ponder": ponder_order,
	"goblin": goblin_chore
}

var current_chores = [
	goblin_chore
]

func _input(event: InputEvent) -> void:
	if event.is_action("DEV_MONEY"):
		money += 10000
