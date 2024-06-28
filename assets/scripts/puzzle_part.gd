class_name PuzzlePart
extends CharacterBody2D

@export_category("Movement")
@export var move_x: bool
@export var move_y: bool
@export var snap: int

@export_category("Part Behavior")
@export var target_piece: bool = false
@export var target_goal: int = -1

var snap_vect: Vector2
var selected: bool = false

func _ready():
	snap_vect = Vector2(snap, snap)

func _process(delta):
	if not selected: return
	
	var currPos: Vector2 = self.global_position
	var mousePos: Vector2 = get_global_mouse_position().snapped(snap_vect)
	
	velocity = (mousePos - currPos) / delta
	if not move_x: velocity.x = 0
	if not move_y: velocity.y = 0
	
	move_and_slide()

func complete(remove: bool):
	move_x = false
	move_y = false
	
	if remove: queue_free()

func _on_button_button_down():
	selected = true

func _on_button_button_up():
	selected = false
