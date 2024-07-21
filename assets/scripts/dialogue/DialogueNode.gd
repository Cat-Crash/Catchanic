class_name DialogueNode
# A GameMode node for a conversation, stores a conversation as an Array of DialogueStates and
# iterates through them when interacted with

extends GameMode

@export var speakerName : String = 'Default Name' # The name of the speaker or object this is
	# attached to, to be set in the editor. Will be used for dialogue nametags
static var playerName : String = "Meonthany" # Display name for the player, can be changed later
	# but will be held consistent across all dialogues
	

var speakerPos : Vector2i # A vector with the x and y this needs to be over the head of the speaker
var playerPos : Vector2i # A vector with the x and y this needs to be over the head of the player

@export_multiline var dialogueRaw : String # All the dialogue for the conversation in string form, inputted per node
var dialoguePath : Array[DialogueState] # The DialogueStates that a conversation with this scene
	# will go through
var pathPosition : int = 0 # Current position in the dialoguePath, begins at 0

var endFunction : String = '' # The name of the function to be called when the
	# dialoguePath ends, if empty runs no function

# Dialogue UI Elements
@onready var dialogueArea : Control = $DialogueArea # The GUI control for the dialogue box
@onready var nameTag : RichTextLabel = $DialogueArea/NameTag # The text displaying the speaker's
	# nametag
@onready var dialogueText : RichTextLabel = $DialogueArea/DialogueText # The text displaying the
	# current dialogue
	
var dialogueOffset : Vector2 = Vector2(0, 0) # the offset of the box to make it over the speaker's
	# head instead of the center of them

signal playDialogueSound(sound : AudioStream) # a signal emitted when it needs to play a dialogue
	# sound effect, picked up by DialogueSoundPlayer

func _ready() -> void:
	mode_type = ProjectEnums.GameState.DIALOGUE # marks the mode type for the game mode
	
	dialoguePath = DialogueParser.stringToDialogue(dialogueRaw) # converts the raw dialogue string
		# inputted into a stored conversation

func set_active(active: bool) -> void:
	if active: beginDialoguePath()
	dialogueArea.visible = active # hides the dialogue box until we talk to someone
	super.set_active(active)

func beginDialoguePath() -> void:
	dialogueArea.visible = true # shows the dialogue box
	pathPosition = 0
	updateDialogueDisplay(dialoguePath[pathPosition])

func _input(event : InputEvent) -> void:
	if event.is_action_pressed('interact'):
		nextDialogueState()

func nextDialogueState() -> void: # Moves to the next line of dialogue in the dialoguePath. If there are no
		# more lines, runs the end function
	pathPosition += 1
	if pathPosition < dialoguePath.size(): # if not at the end go to the next DIalogueState in the path
		updateDialogueDisplay(dialoguePath[pathPosition])
	else: # if at the end of the dialoguePath, hide the dialogue window and call the endFunction
		if endFunction: # if the string isn't empty
			call(endFunction) # calls the arbitrary end function, if it has one
		
		mode_done.emit(self)
		
func updateDialogueDisplay(newState : DialogueState) -> void:
	if newState.speakingParty == DialogueState.SpeakingParty.SPEAKER: # if speaker speaking, shows that
		nameTag.text = speakerName
		speakerPos = get_viewport().get_camera_3d().unproject_position(global_transform.origin) # gets its position
		dialogueArea.position = speakerPos
	elif newState.speakingParty == DialogueState.SpeakingParty.PLAYER: # if player speaking, shows that
		nameTag.text = playerName
		playerPos = get_viewport().get_camera_3d().unproject_position(GlobalState.playerPosition)
			# sets the position of the player that the game manager has as the playerPos
		dialogueArea.position = playerPos
	else: # if neither is speaking something has gone wrong, pushes an error
		push_error('Undefined speaker for text, make sure that the speakingParty is set correctly in your DialogueState')
	dialogueArea.position += dialogueOffset # offsets it by the vector set for placing it above the head
	if dialogueArea.position.x < 0: # trims the position to the right of the left edge of the screen
			dialogueArea.position.x = 0
	if dialogueArea.position.y < 0: # trims the position below the top of the screen
		dialogueArea.position.y = 0 
	dialogueText.text = newState.speechText # updates the displayed text to that of the newState
	if newState.sound: # if the newState has an AudioStream attached
		playDialogueSound.emit(newState.sound)
	
class DialogueState: # holds everything a single piece of dialogue needs (LIST LATER)
	enum SpeakingParty {SPEAKER, PLAYER} # Designates who's speaking so that the DialogueNode knows
		# which name and location to pull

	var speakingParty : SpeakingParty
	var speechText : String # the text to be displayed
	var sound : AudioStream # a sound to be played when this DialogueState is selected

	@warning_ignore("untyped_declaration") # literally impossible to put an output declaration for
		# a constructor
	func _init(_speakingParty : SpeakingParty, _speechText : String, _sound : AudioStream = null):
		speakingParty = _speakingParty
		speechText = _speechText
		sound = _sound
