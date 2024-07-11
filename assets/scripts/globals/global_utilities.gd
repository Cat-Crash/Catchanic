class_name ProjectUtilities
extends Node

# Disable and hide the current scene, then enable and show the next. Does not hide the overworld.
func switch_scene(curr_scene: GameMode, next_scene: GameMode) -> void:
# Assumes the root is the overworld. Might have to change later.
	if !next_scene: next_scene = get_tree().get_current_scene()

	GlobalState.currentGameState = next_scene.mode_type
	
	next_scene.process_mode = Node.PROCESS_MODE_ALWAYS
	next_scene.visible = true 
	if next_scene.mode_type == ProjectEnums.GameState.DIALOGUE:
		next_scene.beginDialoguePath()
	
	curr_scene.process_mode = Node.PROCESS_MODE_DISABLED
	# Don't hide the overworld
	if curr_scene.mode_type != ProjectEnums.GameState.OVERWORLD: curr_scene.visible = false

# Recursively get all children to the specified node
func get_all_children(parent: Node) -> Array[Node]:
	var children: Array[Node] = []
	
	for child : Node in parent.get_children():
		children.append(child)
		
		if child.get_child_count() > 0:
			children.append_array(get_all_children(child))

	return children
