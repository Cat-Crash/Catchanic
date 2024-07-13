class_name PuzzleGoal
extends Area2D

@export var goal: int

signal part_complete(type: bool)

func _on_body_entered(body: PuzzlePart) -> void:
	if body.goal_part and body.target_goal == goal:
		#body.global_position = global_position
		part_complete.emit(body.goal_part)
		body.complete()
