extends TextureRect

@onready var anim = $Anim
var callable = null

func fade_call(method: Callable):
	GameGlobals.fade_happening = true
	callable = method
	anim.play("Fade")

func fade_callback():
	if callable != null:
		callable.call()

func _on_anim_animation_finished(anim_name: StringName) -> void:
	GameGlobals.fade_happening = false
