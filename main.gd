extends Control

@onready var game = $Game
@onready var prep = $GamePrep

func start_game(orders):
	prep.hide()
	game.reset()
	game.set_orders(orders)
	game.start()
	game.show()

func complete_game():
	game.hide()
	game.stop()
	game.reset()
	prep.show()
