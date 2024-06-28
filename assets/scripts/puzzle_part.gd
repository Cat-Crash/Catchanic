extends CharacterBody2D

@export var moveX: bool
@export var moveY: bool
@export var snap: int

@onready var up_cast = $AnimatableBody2D/UpCast
@onready var down_cast = $AnimatableBody2D/DownCast
@onready var left_cast = $AnimatableBody2D/LeftCast
@onready var right_cast = $AnimatableBody2D/RightCast

var snapVect: Vector2
var selected: bool = false

func _ready():
	snapVect = Vector2(snap, snap)

func _process(delta):
	if not selected: return
	
	var currPos: Vector2 = self.global_position
	var mousePos: Vector2 = get_global_mouse_position().snapped(snapVect)
	
	velocity = (mousePos - currPos) / delta
	move_and_slide()

func _on_button_button_down():
	selected = true

func _on_button_button_up():
	selected = false
