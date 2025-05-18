extends Control

@onready var main = $".."

func _ready() -> void:
	$ShopItem.set_item(
		{
			"title": "A Test",
			"price": 250,
			"callback": Callable.create(self, "test_callback")
		}
	)

func test_callback():
	print("all good")


func _on_close_shop_pressed() -> void:
	main.close_shop()
