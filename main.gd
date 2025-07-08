extends Control

@onready var fade = $Fade
@onready var game = $Game
@onready var prep = $GamePrep
@onready var shop = $Upgrades
@onready var shop2 = $Upgrades2

func start_game(recipes):
	game.set_recipes(recipes)
	fade.fade_call(start_game_h)

func start_game_h():
	prep.hide()
	shop.hide()
	shop2.hide()
	game.reset()
	game.start()
	game.show()

func complete_game():
	fade.fade_call(complete_game_h)

func complete_game_h():
	game.hide()
	shop.hide()
	shop2.hide()
	game.stop()
	game.reset()
	prep.show()
	prep.populate_recipes()

func open_shop():
	shop.on_open()
	fade.fade_call(open_shop_h)

func open_shop_h():
	prep.hide()
	game.hide()
	shop2.hide()
	shop.show()

func open_shop2():
	shop2.on_open()
	fade.fade_call(open_shop2_h)

func open_shop2_h():
	prep.hide()
	game.hide()
	shop.hide()
	shop2.show()

func close_shop():
	fade.fade_call(close_shop_h)

func close_shop_h():
	game.hide()
	shop.hide()
	shop2.hide()
	prep.show()
	prep.populate_recipes()

func close_shop2():
	shop.on_open_from_back()
	fade.fade_call(close_shop2_h)

func close_shop2_h():
	prep.hide()
	game.hide()
	shop2.hide()
	shop.show()
