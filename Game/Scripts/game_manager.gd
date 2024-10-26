extends Node

var _player: Player
var _playerOriginalPos: Vector2

func onPlayerLoaded(player: Player) -> void:
	_player = player
	_playerOriginalPos = player.position
	player.connect("onPlayerJumped", onPlayerJumped)

func onPlayerJumped() -> void:
	const vfxToSpawn = preload("res://Game/Scenes/vfx_jump_up.tscn")
	var vfxInstance = vfxToSpawn.instantiate()
	vfxInstance.global_position = _player.global_position
	get_tree().root.add_child(vfxInstance)

func onPlayerEnteredDeadZone() -> void:
	_player.position = _playerOriginalPos
