extends CharacterBody2D
class_name Player

signal onPlayerJumped
signal onPlayerLanded
const SPEED = 150.0
const JUMP_VELOCITY = -350.0
const SHOOT_DURATION = 0.249

var isAirborne: bool = false
var isShooting: bool = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var shoot_point: Node2D = $ShootPoint

func _ready():
	GameManager.onPlayerLoaded(self)

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
		isAirborne = true
	elif isAirborne:
		isAirborne = false
		onPlayerLanded.emit()

	# Handle jump
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		onPlayerJumped.emit()

	# Handle horizontal movements
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x =  move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed("Down") and is_on_floor():
		position.y += 3

	move_and_slide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Shoot"):
		tryToShoot()
		
	updateAnimation()
	
func updateAnimation():
	if velocity.x != 0:
		animated_sprite_2d.flip_h = velocity.x < 0
		shoot_point.position.x = -26 if animated_sprite_2d.flip_h else 26
	
	if is_on_floor():
		if abs(velocity.x) >= 0.1:
			var currentFrame = animated_sprite_2d.frame
			var currentAnimation = animated_sprite_2d.name
			
			if isShooting:
				animated_sprite_2d.play("ShootRun")
				
				# Sync up the run
				if currentAnimation == "Run":
					animated_sprite_2d.frame = currentFrame
			else:
				# Let ShootRun finish animating
				if currentAnimation == "ShootRun" && animated_sprite_2d.is_playing():
					pass
				else:
					animated_sprite_2d.play("Run")
		else:
			if isShooting:
				animated_sprite_2d.play("ShootStand")
			else:
				animated_sprite_2d.play("Idle")
	else:
		if isShooting:
			animated_sprite_2d.play("ShootJump")
		else:
			animated_sprite_2d.play("Jump")

func shoot() -> void:
	var bullet = Bullet.newBullet(-1 if animated_sprite_2d.flip_h else 1)
	GameManager.spawnInRoot(bullet, shoot_point.global_position)
	
	var playerFire = preload("res://Game/Scenes/vfx_player_fire.tscn").instantiate()
	playerFire.scale.x = -1 if animated_sprite_2d.flip_h else 1
	GameManager.spawnInRoot(playerFire, shoot_point.global_position)
	
func tryToShoot() -> void:
	if isShooting:
		return
	
	isShooting = true
	shoot()
	await get_tree().create_timer(SHOOT_DURATION).timeout
	isShooting = false
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
