extends Node2D

var move_speed = 200
var count = 1

func _ready():
	scale += scale  / 100 * count

func _process(delta):
	look_at(GAME_CORE.player.global_position)
	global_position = global_position.move_toward(GAME_CORE.player.global_position, delta * move_speed)

func _on_Area2D_body_entered(body: Player):
	body.STATS.modify_exp(count)
	queue_free()
