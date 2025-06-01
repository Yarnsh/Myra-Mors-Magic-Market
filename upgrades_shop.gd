extends Control

@onready var main = $".."
@onready var text = $Text

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

func win():
	print("You would win now")

func buy_prep_station():
	GameGlobals.prep_station_count += 1
	if GameGlobals.prep_station_count >= 1:
		$PrepStation.set_item({"sold_out": true})
		text.hide()
		# TODO: play a cutscene, and enable access to the back room

func buy_shop_space():
	GameGlobals.orders_count += 1
	if GameGlobals.orders_count >= 5:
		$ShopSpace.set_item({"sold_out": true})
		text.hide()

func buy_crystal_ball():
	GameGlobals.unlocked_recipes.append("ponder")
	$CrystalBall.set_item({"sold_out": true})
	text.hide()

func _on_close_shop_pressed() -> void:
	main.close_shop()
	text.hide()
