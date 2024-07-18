class_name NPC
extends AnimatableBody3D

@onready var popup : Control = $Popup # a little popup displayed when the player is in range to show
	# that the NPC can be interacted with

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
	popup.visible = false
			
func _process(_delta: float) -> void:
	popup.position = get_viewport().get_camera_3d().unproject_position(global_transform.origin)
		# makes sure the popup is in the right place over the NPC relative to the camera

func _input(event: InputEvent) -> void:
	if event.is_action("interact") and player_inside and GlobalState.currentGameState == GlobalEnums.GameState.OVERWORLD:
		popup.visible = false # we don't need to see the pop up if we're in another menu
		interactables[active_interactable].activate()

func _on_detection_zone_body_entered(body : CollisionObject3D) -> void:
	if body is Player:
		player_inside = true
		popup.visible = true

func _on_detection_zone_body_exited(body: CollisionObject3D) -> void:
	if body is Player:
		player_inside = false
		popup.visible = false
