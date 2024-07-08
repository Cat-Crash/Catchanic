class_name NPC
extends AnimatableBody3D

@onready var interactable_root = $Interactables

@export var active_interactable : int
var interactables : Array[Interactable]
var player_inside : bool

func _ready():
	var children : Array[Node] = interactable_root.get_children() #NOTE temp
	for child in children: #NOTE temp
		if child is Interactable:
			interactables.append(child)
		else:
			push_error('non interactable under interactables')
	#interactables = interactable_root.get_children() as Array[Interactable]

func _input(event):
	if event.is_action("interact") and player_inside:
		interactables[active_interactable].activate()

func _on_detection_zone_body_entered(body):
	if body is Player: player_inside = true

func _on_detection_zone_body_exited(body):
	if body is Player: player_inside = false
