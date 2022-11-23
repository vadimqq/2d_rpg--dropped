extends Node2D

onready var y_sort = $YSort

func _ready():
	y_sort.add_child(GAME_CORE.player)
