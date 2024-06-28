extends Control

signal nextDialogueSignal

func _gui_input(event : InputEvent) -> void:
	if event.is_action_pressed('nextDialogue'): # if one of the inputs for nextDialogue is inputted
		# while the dialogue area is focused, send out a signal for it so the DialogueNode can go on
		nextDialogueSignal.emit()
