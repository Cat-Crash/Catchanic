extends Area2D

@export var goal: int

signal part_complete(type: Enums.PartType)

func _on_body_entered(body: PuzzlePart):
	if body.target_piece and body.target_goal == goal:
		body.global_position = global_position
		part_complete.emit(body)
		body.complete()
