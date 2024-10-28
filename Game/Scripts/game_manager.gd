extends Node

var _player: Player
var _playerOriginalPos: Vector2

func onPlayerLoaded(player: Player) -> void:
	_player = player
	_playerOriginalPos = player.position
	player.connect("onPlayerJumped", onPlayerJumped)
	player.connect("onPlayerLanded", onPlayerLanded)

func spawnInRoot(node: Node2D, position: Vector2) -> void:
	get_tree().root.add_child(node)
	node.global_position = position

# This can be done without signals, but good for practice
func onPlayerJumped() -> void:
	var vfxJumpUp = VFXJumpUp.newVFXJumpUp()
	spawnInRoot(vfxJumpUp, _player.global_position)
	
# This can be done without signals, but good for practice
func onPlayerLanded() -> void:
	var vfxJumpLand = VFXJumpLand.newVFXJumpLand()
	spawnInRoot(vfxJumpLand, _player.global_position)

func onPlayerEnteredDeadZone() -> void:
	_player.position = _playerOriginalPos
