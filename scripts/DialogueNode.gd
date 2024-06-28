extends Node

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
	
@export var speakerName : String = 'Default Name' # The name of the speaker or object this is
	# attached to, to be set in the editor. Will be used for dialogue nametags
static var playerName : String = "Meonthany" # Display name for the player, can be changed later
	# but will be held consistent across all dialogues
	
# NOTE we still need to figure out a way to figure out how to line this up with the game world,
# there's assignment of a placeholder in _ready() right now that just sets them to (100, 100)
# and (300, 100) respectively
var speakerPos : Vector2i # A vector with the x and y this needs to be over the head of the speaker
var playerPos : Vector2i # A vector with the x and y this needs to be over the head of the player

var dialoguePath : Array[DialogueState] # The DialogueStates that a conversation with this scene
	# will go through
var pathPosition : int = 0 # Current position in the dialoguePath, begins at 0

var endFunction : String = 'backupFunc' # The name of the function to be called when the
	# dialoguePath ends, will presumably be changed from the backup
func backupFunc() -> void: # if not subbed, warns that you forgot to give it an endFunction
	push_warning('BACKUP FUNC USED: Your dialoguePath has no end function')

# Dialogue UI Elements
@onready var dialogueArea : Control = $DialogueArea # The GUI control for the dialogue box
@onready var dialogueBox : NinePatchRect = $DialogueArea/DialogueBox # the background for the
	# dialogue box
@onready var nameTag : RichTextLabel = $DialogueArea/NameTag # The text displaying the speaker's
	# nametag
@onready var dialogueText : RichTextLabel = $DialogueArea/DialogueText # The text displaying the
	# current dialogue
	
# NOTE FIGURE OUT A BETTER WAY TO STORE THIS LATER
var testDialoguePath : Array[DialogueState] = [
	DialogueState.new(DialogueState.SpeakingParty.SPEAKER, "Hello there, can you hear me?"),
	DialogueState.new(DialogueState.SpeakingParty.PLAYER, "Meow?"),
	DialogueState.new(DialogueState.SpeakingParty.SPEAKER, "Ah right. You're a cat"),
	DialogueState.new(DialogueState.SpeakingParty.PLAYER, "Meow meow!"),
	DialogueState.new(DialogueState.SpeakingParty.SPEAKER, "And a mechanic, yes, I know"),
]
func _ready() -> void: # NOTE just doing this on _ready() for now to make testing simpler
	speakerPos = Vector2i(100, 100)
	playerPos = Vector2i(300, 100)
	dialoguePath = testDialoguePath
	beginDialoguePath()
	
func beginDialoguePath() -> void:
	dialogueArea.visible = true # shows the dialogue box
	pathPosition = 0
	updateDialogueDisplay(dialoguePath[pathPosition])

func _on_dialogue_area_next_dialogue_signal() -> void: # When it receives the signal from DialogueArea,
	# calls nextDialogueState()
	nextDialogueState()

func nextDialogueState() -> void: # Moves to the next line of dialogue in the dialoguePath. If there are no
		# more lines, runs the end function
	pathPosition += 1
	if pathPosition < dialoguePath.size(): # if not at the end go to the next DIalogueState in the path
		updateDialogueDisplay(dialoguePath[pathPosition])
	else: # if at the end of the dialoguePath, hide the dialogue window and call the endFunction
		dialogueArea.visible = false # hides the dialogue box
		call(endFunction)
		
func updateDialogueDisplay(newState : DialogueState) -> void:
	dialogueArea.grab_focus() # Shift the focus to the dialogueArea so that it can receive inputs
	if newState.speakingParty == DialogueState.SpeakingParty.SPEAKER: # if speaker speaking, shows that
		nameTag.text = speakerName
		dialogueArea.position = speakerPos
	elif newState.speakingParty == DialogueState.SpeakingParty.PLAYER: # if player speaking, shows that
		nameTag.text = playerName
		dialogueArea.position = playerPos
	else: # if neither is speaking something has gone wrong, pushes an error
		push_error('Undefined speaker for text, make sure that the speakingParty is set correctly in your DialogueState')
	dialogueText.text = newState.speechText # updates the displayed text to that of the newState
