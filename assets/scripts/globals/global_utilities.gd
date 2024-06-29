class_name ProjectUtilities
extends Node

func switch_scene(curr_scene: Node, next_scene: Node):
# Assumes the root is the overworld. Might have to change later.
	if !next_scene: next_scene = get_tree().get_current_scene()
	
	if "GAMESTATE" in next_scene:
		GlobalState.currentGameState = next_scene.GAMESTATE
		next_scene.process_mode = Node.PROCESS_MODE_ALWAYS
		next_scene.visible = true
	else: push_error("Tried to change to node without GAMESTATE")

	curr_scene.process_mode = Node.PROCESS_MODE_DISABLED
# Don't hide the overworld
	if "visible" in curr_scene and curr_scene.GAMESTATE != ProjectEnums.GameState.OVERWORLD: 
		curr_scene.visible = false

func get_all_children(parent: Node) -> Array[Node]:
	var children: Array[Node] = []
	
	for child in parent.get_children():
		children.append(child)
		
		if child.get_child_count() > 0:
			children.append_array(get_all_children(child))

	return children
