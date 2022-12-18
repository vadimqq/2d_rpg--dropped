extends Base_ability

var attack_spped = 10

func _init():
	type = CONSTANTS.ABILITY_TYPE_ENUM.PASSIVE
	max_lvl = 5

func apply_buff(s: Base_body):
	s.STATS.apply_buff({
		"GAIN_ATTACK_SPEED": attack_spped
	})

func _on_attack_speed_upgrade(new_lvl):
	pass
#	match new_lvl:
#		1:
#			apply_buff(s)
#		2:
#			attack_spped = 5
#			apply_buff(s)
#		3: 
#			attack_spped = 5
#			apply_buff(s)
#		4: 
#			attack_spped = 5
#			apply_buff(s)
#		5: 
#			attack_spped = 5
#			apply_buff(s)
#	lvl = new_lvl
