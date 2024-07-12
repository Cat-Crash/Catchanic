class_name DialogueParser

extends Node
		
static var lineDelimiter : String = '\n' # what we're using to split lines in the script
static var nameDelimiter : String = ':' # what we're using to split the name from the line

static func stringToDialogue(script : String) -> Array[DialogueNode.DialogueState]:
	var scriptLines : PackedStringArray
	var dialoguePath : Array[DialogueNode.DialogueState] = []
	
	scriptLines = script.split(lineDelimiter)
	
	var speakingPartyStr : String # Used to store the speaker below so it can be checked and
		# converted to a SpeakingParty
	var speakingParty : DialogueNode.DialogueState.SpeakingParty # Stores the speaker once it's converted
	var lineText : String # Stores the text of the line
	for line : String in scriptLines:
		speakingPartyStr = line.get_slice(nameDelimiter, 0) # takes the first part of the line as the name
		if "player".is_subsequence_ofn(speakingPartyStr):
			speakingParty = DialogueNode.DialogueState.SpeakingParty.PLAYER
		else:
			speakingParty = DialogueNode.DialogueState.SpeakingParty.SPEAKER
		
		lineText = line.get_slice(nameDelimiter, 1) # takes the second part of the line as the text
		while lineText.begins_with(' '): # remove any spaces at the start of the line
			lineText = lineText.erase(0) # erases the first character after position 0
		
		dialoguePath.append(DialogueNode.DialogueState.new(speakingParty, lineText))

	return dialoguePath # return the compiled array of DialogueStates
