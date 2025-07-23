extends Sprite2D

@onready var anim = $Anim
@onready var croak = $Croak

func _on_frog_clicker_clicked() -> void:
	croak.stop()
	croak.play()
	anim.stop()
	anim.play("Poke")
