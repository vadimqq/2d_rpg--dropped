extends Base_togle_ability

onready var animation = $Animation

func _init():
	tier = 4
	CD = 5.0
	max_lvl = 3
	damage_incounter = 0.4

func _on_aura_agility_upgrade(new_lvl):
	match new_lvl:
		1:
			mana_cost = 40
		2:
			mana_cost = 39
		3:
			mana_cost = 38
	lvl = new_lvl

func _on_Area2D_body_entered(body: Base_body):
	body.STATS.apply_buff({
		"GAIN_MOVE_SPEED": 100,
		"GAIN_ATTACK_SPEED": 100,
		
	})


func _on_Area2D_body_exited(body: Base_body):
	body.STATS.apply_buff({
		"GAIN_MOVE_SPEED": -100,
		"GAIN_ATTACK_SPEED": -100,
	})


func _on_aura_agility_execute_on():
	animation.play("on")


func _on_aura_agility_execute_of():
	animation.play("off")
