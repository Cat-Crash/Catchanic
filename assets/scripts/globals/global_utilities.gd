class_name ProjectUtilities
extends Node

func switch_scene(curr_scene: Node, next_scene: Node):
	if next_scene and "GAMESTATE" in next_scene:
		GlobalState.currentGameState = next_scene.GAMESTATE
		next_scene.process_mode = Node.PROCESS_MODE_ALWAYS
		next_scene.visible = false
	else: 
		GlobalState.currentGameState = ProjectEnums.GameState.OVERWORLD
		
	curr_scene.process_mode = Node.PROCESS_MODE_DISABLED
	if "visible" in curr_scene: curr_scene.visible = false
