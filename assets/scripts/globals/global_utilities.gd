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
