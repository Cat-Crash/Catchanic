extends Node2D

var selected: bool = false

signal button_release


func _input(event):
	if event is InputEventMouseMotion and selected:
		position += event.relative


func _on_button_button_down():
	selected = true


func _on_button_button_up():
	selected = false
