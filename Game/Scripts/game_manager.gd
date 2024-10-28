extends Node

var _player: Player
var _playerOriginalPos: Vector2

func onPlayerLoaded(player: Player) -> void:
	_player = player
	_playerOriginalPos = player.position
	player.connect("onPlayerJumped", onPlayerJumped)
	player.connect("onPlayerLanded", onPlayerLanded)

func spawnInWorld(resource: Resource, pos: Vector2) -> Node2D:
	var instance = resource.instantiate()
	instance.global_position = pos
	get_tree().root.add_child(instance)
	return instance

func onPlayerJumped() -> void:
	const vfx = preload("res://Game/Scenes/vfx_jump_up.tscn")
	spawnInWorld(vfx, _player.global_position)
	
func onPlayerLanded() -> void:
	const vfx = preload("res://Game/Scenes/vfx_jump_land.tscn")
	spawnInWorld(vfx, _player.global_position)

func onPlayerEnteredDeadZone() -> void:
	_player.position = _playerOriginalPos
