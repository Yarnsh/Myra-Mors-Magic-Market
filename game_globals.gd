extends Node

signal sunburned

var game = null

var fade_happening = false
var menu_up = false
func allow_area_clicks():
	return !menu_up and !fade_happening

var task_manager = null
var current_task = null
var controls = null
var orders = null
var prep_stations = null

var money = 50
var prep_station_count = 0
var orders_count = 2
var tax_free = false

var unlocked_recipes = []

# Order definitions
var potion_order = {
	"name": "Potion",
	"task": "",
	"requirements": {"potion": 1},
	"base_price": 1200,
	"icon": load("res://Images/PotionOrder.png"),
	"prep_icon": load("res://Images/Cauldron.png"),
	"chalk_icon": load("res://Images/ChalkCauldron.png"),
	"prep_key": "P",
	"prep_task": "PotionPrep",
	"description": "Expensive potions that must be prepared beforehand, really bring in the big bucks!"
}
var ponder_order = {
	"name": "Fortune Reading",
	"task": "PonderOrb",
	"requirements": {},
	"icon": load("res://Images/PonderOrbOrder.png"),
	"chalk_icon": load("res://Images/ChalkCrystalBall.png"),
	"description": "Predict their future, aim for some good news for a big tip! Bad news will greatly reduce vibe however..."
}
var crystal_recipe = {
	"name": "Pre-charged Crystals",
	"requirements": {},
	"icon": load("res://Images/crystal.png"),
	"prep_icon": load("res://Images/crystal.png"),
	"chalk_icon": load("res://Images/ChalkCrystal.png"),
	"prep_key": "C",
	"prep_task": "ChargeCrystals",
	"description": "Customers will buy a crystal with every order if you prepare them. They will pay DOUBLE for whatever they buy!"
}
var incense_recipe = {
	"name": "Incense Burning",
	"requirements": {},
	"icon": load("res://Images/IncensePot.png"),
	"prep_icon": load("res://Images/IncensePot.png"),
	"chalk_icon": load("res://Images/ChalkIncense.png"),
	"prep_key": "I",
	"prep_task": "Incense",
	"description": "Light incense to make the store smell nice. While it is burning the vibes are greatly enhanced!"
}
var gong_order = {
	"name": "Spirit Scaring Gong",
	"task": "Gong",
	"requirements": {},
	"icon": load("res://Images/GongOrder.png"),
	"chalk_icon": load("res://Images/ChalkGong.png"),
	"description": "Bong the big gong to scare away vile spirits. Raises the vibe of the store more than other orders, and pays well!"
}
var slip_order = {
	"name": "Draw Senjafuda",
	"task": "Senjafuda",
	"requirements": {},
	"icon": load("res://Images/SenjafudaOrder.png"),
	"chalk_icon": load("res://Images/ChalkSlip.png"),
	"description": "Quick and simple paper charms. The sale of these brings no specific benefit, but it is fast."
}
var goblin_chore = {
	"name": "Goblins",
	"task": "GoblinChore",
	"requirements": {},
	"icon": load("res://Images/GoblinChoreOrder.png")
}
var fire_chore = {
	"name": "Fire",
	"task": "Fire",
	"requirements": {},
	"icon": load("res://Images/HeadOnFireOrder.png")
}
var taxes_chore = {
	"name": "Paperwork",
	"task": "Taxes",
	"requirements": {},
	"icon": load("res://Images/TaxesOrder.png")
}

var recipe_definitions = {
	"potion": potion_order,
	"ponder": ponder_order,
	"crystal": crystal_recipe,
	"gong": gong_order,
	"slip": slip_order,
	"incense": incense_recipe
}

var current_chores = [
	goblin_chore
]

func _input(event: InputEvent) -> void:
	pass
	#if event.is_action("DEV_MONEY"):
	#	money += 1000000
	#if event.is_action("DEV_UNLOCK"):
	#	prep_station_count = 6
	#	orders_count = 10
	#	for r in recipe_definitions.keys():
	#		if r not in unlocked_recipes:
	#			unlocked_recipes.append(r)
