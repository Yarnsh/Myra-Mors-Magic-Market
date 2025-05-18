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

func buy_prep_station():
	GameGlobals.prep_station_count += 1
	if GameGlobals.prep_station_count >= 6:
		$ShopItem.set_item({"sold_out": true})


func _on_close_shop_pressed() -> void:
	main.close_shop()
