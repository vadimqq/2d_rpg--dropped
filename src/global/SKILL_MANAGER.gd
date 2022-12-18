extends Node

#PASSIVE==========================================================
var physic_attack_speed: Base_ability = load_passive_instance("physic", "attack_speed")
var physic_bleed: Base_ability = load_passive_instance("physic", "bleed")

var passive_ability_array = [
	["physic", "attack_speed"],
	["physic", "bleed"]
] 

#ACTIVE===========================================================
#var lightning_bolt: Base_ability = load_instance("lightning_bolt")
var arrow_multishot: Base_ability = load_instance("arrow_multishot")
var dash: Base_ability = load_instance("dash")
var aura_agility: Base_togle_ability = load_instance("aura_agility")


func load_ability(s: Base_weapon, name, lvl = 1):
	var instance: Base_ability = load_instance(name)
	instance.upgrade(lvl)
	s.add_child(instance)
	return instance

func load_instance(name):
	var scene = load("res://src/abilities/" + name + "/" + name + ".tscn")
	var instance = scene.instance()
	return instance

func load_passive_instance(element, name):
	var scene = load("res://src/abilities/passive/" + element + "/" + name + "/" + name + ".tscn")
	var instance = scene.instance()
	return instance
