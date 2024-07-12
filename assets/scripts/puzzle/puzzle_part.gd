class_name PuzzlePart
extends CharacterBody2D

@export_category("Movement")
@export var move_x: bool
@export var move_y: bool
@export var snap: int

@export_category("Part Behavior")
@export var type: ProjectEnums.PartType = ProjectEnums.PartType.NEUTRAL
@export var target_goal: int = -1


var snap_vect: Vector2
var selected: bool = false

func _ready() -> void:
	snap_vect = Vector2(snap, snap)

func _process(delta: float) -> void:

	if not selected: return
	
	var currPos: Vector2 = self.global_position
	var mousePos: Vector2 = get_global_mouse_position().snapped(snap_vect)
	
	velocity = (mousePos - currPos) / delta

	if not move_x: velocity.x = 0
	if not move_y: velocity.y = 0
	
	move_and_slide()

func complete() -> void:
	move_x = false
	move_y = false
	
	if type == ProjectEnums.PartType.UNINSTALL: queue_free()

func _on_button_button_down() -> void:
	selected = true

func _on_button_button_up() -> void:
	selected = false
