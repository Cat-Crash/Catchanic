class_name NPC
extends AnimatableBody3D

@onready var interactable_root : Node3D = $Interactables

@export var active_interactable : int
var interactables : Array[Interactable]
var player_inside : bool

func _ready() -> void:
	var children : Array[Node] = interactable_root.get_children()
	for child : Node in children:
		if child is Interactable:
			interactables.append(child)
		else:
			push_error('Non interactable in interactables')

func _input(event: InputEvent) -> void:
	if event.is_action("interact") and player_inside:
		interactables[active_interactable].activate()

func _on_detection_zone_body_entered(body : CollisionObject3D) -> void:
	if body is Player: player_inside = true

func _on_detection_zone_body_exited(body: CollisionObject3D) -> void:
	if body is Player: player_inside = false
