extends RigidBody2D

export (int) var EXP_weight = 10
export var speed = 1200
var player = null
var is_move_to_player = false

func _physics_process(delta):
	if player != null:
		global_position = global_position.move_toward(player.global_position, speed * delta)
		if player.global_position == global_position:
			player.EXP += EXP_weight
			queue_free()

func pick_up(player_body):
	if self:
		player = player_body

