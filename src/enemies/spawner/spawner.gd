extends Position2D

onready var animation = $Animation

signal spawned(spawn)

export (PackedScene) var spawning_scene

func _ready():
	animation.play("open")

func spawn():
	var spawning: Enemy = spawning_scene.instance()
	get_tree().get_current_scene().y_sort.add_child(spawning)
	spawning.global_position = global_position
	animation.play("close")
