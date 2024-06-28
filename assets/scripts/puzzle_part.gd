extends Node2D

@export var moveX: bool
@export var moveY: bool
@export var snap: int

var selected: bool = false
var realPos: Vector2

func _process(delta):
	position = realPos.snapped(Vector2(snap, snap))

func _input(event):
	if event is InputEventMouseMotion and selected:
		var mouseDelta: Vector2 = event.relative
		if moveX: realPos.x += mouseDelta.x
		if moveY: realPos.y += mouseDelta.y


func _on_button_button_down():
	selected = true
	realPos = position

func _on_button_button_up():
	selected = false
