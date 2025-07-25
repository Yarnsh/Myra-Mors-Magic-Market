extends Control

@onready var main = $".."
@onready var text = $Text
@onready var hor = $Horatius/Horatius
@onready var horanim = $Horatius/Anim
@onready var speech_bubble = $Horatius/SpeechBubble
@onready var backroom_entry = $BackRoom
@onready var talkin = $Talkin

@onready var money_sfx = $MoneySFX
@onready var bad_sfx = $BadSFX
@onready var enter_sfx = $EnterSFX
@onready var back_enter_sfx = $BackEnterSFX
@onready var exit_sfx = $ExitSFX

@onready var myra_anim = $Myras/Anim

@onready var mumble1 = $Mumble1
@onready var mumble2 = $Mumble2
@onready var mumble3 = $Mumble3
@onready var mumble4 = $Mumble4

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
			"price": 500,
			"callback": Callable.create(self, "buy_shop_space"),
			"description": "Increase the size of your store, allowing more customers.\nAlso increases the maximum vibe. \nIntroduces a bit of a fire hazard..."
		}
	)
	$PrepStation.set_item(
		{
			"title": "Prep Station",
			"price": 4000,
			"callback": Callable.create(self, "buy_prep_station"),
			"description": "A station to prepare orders ahead of time.\nRequired for some recipes."
		}
	)
	$CrystalBall.set_item(
		{
			"title": "Crystal Ball",
			"price": 1499,
			"callback": Callable.create(self, "buy_crystal_ball"),
			"description": "Read people's fortunes for money.\nCustomers will leave hefty tips for good news!"
		}
	)
	$PaintSet.set_item(
		{
			"title": "Paint Set",
			"price": 10,
			"callback": Callable.create(self, "buy_paint_set"),
			"description": "Draw paper charms for customers.\nNothing special, but very quick to make."
		}
	)

func win():
	print("You would win now")

func buy_prep_station():
	GameGlobals.prep_station_count += 1
	if GameGlobals.prep_station_count >= 1:
		$PrepStation.set_item({"sold_out": true})
		text.hide()
	if GameGlobals.prep_station_count == 1:
		horanim.play("Move")
	else:
		buy_response()

func buy_shop_space():
	GameGlobals.orders_count += 1
	if GameGlobals.orders_count >= 10:
		$ShopSpace.set_item({"sold_out": true})
		text.hide()
	else:
		var oc = GameGlobals.orders_count - 1
		$ShopSpace.set_item({
			"title": "Space Upgrade " + str(oc),
			"price": 500 * (oc * oc),
			"callback": Callable.create(self, "buy_shop_space"),
			"description": "Increase the size of your store. \nIncreases max customers, vibe, and customer patience."
		})
	if GameGlobals.orders_count == 3:
		GameGlobals.current_chores.append(GameGlobals.fire_chore)
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
	mumble1.play()
	main.close_shop()
	text.hide()
	exit_sfx.play()
	speech_bubble.say("See ya")
	myra_anim.play("Exit")

func buy_response():
	mumble1.play()
	hor.set_emotion(1)
	money_sfx.play()
	# TODO: random selection of things to say
	speech_bubble.say("Smart purchase, buying more stuff would be even smarter")

func poor_response():
	mumble2.play()
	hor.set_emotion(3)
	bad_sfx.play()
	speech_bubble.say("Sorry, I don't give credit")

func on_open():
	mumble3.play()
	hor.set_emotion(0)
	enter_sfx.play()
	speech_bubble.say("Welcome in, what are you looking for today?")
	myra_anim.play("Enter")

func on_open_from_back():
	mumble3.play()
	hor.set_emotion(0)
	back_enter_sfx.play()
	speech_bubble.say("Find anything good back there?")

func hor_anim_1():
	talkin.show()
	mumble4.play()
	money_sfx.play()
	GameGlobals.fade_happening = true
	main.fade.mouse_filter = MOUSE_FILTER_STOP
	hor.set_emotion(1)
	speech_bubble.say("Now you're running a real shop!")
func hor_anim_2():
	mumble2.play()
	hor.set_emotion(0)
	speech_bubble.say("Maybe you could use some of my special stock.")
func hor_anim_3():
	talkin.hide()
	mumble4.play()
	GameGlobals.fade_happening = false
	main.fade.mouse_filter = MOUSE_FILTER_IGNORE
	hor.set_emotion(0)
	speech_bubble.say("Feel free to look at the stuff in the back.")
