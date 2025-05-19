extends Control

@onready var main = $".."

func _ready() -> void:
	$ShopItem.set_item(
		{
			"title": "Prep Station",
			"price": 250,
			"callback": Callable.create(self, "buy_prep_station")
		}
	)
	$ShopItem2.set_item(
		{
			"title": "Bigger Store",
			"price": 111,
			"callback": Callable.create(self, "buy_shop_space")
		}
	)
	$Recipe1.set_item(
		{
			"title": "Crystal Ball",
			"price": 10,
			"callback": Callable.create(self, "buy_crystal_ball")
		}
	)
	$Recipe2.set_item(
		{
			"title": "Potion Recipe",
			"price": 1000,
			"callback": Callable.create(self, "buy_potion_recipe")
		}
	)

func buy_prep_station():
	GameGlobals.prep_station_count += 1
	if GameGlobals.prep_station_count >= 6:
		$ShopItem.set_item({"sold_out": true})

func buy_shop_space():
	GameGlobals.orders_count += 1
	if GameGlobals.orders_count >= 10:
		$ShopItem2.set_item({"sold_out": true})

func buy_crystal_ball():
	GameGlobals.unlocked_recipes.append("ponder")
	$Recipe1.set_item({"sold_out": true})

func buy_potion_recipe():
	GameGlobals.unlocked_recipes.append("potion")
	$Recipe2.set_item({"sold_out": true})

func _on_close_shop_pressed() -> void:
	main.close_shop()
