extends Node2D

@export var installing: bool 


func _on_goal_part_complete(part: PuzzlePart):
	part.complete(not installing)
