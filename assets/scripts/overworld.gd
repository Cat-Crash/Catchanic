extends GameMode

var effects: Dictionary

@onready var npc_parent = $NPCs

func _ready():
	mode_type = ProjectEnums.GameState.OVERWORLD
	var npcs = npc_parent.get_children() as Array[NPC]
	
	for npc in npcs:
		npc.interaction_done.connect(_on_interaction_done)

func _on_interaction_done(npc: NPC, number: int):
	pass

class InteractionEffect:
	var npc: NPC
	var number: int
	
	var effects: Dictionary
	
	func apply_effects():
		for npc in effects:
			npc.activeInteractable = effects[npc]
