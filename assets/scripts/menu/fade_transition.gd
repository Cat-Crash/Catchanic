class_name FadeTransition
extends ColorRect

@onready var animation_player : AnimationPlayer = $AnimationPlayer

signal done()

func fade_in() -> void:
	animation_player.play("fade_in")
	
func fade_out() -> void:
	animation_player.play("fade_out")

func fade_done() -> void:
	done.emit()
