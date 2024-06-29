extends Node2D

@export var next_scene: Node

const GAMESTATE: ProjectEnums.GameState = ProjectEnums.GameState.PUZZLE

var oldParts: int
var newParts: int

func _ready():
# Count all parts to be installed or uninstall in scene
	for child in get_children():
		if child is PuzzlePart:
			var childPart: PuzzlePart = child as PuzzlePart
			if childPart.type == ProjectEnums.PartType.INSTALL: newParts += 1
			elif childPart.type == ProjectEnums.PartType.UNINSTALL: oldParts += 1


# Remove completed part from count and check for completion
func _on_exit_goal_part_complete(type):
	if type == ProjectEnums.PartType.INSTALL: newParts -= 1
	elif type == ProjectEnums.PartType.UNINSTALL: oldParts -= 1
	else: push_error("Unexpected Part Type has been Completed")
	
	if newParts < 1 and oldParts < 1:
		GlobalUtilities.switch_scene(self, next_scene)
