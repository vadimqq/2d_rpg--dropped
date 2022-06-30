extends Node2D

var dark_ball = preload("res://src/weapons/dark_stuff/dark_ball/dark_ball.tscn")
var dark_explosion = preload("res://src/weapons/dark_stuff/dark_explosion/dark_explosion.tscn")

onready var muzzle = $Muzzle
onready var animation = $AnimationBow

export (int) var projectile_speed = 500

export (float) var skill_1_cd = 5
export (int) var skill_1_mana_cost = 20

export (float) var skill_2_cd = 5
export (float) var skill_3_cd = 5
export (float) var skill_4_cd = 5

func attack(angle, damage, knockback_power):
	one_shoot(angle, damage, knockback_power)


func one_shoot(angle, damage, knockback_power):
	var dark_ball_instance = dark_ball.instance()
	dark_ball_instance.damage = damage
	dark_ball_instance.knockback_power = knockback_power
	dark_ball_instance.speed = projectile_speed
	dark_ball_instance.flip_v = global_transform.x.x < 0
	owner.add_child(dark_ball_instance)
	dark_ball_instance.fire(muzzle.global_transform, angle)

func dark_area(damage, knockback_power):
	var dark_explosion_instance = dark_explosion.instance()
	dark_explosion_instance.damage = damage
	dark_explosion_instance.knockback_power = knockback_power
	dark_explosion_instance.global_position = get_global_mouse_position()
	dark_explosion_instance.flip_h = global_transform.x.x < 0
	owner.add_child(dark_explosion_instance)
	
#PLAYER ADAPTER
func cast_skill_1(angle, damage, knockback_power):
	dark_area(damage, knockback_power)
#
#func cast_skill_2(angle, damage, knockback_power):
#	mutishot(angle, damage, knockback_power)
#
#func cast_skill_3(angle, damage, knockback_power):
#	mutishot(angle, damage, knockback_power)
#
#func cast_skill_4(angle, damage, knockback_power):
#	mutishot(angle, damage, knockback_power)
