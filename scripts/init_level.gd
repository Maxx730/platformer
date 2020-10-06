extends Node

var player = null
var entrance = null

func _ready():
	player = load("res://scenes/entities/player.tscn").instance()
	add_child(player)
	
	entrance = get_node("map/level_entrance")
	player.global_position = entrance.global_position
