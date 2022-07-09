extends Node2D

var width = 2000
var height = 2000
var spawningArea = Rect2()
var delta = 2
var offset = 1

onready var timer = $Timer

var lvl_info

func _ready():
	print('kek')
	lvl_info = GAME_CORE.get_lvl_info().duplicate(true)
	randomize()
	spawningArea = Rect2(0,0,width,height)
	set_next_spawn()

func spawn_enemy():
	var enemy_random = randi() % lvl_info.size()
	if lvl_info[enemy_random]['count'] == 0:
		return spawn_enemy()
	var position = Vector2(randi() % width, randi() % height)
	var enemy_istance = lvl_info[enemy_random]['node'].instance()
	get_parent().add_child(enemy_istance)
	enemy_istance.position = position
	lvl_info[enemy_random]['count'] -= 1
	
	return position

func set_next_spawn():
	
	var next_time = GAME_CORE.enemy_spawn_speed 
	
	timer.wait_time = next_time
	timer.start()

func _on_Timer_timeout():
	
	if check_enemy_count():
		queue_free()
	else:
		spawn_enemy()
		set_next_spawn()

func check_enemy_count():
	var result = 0
	for enemy in lvl_info:
		result += enemy['count']
	return result == 0


