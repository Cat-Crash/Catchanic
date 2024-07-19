class_name FadeTransition
extends ColorRect

@onready var animation_player : AnimationPlayer = $AnimationPlayer

signal fade_done()

# Called when the node enters the scene tree for the first time.
#func _ready():
	#hide() # probably don't need this

func fade_in() -> void:
	animation_player.play("fade_in")
	
func fade_out() -> void:
	animation_player.play("fade_out")

func done() -> void:
	fade_done.emit()
