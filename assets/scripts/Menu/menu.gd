extends Node

@onready var fade_transition = $"Fade Transition"
@onready var animation_player = $"Fade Transition/AnimationPlayer"

@export var fade_time : float = 1

func _on_start_pressed() -> void:
	fade_transition.show()
	animation_player.play("fade_in")
	
	await get_tree().create_timer(fade_time).timeout
	get_tree().change_scene_to_file("res://assets/scenes/levels/level_1.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
