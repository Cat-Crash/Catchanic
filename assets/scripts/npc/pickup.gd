extends GameMode

@export var put_down : bool

var pickups : Array[Node3D]

func _ready() -> void:
	mode_type = GlobalEnums.GameState.PICKUP
	pickups.assign(get_children())
	_set_visible(not put_down)

func _set_visible(is_visible: bool) -> void:
	visible = is_visible
	for pickup in pickups:
		pickup.visible = is_visible
		
func set_active(active: bool) -> void:
	if active:  _set_visible(put_down)
