extends Node

static var playerPosition : Vector3

static var inDialogue : bool # True if the player is in a dialogue, false if they're not

func _on_cat_player_position_changed(newPosition):
	playerPosition = newPosition

func _on_crow_begin_dialogue():
	inDialogue = true

func _on_crow_end_dialogue():
	inDialogue = false
