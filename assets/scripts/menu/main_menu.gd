extends Node

@onready var fade_transition : FadeTransition = $"Fade Transition"

func _on_start_pressed() -> void:
	fade_transition.fade_in()
	await fade_transition.done
	get_tree().change_scene_to_file("res://assets/scenes/levels/level_1.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
