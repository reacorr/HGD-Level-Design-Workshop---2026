extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jumping
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle movement
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite.play("Walk")
		animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("Idle")
	
	move_and_slide()
