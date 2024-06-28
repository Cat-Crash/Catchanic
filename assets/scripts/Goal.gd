extends Area2D

@export var goal: int

signal part_complete(part: PuzzlePart)

func _on_body_entered(body: PuzzlePart):
	if body.target_piece and body.target_goal == goal:
		part_complete.emit(body)
