extends CharacterBody2D
class_name Enemy

const SPEED: int = 50
const DAMAGE: int = 30
var direction: int = -1
var health: int = 100
var isDead: bool = false
var isAttacking: bool = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d_forward: RayCast2D = $CollisionShape2D/RayCast2D_Forward
@onready var ray_cast_2d_downward: RayCast2D = $CollisionShape2D/RayCast2D_Downward
@onready var area_2d_damage_caster: Area2D = $Area2D_DamageCaster

func _physics_process(delta: float) -> void:
		
	if not is_on_floor():
		velocity.y = 300
	
	if (isDead): return
	
	if (isAttacking):
		if (!animated_sprite_2d.is_playing()):
			isAttacking = false
		else:
			return
			
	if ray_cast_2d_forward.is_colliding() || !ray_cast_2d_downward.is_colliding():
		direction *= -1
		ray_cast_2d_forward.target_position.x *= -1
		ray_cast_2d_downward.target_position.x *= -1

	velocity.x = direction * SPEED
	
	move_and_slide()

func _process(delta: float) -> void:
	if (isDead): return
	updateAnimation()
	
func updateAnimation() -> void:
	if velocity.x != 0:
		animated_sprite_2d.flip_h = velocity.x > 0
	
	if (!isAttacking):
		animated_sprite_2d.play("Walk")
	elif (animated_sprite_2d.animation != "Attack"):
		animated_sprite_2d.play("Attack")

func applyDamage(damage: int) -> void:
	if (isDead): return
	health -= damage
	
	isDead = health <= 0
	
	if (isDead):
		animated_sprite_2d.play("Die")
		set_collision_layer_value(3, false)
	
func _on_area_2d_player_detector_body_entered(body: Node2D) -> void:
	isAttacking = true

func _on_area_2d_damage_caster_body_entered(body: Node2D) -> void:
	if (!isAttacking): return
	
