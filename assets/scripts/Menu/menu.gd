extends Node

var button_type = null


func _on_start_pressed():
	button_type = "Start"
	$fade_transition.show()
	$fade_transition/fade_timer.start()
	$fade_transition/AnimationPlayer.play("fade_in")



func _on_exit_pressed():
	get_tree().quit()


func _on_fade_timer_timeout():
	if button_type == "Start" : #check the button_type, not necessary for now, but could be useful for future buttons and scene transitions
		get_tree().change_scene_to_file("res://assets/scenes/levels/level_1.tscn")
	
