extends GameMode

var effects: Dictionary

@onready var npc_parent: Node3D = $NPCs

func _ready() -> void:
	mode_type = ProjectEnums.GameState.OVERWORLD
	GlobalState.overworld = self
	
	GlobalState.npcs.clear()
	for node : NPC in npc_parent.get_children():
		GlobalState.npcs[node.name] = node
