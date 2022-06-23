extends RigidBody2D

export (int) var EXP_weight = 10
export var speed = 1200
var player = null
var is_move_to_player = false

func _physics_process(delta):
	if player != null:
		if !is_move_to_player:
			global_position = global_position.move_toward(global_position - player.global_position, (speed / 4) * delta)
		else:
			global_position = global_position.move_toward(player.global_position, speed * delta)
			if player.global_position == global_position:
				player.EXP += EXP_weight
				hide()
				set_process(false)

func pick_up(player_body):
	player = player_body
	can_move_to_player()

func can_move_to_player():
	yield(get_tree().create_timer(0.2), "timeout")
	is_move_to_player = true
