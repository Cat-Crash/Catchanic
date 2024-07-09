extends GameMode

var oldParts: int
var newParts: int

func _ready() -> void:
	mode_type = ProjectEnums.GameState.PUZZLE
	
	var children: Array[Node] = GlobalUtilities.get_all_children(self)
# Count all parts to be installed or uninstall in scene
	for child in children:
		print(child.name)
		if child is PuzzlePart:
			print("PuzzlePart Found")
			var childPart: PuzzlePart = child as PuzzlePart
			if childPart.type == ProjectEnums.PartType.INSTALL: newParts += 1
			elif childPart.type == ProjectEnums.PartType.UNINSTALL: oldParts += 1

# Remove completed part from count and check for completion
func _on_exit_goal_part_complete(type: ProjectEnums.PartType) -> void:
	if type == ProjectEnums.PartType.INSTALL: newParts -= 1
	elif type == ProjectEnums.PartType.UNINSTALL: oldParts -= 1
	else: push_error("Unexpected Part Type has been Completed")
	
	if newParts < 1 and oldParts < 1: mode_done.emit(self)
