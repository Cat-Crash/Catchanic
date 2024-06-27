extends Node2D

var selected: bool = false

signal button_release

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if selected: global_position = get_global_mouse_position()


func _on_button_button_down():
	selected = true


func _on_button_button_up():
	selected = false
