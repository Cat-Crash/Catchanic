extends Node

static var playerPosition : Vector3

enum GameState {OVERWORLD, DIALOGUE, PUZZLE,}
static var currentGameState : GameState # tracks the state of the game

func _on_cat_player_position_changed(newPosition):
	playerPosition = newPosition

func _on_crow_begin_dialogue():
	currentGameState = GameState.DIALOGUE

func _on_crow_end_dialogue():
	currentGameState = GameState.OVERWORLD
