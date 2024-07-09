class_name Interactable
extends Node3D

# String -> Int
# String is the name of the NPC Node, Int is the Interactable Number to change to
@export var effects : Dictionary

var game_modes : Array[GameMode]
var active_mode : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var children = get_children() #NOTE temp
	for child : Node in children: #NOTE temp
		if child is GameMode:
			game_modes.append(child)
		else:
			push_error('Non game mode object under interactable')
	#game_modes = get_children() as Array[GameMode]
	for mode in game_modes:
		mode.mode_done.connect(_on_mode_done)

func activate() -> void:
	GlobalUtilities.switch_scene(GlobalState.overworld, game_modes[0])

func _on_mode_done(done: GameMode) -> void:
	if active_mode + 1 >= game_modes.size(): _end_interaction()
	else: 
		active_mode += 1
		GlobalUtilities.switch_scene(done, game_modes[active_mode])

func _end_interaction() -> void:
	for i_name in effects:
		var npc : NPC = GlobalState.npcs[i_name] as NPC
		npc.active_interactable = effects[i_name]
	
	GlobalUtilities.switch_scene(game_modes[active_mode], GlobalState.overworld)
