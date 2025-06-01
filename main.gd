extends Control

@onready var game = $Game
@onready var prep = $GamePrep
@onready var shop = $Upgrades

func start_game(recipes):
	prep.hide()
	shop.hide()
	game.reset()
	game.set_recipes(recipes)
	game.start()
	game.show()

func complete_game():
	game.hide()
	shop.hide()
	game.stop()
	game.reset()
	prep.show()
	prep.populate_recipes()

func open_shop():
	prep.hide()
	game.hide()
	shop.show()

func close_shop():
	game.hide()
	shop.hide()
	prep.show()
	prep.populate_recipes()
