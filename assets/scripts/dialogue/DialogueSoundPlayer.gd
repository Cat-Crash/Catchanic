extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	var dialogueNodes : Array[DialogueNode]
	
	# collects all the dialoguenodes in the NPC this is attached to
	var children : Array[Node] = GlobalUtilities.get_all_children(get_parent())
	for child : Node in children:
		if child is DialogueNode:
			dialogueNodes.append(child)

	# connects every DialogueNode gathered earlier to signal this when they need to play a sound
	for dialogueNode : DialogueNode in dialogueNodes:
		dialogueNode.playDialogueSound.connect(play_sound)
		
func play_sound(sound : AudioStream) -> void:
	set_stream(sound)
	play()
