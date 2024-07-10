extends GameMode

var effects: Dictionary

@onready var npc_parent: Node3D = $NPCs

func _ready() -> void:
	mode_type = ProjectEnums.GameState.OVERWORLD
	var npc_nodes : Array[NPC] = npc_parent.get_children() as Array[NPC]
	
	GlobalState.overworld = self
	
	GlobalState.npcs.clear()
	for node : NPC in npc_nodes:
		GlobalState.npcs[node.name] = node
