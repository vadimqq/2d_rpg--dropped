extends Node2D

class_name Base_ability

onready var cd_timer: Timer = $CD

var owner_body: Base_body
var lvl = 0
var max_lvl = 0
var price = 0
var mana_cost = 0
var tier = 1
var tags: Array = []
var type = CONSTANTS.ABILITY_TYPE_ENUM.ACTIVE
var CD = 0.0
var is_ready = true

#для пассивок
var element = ''

signal set_lvl
signal upgrade

func upgrade(s: Base_body, new_lvl = lvl + 1):
	GAME_CORE.modify_soul_stones(-price)
	emit_signal("upgrade", s,  new_lvl)

func _on_CD_timeout():
	is_ready = true

func start_cd():
	is_ready = false
	cd_timer.wait_time = UTILS.get_modified_value_by_percent(CD, owner_body.STATS.CDR)
	cd_timer.start()
