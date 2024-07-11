class_name ProjectState
extends Node

const STATE_CHANGE_DELAY: float = 0.5

var playerPosition : Vector3 = Vector3(0, 0, 0) # tracks the position of the player

var overworld : GameMode

var currentGameState : ProjectEnums.GameState:
	set(state):
		await get_tree().create_timer(STATE_CHANGE_DELAY).timeout
		currentGameState = state

# String -> NPC Node lookup
var npcs : Dictionary
