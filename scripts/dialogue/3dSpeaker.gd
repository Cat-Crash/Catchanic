extends Node3D

@onready var dialogueNode : Node = $"../DialogueNode" # The dialogueNode attached to the speaker

func _on_dialogue_node_reposition_dialogue_area():
	dialogueNode.speakerPos = get_viewport().get_camera_3d().unproject_position(global_transform.origin)
		# sets the position of this as the speaker pos
	# NOTE once you have a game manager and a general static idea of where the player is, put that
	# here, assigning it to dialogueNode.playerPos
	dialogueNode.updateDialogueDisplay(dialogueNode.dialoguePath[dialogueNode.pathPosition]) # now
		# that it knows the proper player and speaker positions, have it update its display
