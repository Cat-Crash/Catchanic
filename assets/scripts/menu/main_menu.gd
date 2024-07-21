extends Node

@onready var fade_transition : FadeTransition = $"Fade Transition"
@onready var bgm = $BGM

@export var start_level : PackedScene
@export var start_sound : AudioStream

func _on_start_pressed() -> void:
	bgm.stop()
	bgm.stream = start_sound
	bgm.play()
	
	fade_transition.fade_out()
	await fade_transition.done
	get_tree().change_scene_to_packed(start_level)

func _on_exit_pressed() -> void:
	get_tree().quit()
