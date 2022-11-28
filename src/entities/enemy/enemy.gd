extends Base_body

class_name Enemy

onready var switch_direction_timer = $switch_direction_timer

export var steer_force = 0.1
export var look_ahead = 50
export var num_rays = 32
var player :KinematicBody2D = null

# context array
var ray_directions = []
var interest = []
var danger = []

var chosen_dir = Vector2.ZERO
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO

enum AI_STATE {
	CHASE,
	COMBAT,
	PATROOL,
	ATTACK
}

signal cast_base_attack

var ai_state = AI_STATE.PATROOL

var attack_layer = 64
var attack_mask = 17

func _ready():
	yield(get_tree(), "idle_frame")
	player = GAME_CORE.player
	interest.resize(num_rays)
	danger.resize(num_rays)
	ray_directions.resize(num_rays)
	STATS.apply_buff({
		"GAIN_MOVE_SPEED": -50
	})
	for i in num_rays:
		var angle = i * 2 * PI / num_rays
		ray_directions[i] = Vector2.RIGHT.rotated(angle)

func _physics_process(delta):
	match ai_state:
		AI_STATE.CHASE:
			state_chase()
		AI_STATE.PATROOL:
			state_patrool()
		AI_STATE.ATTACK:
			animation_tree.get("parameters/playback").travel("attack")
	
	if  state == MOVE && ai_state != AI_STATE.ATTACK:
		animation_tree.get("parameters/playback").travel("move")
	animation_tree.set("parameters/idle/blend_position", Motion)
	animation_tree.set("parameters/move/blend_position", Motion)
	
	if player != null:
		ray_cast.look_at(player.global_position)
	if ray_cast.is_colliding(): 
		emit_signal("cast_base_attack")

func state_chase():
	switch_direction_timer.autostart = false
	look_at(player.global_position)
	set_interest()
	set_danger()
	choose_direction()
	var desired_velocity = chosen_dir.rotated(rotation)
	axis = velocity.linear_interpolate(desired_velocity, steer_force)
	rotation = velocity.angle()
	

func state_patrool():
	switch_direction_timer.autostart = true

func set_interest():
	if owner and owner.has_method("get_path_direction"):
		var path_direction = owner.get_path_direction(position)
		for i in num_rays:
			var d = ray_directions[i].rotated(rotation).dot(path_direction)
			interest[i] = max(0, d)
	else:
		set_default_interest()

func set_default_interest():
	for i in num_rays:
		var d = ray_directions[i].rotated(rotation).dot(transform.x)
		interest[i] = max(0, d)

func set_danger():
	var space_state = get_world_2d().direct_space_state
	for i in num_rays:
		var result = space_state.intersect_ray(position,
				position + ray_directions[i].rotated(rotation) * look_ahead,
				[self])
		danger[i] = 1.0 if result else 0.0

func choose_direction():
	for i in num_rays:
		if danger[i] > 0.0:
			interest[i] = 0.0
	chosen_dir = Vector2.ZERO
	for i in num_rays:
		chosen_dir += ray_directions[i] * interest[i]
	chosen_dir = chosen_dir.normalized()

func _on_detection_zone_body_entered(body):
	ai_state = AI_STATE.CHASE
	pass

func _on_switch_direction_timer_timeout():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var dir_x = rng.randf_range(-1, 1)
	var dir_y = rng.randf_range(-1, 1)
	axis = Vector2(dir_x, dir_y)

func _on_enemy_death():
	CURRENCY_MANAGER.create_soul_coin(20, global_position)
	call_deferred('free')
