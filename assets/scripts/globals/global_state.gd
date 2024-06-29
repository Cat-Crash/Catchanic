class_name ProjectState
extends Node

var currentGameState : ProjectEnums.GameState: 
	set(state):
		currentGameState = state
		state_change.emit(state)
# tracks the state of the game

signal state_change(state: ProjectEnums.GameState)

var playerPosition : Vector3 # tracks the position of the player
