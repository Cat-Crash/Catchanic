class_name ProjectState
extends Node

var playerPosition : Vector3 = Vector3(0, 0, 0) # tracks the position of the player

var overworld : GameMode

var currentGameState : ProjectEnums.GameState

# String -> NPC Node lookup
var npcs : Dictionary
