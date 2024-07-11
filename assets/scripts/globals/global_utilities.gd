class_name ProjectUtilities
extends Node

# Disable and hide the current scene, then enable and show the next. Does not hide the overworld.
func switch_scene(curr_scene: GameMode, next_scene: GameMode) -> void:
	GlobalState.currentGameState = next_scene.mode_type
	
	next_scene.set_active(true)
	curr_scene.set_active(false)

# Recursively get all children to the specified node
func get_all_children(parent: Node) -> Array[Node]:
	var children: Array[Node] = []
	
	for child : Node in parent.get_children():
		children.append(child)
		
		if child.get_child_count() > 0:
			children.append_array(get_all_children(child))

	return children
