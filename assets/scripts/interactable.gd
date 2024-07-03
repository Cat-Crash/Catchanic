class_name Interactable
extends Node3D

var game_modes: Array[GameMode]
signal interactable_done(interactable: Interactable)

# Called when the node enters the scene tree for the first time.
func _ready():
	game_modes = get_children() as Array[GameMode]
	for mode in game_modes:
		mode.mode_done.connect(_on_mode_done)

func activate(previous_mode: GameMode):
	GlobalUtilities.switch_scene(previous_mode, game_modes[0])

func _on_mode_done(done: GameMode):
	var next_idx: int = game_modes.find(done) + 1
	if next_idx < 0: push_error("Unrecognized gamemode node in interactable")
	elif next_idx >= game_modes.size(): interactable_done.emit(self)
	else: GlobalUtilities.switch_scene(done, game_modes[next_idx])
