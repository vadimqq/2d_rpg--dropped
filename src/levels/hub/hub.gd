extends Node2D

onready var y_sort = $YSort

func add_player():
	y_sort.add_child(GAME_CORE.player)

func _ready():
	add_player()
