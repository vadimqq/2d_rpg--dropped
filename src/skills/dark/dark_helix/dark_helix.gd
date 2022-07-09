extends Node2D

var dark_orb = preload('res://src/skills/dark/dark_orb/dark_orb.tscn')
onready var cd_timer = $Spawn_cd
onready var spawn_container = $Spawn_node
onready var live_timer = $Live_time


var max_radius = 250.0
var speed = 5.0
var max_orb_count = 6

var life_time = 10
var damage = 0

var projectile_pool = []

func _process(delta):
	for projectile in projectile_pool:
		projectile['d'] += delta
		projectile['radius'] += speed if projectile['radius'] < max_radius else 0
		projectile['node'].position = Vector2(
			sin(projectile['d'] * speed) * projectile['radius'],
			cos(projectile['d'] * speed) * projectile['radius']
		) + spawn_container.global_position

func _ready():
	var circumference = (max_radius + max_radius) * PI
	var between_distance = circumference / max_orb_count
	cd_timer.wait_time = (between_distance / speed) / 10
	cd_timer.start()
	live_timer.wait_time = life_time

func add_new_projectile():
	var dark_orb_instance = dark_orb.instance()
	spawn_container.add_child(dark_orb_instance)
	projectile_pool.push_back({
		"d": 0.0,
		"radius": 0.0,
		"node": dark_orb_instance
	})
	dark_orb_instance.fire(spawn_container.global_transform, rotation, damage, 0)
	if projectile_pool.size() >= max_orb_count:
		live_timer.start()
		cd_timer.stop()

func _on_spawn_cd_timeout():
	add_new_projectile()


func _on_Live_time_timeout():
	queue_free()
