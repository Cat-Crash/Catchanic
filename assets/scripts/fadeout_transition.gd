class_name FadeOut
extends GameMode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mode_type = GlobalEnums.GameState.OVERWORLD

func set_active(active: bool) -> void:
	if active:
		var fader : FadeTransition = GlobalState.overworld.fade_transition
		fader.fade_out()
		await fader.done
		fader.fade_in()
		mode_done.emit()
