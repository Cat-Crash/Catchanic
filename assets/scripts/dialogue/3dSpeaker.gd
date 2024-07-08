# Manages the DialogueNodes in an NPC, giving them the position of said NPC

extends Node3D

func _ready():
	var children : Array[Node] = GlobalUtilities.get_all_children(self)
	for child in children:
		if child is DialogueNode:
			child.getGlobalSpeakerPos.connect(Callable(self, "_on_dialogue_node_get_global_speaker_pos"))

func _on_dialogue_node_get_global_speaker_pos(dialogueNode : DialogueNode) -> void:
	dialogueNode.speakerPos = get_viewport().get_camera_3d().unproject_position(global_transform.origin)
		# sets the position of this as the speaker pos
