extends Area2D

const SPEED: float = 500
const DAMAGE: float = 35
var direction: int  = 1
@onready var sprite_2d: Sprite2D = $CollisionShape2D/Sprite2D

func _physics_process(delta: float) -> void:
	sprite_2d.flip_h = direction == -1
	position.x += SPEED * direction * delta
	

func _on_body_entered(body: Node2D) -> void:
	var vfx = preload("res://Game/Scenes/vfx_bullet_hit.tscn")
	var vfxInstance = GameManager.spawnInWorld(vfx, global_position)
	vfxInstance.scale.x = direction
	queue_free()
