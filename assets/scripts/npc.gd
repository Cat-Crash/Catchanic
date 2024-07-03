extends AnimatableBody3D

@onready var interactable_parent = $Interactables

var activeInteractable: int
var interactables: Array[Interactable]
var player_inside: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	interactables = interactable_parent.get_children() as Array[Interactable]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action("interact"):
		pass # activate interactable from here

func _on_detection_zone_body_entered(body):
	if body is Player: player_inside = true

func _on_detection_zone_body_exited(body):
	if body is Player: player_inside = false
