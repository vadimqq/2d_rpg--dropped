extends Node2D

var arrow = preload("res://src/weapons/bow/arrow.tscn")

onready var muzzle = $Muzzle

export (int) var arrow_speed = 500

func attack(damage):
	var arrow_instance = arrow.instance()

	arrow_instance.damage = damage
	arrow_instance.speed = arrow_speed
	owner.add_child(arrow_instance)
	arrow_instance.global_transform = muzzle.global_transform
	
