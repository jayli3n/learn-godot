extends Area2D
class_name Bullet
const scene: PackedScene = preload("res://Game/Scenes/bullet.tscn")

const SPEED: float = 500
const DAMAGE: float = 35
var direction: int = 1
@onready var sprite_2d: Sprite2D = $CollisionShape2D/Sprite2D

static func newBullet(_direction: int) -> Bullet:
	var instance: Bullet = scene.instantiate()
	instance.direction = _direction
	return instance

func _physics_process(delta: float) -> void:
	sprite_2d.flip_h = direction == -1
	position.x += SPEED * direction * delta
	

func _on_body_entered(body: Node2D) -> void:
	# VFX
	var vfx = preload("res://Game/Scenes/vfx_bullet_hit.tscn").instantiate()
	GameManager.spawnInRoot(vfx, global_position)
	vfx.scale.x = direction
	
	# Apply damage to enemy
	if body is Enemy:
		body.applyDamage(DAMAGE)
	
	queue_free()
	
	
	
