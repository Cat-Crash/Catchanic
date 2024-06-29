extends Node

# NOTE copied from DialogueNode, not sure if it'll stay here, but just for the purpose of messing
# around
class DialogueState: # holds everything a single piece of dialogue needs (LIST LATER)
	enum SpeakingParty {SPEAKER, PLAYER} # Designates who's speaking so that the DialogueNode knows
		# which name and location to pull
	
	var speakingParty : SpeakingParty
	var speechText : String # the text to be displayed
	# var speechSound EVENTUALLY this will be a sound effect that can be played if not empty
	
	@warning_ignore("untyped_declaration") # literally impossible to put an output declaration for
		# a constructor
	func _init(_speakingParty : SpeakingParty, _speechText : String):
		speakingParty = _speakingParty
		speechText = _speechText
		
var lineDelimiter : String = '\n' # what we're using to split lines in the script
var nameDelimiter : String = ':' # what we're using to split the name from the line

func stringToDialogue(script : String) -> Array[DialogueState]:
	var scriptLines : PackedStringArray
	var dialoguePath : Array[DialogueState] = Array()
	
	scriptLines = script.split(lineDelimiter)
	
	var speakingPartyStr : String # Used to store the speaker below so it can be checked and
		# converted to a SpeakingParty
	var speakingParty : DialogueState.SpeakingParty # Stores the speaker once it's converted
	var lineText : String # Stores the text of the line
	for line : String in scriptLines:
		speakingPartyStr = line.get_slice(nameDelimiter, 0) # takes the first part of the line as the name
		if "player".is_subsequence_ofn(speakingPartyStr):
			speakingParty = DialogueState.SpeakingParty.PLAYER
		else:
			speakingParty = DialogueState.SpeakingParty.SPEAKER
		
		lineText = line.get_slice(nameDelimiter, 1) # takes the second part of the line as the text
		
		dialoguePath.append(DialogueState.new(speakingParty, lineText))

	return dialoguePath # return the compiled array of DialogueStates
