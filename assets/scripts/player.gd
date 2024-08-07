class_name Player
extends CharacterBody3D

@onready var sprite : AnimatedSprite3D = $AnimatedSprite3D

@export var speed : float = 5.0
@export var accel : float = 1
@export var deccel : float = 2.5
#const JUMP_VELOCITY : float = 4.5 

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(_delta : float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * _delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_dir.x > 0: sprite.flip_h = true
	elif input_dir.x < 0: sprite.flip_h = false
	
	var direction : Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() * speed
	if direction:
		velocity.x = move_toward(velocity.x, direction.x, accel)
		velocity.z = move_toward(velocity.z, direction.z, accel)
	else:
		velocity.x = move_toward(velocity.x, 0, deccel)
		velocity.z = move_toward(velocity.z, 0, deccel)
		
	if velocity: sprite.play("walk")
	else: sprite.play("idle")

	move_and_slide()
	GlobalState.playerPosition = global_transform.origin # set the global player position to the new one
