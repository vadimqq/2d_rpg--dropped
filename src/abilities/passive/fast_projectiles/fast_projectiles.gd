extends "res://fast_projectiles.gd"

func _on_fast_projectiles_apply_buff(owner_body: Base_body):
	owner_body.STATS.apply_buff({
		"GAIN_PROJECTILE_SPEED": 400
	})

func _on_fast_projectiles_destroy_buff(owner_body: Base_body):
	owner_body.STATS.apply_buff({
		"GAIN_PROJECTILE_SPEED": -400
	})
