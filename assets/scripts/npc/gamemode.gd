class_name GameMode
extends Node3D

var mode_type : ProjectEnums.GameState

signal mode_done(mode: GameMode)

func set_active(active: bool) -> void:
	visible = active
	process_mode = Node.PROCESS_MODE_INHERIT if active else PROCESS_MODE_DISABLED
	#get_tree().paused = not active
