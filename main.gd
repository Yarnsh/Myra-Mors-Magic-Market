extends Control

@onready var fade = $Fade
@onready var game = $Game
@onready var prep = $GamePrep
@onready var shop = $Upgrades
@onready var shop2 = $Upgrades2
@onready var menu = $Menu
@onready var credits = $Credits
@onready var tutorial = $Tutorial

@onready var prep_music = $Music/PrepMusic
@onready var game_music = $Music/GameMusic

func start_game(recipes):
	menu.day_going(true)
	game.set_recipes(recipes)
	fade.fade_call(start_game_h)
	
	prep_music.stop() # TODO: fade this out

func start_game_h():
	prep.hide()
	shop.hide()
	shop2.hide()
	game.reset()
	game.start()
	game.show()
	game_music.play()

func complete_game():
	fade.fade_call(complete_game_h, 0.5)
	game_music.stop()
	menu.day_going(false)

func complete_game_h():
	game.hide()
	shop.hide()
	shop2.hide()
	game.stop()
	game.reset()
	prep.show()
	credits.hide()
	prep.populate_recipes()
	prep.manim.play("Returning")
	
	prep_music.play()

func open_shop():
	fade.fade_call(open_shop_h)

func open_shop_h():
	shop.on_open()
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
	prep.manim.play("Returning")

func close_shop2():
	fade.fade_call(close_shop2_h)

func close_shop2_h():
	shop.on_open_from_back()
	prep.hide()
	game.hide()
	shop2.hide()
	shop.show()

func first_start():
	menu.day_going(false)
	fade.fade_call(first_start_h)

func first_start_h():
	menu.myra_sprite.hide()
	menu.bg.modulate = Color(1, 1, 1, 0.5)
	game_music.stop()
	GameGlobals.menu_up = false
	menu.hide()
	game.hide()
	shop.hide()
	shop2.hide()
	prep.show()
	prep.populate_recipes()
	prep_music.play()

func show_credits():
	fade.fade_call(show_credits_h, 0.2)

func show_credits_h():
	prep_music.stop()
	game.hide()
	shop.hide()
	shop2.hide()
	prep.hide()
	credits.start()

func start_tutorial():
	menu.hide()
	tutorial.start()

func stop_tutorial():
	menu.show()
