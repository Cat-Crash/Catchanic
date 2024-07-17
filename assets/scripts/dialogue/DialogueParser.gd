class_name DialogueParser

extends Node
		
const lineDelimiter : String = '\n' # what we're using to split lines in the script
const nameDelimiter : String = ':' # what we're using to split the name from the line
const soundDelimiter : String = '/'


static func stringToDialogue(script : String) -> Array[DialogueNode.DialogueState]:
	var scriptLines : PackedStringArray
	var dialoguePath : Array[DialogueNode.DialogueState] = []
	
	scriptLines = script.split(lineDelimiter)
	
	var speakingPartyStr : String # Used to store the speaker below so it can be checked and
		# converted to a SpeakingParty
	var speakingParty : DialogueNode.DialogueState.SpeakingParty # Stores the speaker once it's converted
	var lineText : String # Stores the text of the line
	var soundIDStr : String # Stores the file ID of the sound file to be played, if none then this
		# is empty. The name does not include the SFX_ at the beginning or .WAV at the end, since all
		# such files have those the parser adds them automatically
	var sound : AudioStream # The sound file to be played, if none then this is null
	for line : String in scriptLines:
		speakingPartyStr = line.get_slice(nameDelimiter, 0) # takes the first part of the line as the name
		if "player".is_subsequence_ofn(speakingPartyStr):
			speakingParty = DialogueNode.DialogueState.SpeakingParty.PLAYER
		else:
			speakingParty = DialogueNode.DialogueState.SpeakingParty.SPEAKER
		
		lineText = line.get_slice(nameDelimiter, 1) # takes the second part of the line as the text
		while lineText.begins_with(' '): # remove any spaces at the start of the line
			lineText = lineText.erase(0) # erases the first character after position 0
		
		if '|'.is_subsequence_of(line):
			soundIDStr = line.get_slice(soundDelimiter, 1) # gets the name of the sound effect, returns
				# empty if there is none
			if soundIDStr:
				sound = load('res://assets/audio/sounds/SFX_' + soundIDStr + '.wav')
			else:
				push_error('Line has a sound delimeter but no sound name')
		else: # if there is no sound delimiter, we can just mark the sound for this line as null
			sound = null
		
		dialoguePath.append(DialogueNode.DialogueState.new(speakingParty, lineText, sound))

	return dialoguePath # return the compiled array of DialogueStates
