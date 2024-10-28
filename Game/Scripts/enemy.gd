extends CharacterBody2D

const SPEED: int = 50
var direction: int = -1
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d_forward: RayCast2D = $CollisionShape2D/RayCast2D_Forward
@onready var ray_cast_2d_downward: RayCast2D = $CollisionShape2D/RayCast2D_Downward

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y = 300
	
	if ray_cast_2d_forward.is_colliding() || !ray_cast_2d_downward.is_colliding():
		direction *= -1
		ray_cast_2d_forward.target_position.x *= -1
		ray_cast_2d_downward.target_position.x *= -1

	velocity.x = direction * SPEED
	
	move_and_slide()

func _process(delta: float) -> void:
	updateAnimation()
	
func updateAnimation() -> void:
	if velocity.x != 0:
		animated_sprite_2d.flip_h = velocity.x > 0
	
	animated_sprite_2d.play("Walk")
