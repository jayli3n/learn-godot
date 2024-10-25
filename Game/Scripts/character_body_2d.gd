extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -350.0
const dEd = 90.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle horizontal movements
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x =  move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed("Down") and is_on_floor():
		position.y += 3

	move_and_slide()

func _process(delta: float) -> void:
	updateAnimation()
	
func updateAnimation():
	if velocity.x != 0:
		animated_sprite_2d.flip_h = velocity.x < 0
	
	if is_on_floor():
		if abs(velocity.x) >= 0.1:
			animated_sprite_2d.play("Run")
		else:
			animated_sprite_2d.play("Idle")
	else:
		animated_sprite_2d.play("Jump")
