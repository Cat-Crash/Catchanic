extends Node

func _on_start_pressed() -> void:
	$fade_transition.show()
	$fade_transition/fade_timer.start()
	$fade_transition/AnimationPlayer.play("fade_in")



func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_fade_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://assets/scenes/levels/level_1.tscn")
	
