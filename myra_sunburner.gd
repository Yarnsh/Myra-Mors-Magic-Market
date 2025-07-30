extends Sprite2D

@export var replacement_sprite : Texture2D

func _ready() -> void:
	GameGlobals.sunburned.connect(replace)

func replace():
	texture = replacement_sprite
