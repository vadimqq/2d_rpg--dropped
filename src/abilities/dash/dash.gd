extends Base_ability

onready var duration_timer = $duration
onready var ghost_spawn_timer = $ghost_spawn

var dash_ghost = preload("res://src/abilities/dash/dash_ghost.tscn")

var sprite: Sprite

var dash_speed = 0
var normal_speed = 0

var dash_time = 0.3

func _init():
	tier = 2
	price = 10
	CD = 2.0
	max_lvl = 3

func execute(s: Base_body, spawn_position):
	owner_body = s
	self.sprite = s.sprite
	sprite.material.set_shader_param("mix_weight", 0.7)
	sprite.material.set_shader_param("whiten", true)
	
	s.hurtbox_shape.disabled = true
	normal_speed = s.STATS.MOVE_SPEED
	dash_speed = s.STATS.MOVE_SPEED * 3
	s.STATS.MOVE_SPEED = dash_speed
	duration_timer.wait_time = dash_time
	duration_timer.start()
	ghost_spawn_timer.start()
	start_cd()

func add_dash_ghost():
	var ghost_instance = dash_ghost.instance()
	get_node("/root").add_child(ghost_instance)
	
	ghost_instance.global_position = global_position
	ghost_instance.texture = sprite.texture
	ghost_instance.vframes = sprite.vframes
	ghost_instance.hframes = sprite.hframes
	ghost_instance.frame = sprite.frame
	ghost_instance.flip_h = sprite.flip_h

func is_dashing():
	return !duration_timer.is_stopped()

func end_dash():
	ghost_spawn_timer.stop()
	sprite.material.set_shader_param("whiten", false)
	owner_body.STATS.MOVE_SPEED = normal_speed
	owner_body.hurtbox_shape.disabled = false

func _on_duration_timeout():
		end_dash()


func _on_ghost_spawn_timeout():
	add_dash_ghost()


func _on_Dash_upgrade(s: Base_body, new_lvl):
	match new_lvl:
		1:
			price = 20
		2:
			price = 30
		3:
			price = 40
	lvl = new_lvl
