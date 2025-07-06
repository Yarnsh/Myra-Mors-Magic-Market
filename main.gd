extends Control

@onready var game = $Game
@onready var prep = $GamePrep
@onready var shop = $Upgrades
@onready var shop2 = $Upgrades2

func start_game(recipes):
	prep.hide()
	shop.hide()
	shop2.hide()
	game.reset()
	game.set_recipes(recipes)
	game.start()
	game.show()

func complete_game():
	game.hide()
	shop.hide()
	shop2.hide()
	game.stop()
	game.reset()
	prep.show()
	prep.populate_recipes()

func open_shop():
	prep.hide()
	game.hide()
	shop2.hide()
	shop.show()
	shop.on_open()

func open_shop2():
	prep.hide()
	game.hide()
	shop.hide()
	shop2.show()
	shop2.on_open()

func close_shop():
	game.hide()
	shop.hide()
	shop2.hide()
	prep.show()
	prep.populate_recipes()

func close_shop2():
	open_shop()
