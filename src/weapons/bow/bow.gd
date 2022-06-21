extends Node2D

var arrow = preload("res://src/weapons/bow/arrow.tscn")

onready var muzzle = $Muzzle

export (int) var arrow_speed = 200

func attack(degrees, angle, damage):
	var arrow_instance = arrow.instance()
	
	arrow_instance.position = muzzle.global_position
	arrow_instance.rotation_degrees = degrees
	arrow_instance.rotated_angle = angle
	arrow_instance.damage = damage
	arrow_instance.speed = arrow_speed
	owner.add_child(arrow_instance)
