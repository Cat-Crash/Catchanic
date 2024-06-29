extends Node3D

@onready var dialogueNode : Node = $"DialogueNode" # The dialogueNode attached to the speaker

signal beginDialogue # emitted when dialogue begins
signal endDialogue # emitted when dialogue ends

var playerInRange : bool = false # True if the player is within the crow's Area3D and thus can
	# talk to it

func _on_dialogue_node_reposition_dialogue_area() -> void:
	dialogueNode.speakerPos = get_viewport().get_camera_3d().unproject_position(global_transform.origin)
		# sets the position of this as the speaker pos
	dialogueNode.playerPos = get_viewport().get_camera_3d().unproject_position(GlobalState.playerPosition)
		# sets the position of the player that the game manager has as the playerPos
	dialogueNode.updateDialogueDisplay(dialogueNode.dialoguePath[dialogueNode.pathPosition]) # now
		# that it knows the proper player and speaker positions, have it update its display

func _input(event : InputEvent) -> void:
	if event.is_action_pressed('interact') and playerInRange and (GlobalState.currentGameState == ProjectEnums.GameState.OVERWORLD ):
		GlobalState.currentGameState = ProjectEnums.GameState.DIALOGUE
		dialogueNode.beginDialoguePath()

func _on_dialogue_node_end_of_dialogue() -> void:
	GlobalState.currentGameState = ProjectEnums.GameState.OVERWORLD

func _on_body_entered(_body : Node3D) -> void:
	#print("WELCOME TO THE CROW ZONE")
	playerInRange = true

func _on_body_exited(_body : Node3D) -> void:
	#print("NOW LEAVING THE CROW ZONE")
	playerInRange = false
