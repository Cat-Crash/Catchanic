extends Area2D

@export var goal: int

signal part_complete(type: ProjectEnums.PartType)

func _on_body_entered(body: PuzzlePart) -> void:
	if body.type != ProjectEnums.PartType.NEUTRAL and body.target_goal == goal:
		body.global_position = global_position
		part_complete.emit(body.type)
		body.complete()
