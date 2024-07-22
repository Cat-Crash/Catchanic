class_name LevelChange
extends GameMode

@export var next_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mode_type = GlobalEnums.GameState.OVERWORLD

func set_active(active: bool) -> void:
	if active: GlobalState.overworld.exit_scene()
