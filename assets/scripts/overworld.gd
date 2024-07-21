class_name Overworld
extends GameMode

@onready var npc_parent: Node3D = $NPCs
@onready var player : Player = $Player
@onready var fade_transition = $"Lights and Sound/Fade Transition"
@onready var bgm_player = $"Lights and Sound/BGMPlayer"

@export var next_scene : PackedScene
@export var exit_sound : AudioStream

var effects: Dictionary

func _ready() -> void:
	fade_transition.fade_in()
	
	mode_type = ProjectEnums.GameState.OVERWORLD
	GlobalState.overworld = self
	
	GlobalState.npcs.clear()
	for node : NPC in npc_parent.get_children():
		GlobalState.npcs[node.name] = node

func set_active(active: bool) -> void:
	player.process_mode = Node.PROCESS_MODE_INHERIT if active else PROCESS_MODE_DISABLED

func exit_scene() -> void:
	bgm_player.stop()
	
	fade_transition.fade_out()
	await fade_transition.done
	
	if exit_sound:
		bgm_player.stream = exit_sound
		bgm_player.play()
		await bgm_player.finished
		fade_transition.fade_out()
	
	get_tree().change_scene_to_packed(next_scene)
