extends Node2D

var arrow = preload("res://src/weapons/bow/arrow.tscn")

onready var muzzle = $Muzzle
onready var animation = $AnimationBow

export (int) var arrow_speed = 500

export (float) var skill_1_cd = 5
export (int) var skill_1_mana_cost = 20

export (float) var skill_2_cd = 5
export (float) var skill_3_cd = 5
export (float) var skill_4_cd = 5

var upgrade_sistem = [
	{
		"name": 'multishot passive',
		'description': 'cast multishot on every 5 attack',
		'upgrade_func': funcref(self, 'upgrade_multishot')
	}
]
#weapon.upgrade_sistem[0]['upgrade_func'].call_func()
#MULTISHOT
export (int) var multishot_count = 12
#--------


#PASSIVE
var multishot_passive = {
	count_proc = 5,
	is_active = true
}
#------
var attack_counter = 0

func attack(angle, damage, knockback_power):
	one_shoot(angle, damage, knockback_power)

	if multishot_passive.is_active:
		attack_counter += 1
		if multishot_passive.count_proc <= attack_counter:
			cast_skill_1(angle, damage, knockback_power)
			attack_counter = 0

func mutishot(angle, damage, knockback_power):
	var casted = 0
	var add_angle = 0
	var add_degrees = 0
	var is_right_side = false
	
	while casted < multishot_count:
		if is_right_side:
			one_shoot(angle + add_angle, damage, knockback_power)
		else:
			one_shoot(angle - add_angle, damage, knockback_power)
		add_angle += 0.02
		add_degrees += 2
		is_right_side = !is_right_side
		casted += 1

func one_shoot(angle, damage, knockback_power):
	var arrow_instance = arrow.instance()
	arrow_instance.damage = damage
	arrow_instance.knockback_power = knockback_power
	arrow_instance.speed = arrow_speed
	owner.add_child(arrow_instance)
	arrow_instance.fire(muzzle.global_transform, angle)

func upgrade_multishot():
	multishot_passive.is_active = true


#PLAYER ADAPTER
func cast_skill_1(angle, damage, knockback_power):
	mutishot(angle, damage, knockback_power)

func cast_skill_2(angle, damage, knockback_power):
	mutishot(angle, damage, knockback_power)

func cast_skill_3(angle, damage, knockback_power):
	mutishot(angle, damage, knockback_power)

func cast_skill_4(angle, damage, knockback_power):
	mutishot(angle, damage, knockback_power)
