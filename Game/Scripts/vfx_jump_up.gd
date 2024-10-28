extends Node2D
class_name VFXJumpUp
const scene: PackedScene = preload("res://Game/Scenes/vfx_jump_up.tscn")

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

static func newVFXJumpUp() -> VFXJumpUp:
	var instance: VFXJumpUp = scene.instantiate()
	return instance
	
func _ready():
	animated_sprite_2d.play("Start")

func _process(delta):
	if not animated_sprite_2d.is_playing():
		queue_free()
		
		
