extends Control

@onready var anim = $AnimationPlayer

func start():
	show()
	anim.play("Credits")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_parent().complete_game()
