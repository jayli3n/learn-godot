extends Node

var player
var playerOriginalPos

func playerEnteredDeadZone():
	player.position = playerOriginalPos
