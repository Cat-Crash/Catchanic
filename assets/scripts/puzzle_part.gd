extends Node2D

@export var moveX: bool
@export var moveY: bool

var selected: bool = false

func _input(event):
	if event is InputEventMouseMotion and selected:
		var mouseDelta: Vector2 = event.relative
		if moveX: position.x += mouseDelta.x
		if moveY: position.y += mouseDelta.y


func _on_button_button_down():
	selected = true


func _on_button_button_up():
	selected = false
