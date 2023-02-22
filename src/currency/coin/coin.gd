extends RigidBody2D

export (int) var move_speed = 200
var is_move_to_player = false

func _process(delta):
	if is_move_to_player:
		global_position = global_position.move_toward(GAME_CORE.player.global_position, delta * move_speed)
	
	if global_position.distance_to(GAME_CORE.player.global_position) < 1:
		CURRENCY_MANAGER.modify_coins(1)
		call_deferred('free')

func _ready():
	yield(get_tree().create_timer(rand_range(0.5, 1)),"timeout")
	is_move_to_player = true
