extends Node2D

onready var portal_place = $portal

func _ready():
	add_child(GAME_CORE.player_instance)
	GAME_CORE.player_instance.global_position = portal_place.global_position
	add_child(GAME_CORE.spawner.instance())
	
