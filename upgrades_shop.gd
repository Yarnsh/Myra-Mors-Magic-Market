extends Control

@onready var main = $".."
@onready var text = $Text
@onready var hor = $Horatius
@onready var speech_bubble = $SpeechBubble

@onready var money_sfx = $MoneySFX
@onready var bad_sfx = $BadSFX
@onready var enter_sfx = $EnterSFX
@onready var exit_sfx = $ExitSFX

func _ready() -> void:
	$WinCondition.set_item(
		{
			"title": "WIN!",
			"price": 1000000,
			"callback": Callable.create(self, "win"),
			"description": "It's everything you've ever wanted..."
		}
	)
	$ShopSpace.set_item(
		{
			"title": "Space Upgrade",
			"price": 1000,
			"callback": Callable.create(self, "buy_shop_space"),
			"description": "Increase the size of your store, allowing more customers at once"
		}
	)
	$PrepStation.set_item(
		{
			"title": "Prep Station",
			"price": 25000,
			"callback": Callable.create(self, "buy_prep_station"),
			"description": "A station to prepare orders ahead of time\nRequired for some recipes"
		}
	)
	$CrystalBall.set_item(
		{
			"title": "Crystal Ball",
			"price": 10,
			"callback": Callable.create(self, "buy_crystal_ball"),
			"description": "Read people's fortunes for money\nCustomers will leave hefty tips for good news"
		}
	)
	$PaintSet.set_item(
		{
			"title": "Paint Set",
			"price": 10,
			"callback": Callable.create(self, "buy_paint_set"),
			"description": "Draw paper charms for customers\nPeople love these cheap soveneirs, selling this will attract a lot of customers"
		}
	)

func win():
	print("You would win now")

func buy_prep_station():
	GameGlobals.prep_station_count += 1
	if GameGlobals.prep_station_count >= 1:
		$PrepStation.set_item({"sold_out": true})
		text.hide()
		# TODO: play a cutscene, and enable access to the back room
	buy_response()

func buy_shop_space():
	GameGlobals.orders_count += 1
	if GameGlobals.orders_count >= 5:
		$ShopSpace.set_item({"sold_out": true})
		text.hide()
	buy_response()

func buy_crystal_ball():
	GameGlobals.unlocked_recipes.append("ponder")
	$CrystalBall.set_item({"sold_out": true})
	text.hide()
	buy_response()

func buy_charge_crystal():
	GameGlobals.unlocked_recipes.append("crystal")
	$TODO.set_item({"sold_out": true})
	text.hide()
	buy_response()

func buy_gong():
	GameGlobals.unlocked_recipes.append("gong")
	$TODO.set_item({"sold_out": true})
	text.hide()
	buy_response()

func buy_paint_set():
	GameGlobals.unlocked_recipes.append("slip")
	$PaintSet.set_item({"sold_out": true})
	text.hide()
	buy_response()

func _on_close_shop_pressed() -> void:
	# TODO: fadeout
	main.close_shop()
	text.hide()
	exit_sfx.play()
	speech_bubble.say("See ya")

func buy_response():
	hor.set_emotion(1)
	money_sfx.play()
	# TODO: random selection of things to say
	speech_bubble.say("Smart purchase, buying more stuff would be even smarter")

func poor_response():
	hor.set_emotion(3)
	bad_sfx.play()
	speech_bubble.say("Sorry, I don't give credit")

func on_open():
	hor.set_emotion(0)
	enter_sfx.play()
	speech_bubble.say("Welcome in, what are you looking for today?")
