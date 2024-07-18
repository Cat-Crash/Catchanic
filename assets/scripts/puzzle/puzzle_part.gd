class_name PuzzlePart
extends CharacterBody2D

@onready var sound_player : AudioStreamPlayer2D = $PuzzleSoundPlayer

@export_category("Movement")
@export var move_x : bool
@export var move_y : bool
@export var snap : int

@export_category("Part Behavior")
@export var goal_part : bool
@export var target_goal : int = -1

@export_category("Sounds")
@export var pickup_sound : AudioStream
@export var drop_sound : AudioStream

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

func _on_button_button_down() -> void:
	selected = true
	_play_sound(pickup_sound)

func _on_button_button_up() -> void:
	selected = false
	_play_sound(drop_sound)

func _play_sound(sound : AudioStream) -> void:
	sound_player.stream = sound
	sound_player.play()
