class_name NPC
extends AnimatableBody3D

@onready var interactable_root = $Interactables

@export var active_interactable : int
var interactables : Array[Interactable]
var player_inside : bool

func _ready() -> void:
	interactable_root.get_children().assign(interactables)

func _input(event) -> void:
	if event.is_action("interact") and player_inside:
		interactables[active_interactable].activate()

func _on_detection_zone_body_entered(body) -> void:
	if body is Player: player_inside = true

func _on_detection_zone_body_exited(body) -> void:
	if body is Player: player_inside = false
