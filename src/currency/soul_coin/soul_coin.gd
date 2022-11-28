extends Node2D

var move_speed = 200
var count = 20

func _process(delta):
	look_at(GAME_CORE.player.global_position)
	global_position = global_position.move_toward(GAME_CORE.player.global_position, delta * move_speed)

func _on_Area2D_body_entered(body):
	CURRENCY_MANAGER.modify_soul_coins(count)
	queue_free()


