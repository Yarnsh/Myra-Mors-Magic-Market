extends Control

@onready var text = $Text
@onready var room_noise = $RoomNoise
@onready var money_sfx = $MoneySFX
@onready var bad_sfx = $BadSFX
@onready var anim = $Anim
@onready var manim = $MyraAnim

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Accountant.set_item(
		{
			"title": "Accountant",
			"price": 20000,
			"callback": Callable.create(self, "buy_accountant"),
			"description": "With his help you won't pay ANY taxes on your revenue! But you will have to fill out some annoying forms sometimes."
		}
	)
	$Crystals.set_item(
		{
			"title": "Crystals",
			"price": 1984,
			"callback": Callable.create(self, "buy_crystals"),
			"description": "Prepare some pre-charged crystals that customers will buy along with their order. Will DOUBLE what they pay!"
		}
	)
	$Incense.set_item(
		{
			"title": "Incense",
			"price": 3000,
			"callback": Callable.create(self, "buy_incense"),
			"description": "Light some incense in the store to create a nice ambiance and increase the vibes as long as it's burning."
		}
	)
	$Cauldron.set_item(
		{
			"title": "Cauldron",
			"price": 15000,
			"callback": Callable.create(self, "buy_cauldron"),
			"description": "Cauldron to prepare potions for sale. This staple of any magic shop sells for a good price and loved by all."
		}
	)
	$Gong.set_item(
		{
			"title": "Gong",
			"price": 15000,
			"callback": Callable.create(self, "buy_gong"),
			"description": "A gong who's ring will dispell evil spirits. Gives a boost to vibe when used successfully."
		}
	)
	$PrepStation.set_item(
		{
			"title": "Prep Station 2",
			"price": 4000,
			"callback": Callable.create(self, "buy_prep_station"),
			"description": "A station to prepare orders ahead of time\nRequired for some recipes"
		}
	)

func buy_response():
	money_sfx.play()

func buy_accountant():
	# TODO: enable tax-free and the chore
	$Accountant.set_item({"sold_out": true})
	GameGlobals.tax_free = true
	GameGlobals.current_chores.append(GameGlobals.taxes_chore)
	text.hide()
	buy_response()

func buy_crystals():
	GameGlobals.unlocked_recipes.append("crystal")
	$Crystals.set_item({"sold_out": true})
	text.hide()
	buy_response()

func buy_incense():
	GameGlobals.unlocked_recipes.append("incense")
	$Incense.set_item({"sold_out": true})
	text.hide()
	buy_response()

func buy_cauldron():
	GameGlobals.unlocked_recipes.append("potion")
	$Cauldron.set_item({"sold_out": true})
	text.hide()
	buy_response()

func buy_gong():
	GameGlobals.unlocked_recipes.append("gong")
	$Gong.set_item({"sold_out": true})
	text.hide()
	buy_response()

func buy_prep_station():
	GameGlobals.prep_station_count += 1
	if GameGlobals.prep_station_count >= 6:
		$PrepStation.set_item({"sold_out": true})
		text.hide()
	else:
		$PrepStation.set_item({
			"title": "Prep Station " + str(GameGlobals.prep_station_count + 1),
			"price": 4000 * (GameGlobals.prep_station_count * GameGlobals.prep_station_count),
			"callback": Callable.create(self, "buy_prep_station"),
			"description": "A station to prepare orders ahead of time\nRequired for some recipes"
		})
	buy_response()

func _on_back_button_pressed() -> void:
	room_noise.stop()
	anim.pause()
	manim.play("Exit")
	get_parent().close_shop2()

func on_open():
	manim.play("Enter")
	room_noise.play()
	anim.play("default")

func poor_response():
	bad_sfx.play()
