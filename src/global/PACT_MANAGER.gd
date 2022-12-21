extends Node

const more_enemies_pact = preload("res://src/pacts/more_enemies_pact.tres")
const move_speed_enemies_pact = preload("res://src/pacts/move_speed_enemies_pact.tres")

const clock = preload("res://src/items/artifacts/clock/clock.tscn")
const health_potion = preload("res://src/items/artifacts/health_potion/health_potion.tscn")
const mana_potion = preload("res://src/items/artifacts/mana_potion/mana_potion.tscn")
const jagged_steel = preload("res://src/items/artifacts/jagged_steel/jagged_steel.tscn")

const arrow_shot_srcoll = preload("res://src/items/ability_scrolls/arrow_shot/arrow_shot.tscn")

signal enemy_killed

var enemy_lvl = 1
var count_enemy_spawn = 5
var total_enemy_killed = 0
var enemy_buff_dict: Dictionary= {}

var NORAMAL_REWARDS_POOL = [health_potion, mana_potion]
var MAGIC_REWARDS_POOL = [clock]
var RARE_REWARDS_POOL = [jagged_steel]
var LEGENDARY_REWARDS_POOL = [arrow_shot_srcoll]

var rewards_counts = 5

var reward_rarity_weights := {
	"NORAMAL_REWARDS_POOL": 60,
	"MAGIC_REWARDS_POOL": 27,
	"RARE_REWARDS_POOL": 9,
	"LEGENDARY_REWARDS_POOL": 3
}

func get_random_reward():
	var current_pool
	
	randomize()
	var rarity_roll = randi()% 100 + 1
	for rarity in reward_rarity_weights.keys():
		if rarity_roll <= reward_rarity_weights[rarity]:
			current_pool = self[rarity]
			break
		else:
			rarity_roll -= reward_rarity_weights[rarity]
	
	return current_pool[randi() % current_pool.size()]

func _ready():
	pass # Replace with function body.

var PACTS_POOL = [
	move_speed_enemies_pact,
	more_enemies_pact,
]

func add_kill():
	total_enemy_killed += 1
	emit_signal("enemy_killed")

func modify_enemy_spawn_count(amount):
	count_enemy_spawn += amount

func modify_enemy_lvl(amount):
	enemy_lvl += amount

func modify_enemy_buff(dict: Dictionary):
	for i in dict:
		if enemy_buff_dict.has(i):
			enemy_buff_dict[i] += dict[i]
		else:
			enemy_buff_dict[i] = dict[i]

func get_random_pacts():
	var result = []
	for i in 2:
		result.push_back(PACTS_POOL[randi() % PACTS_POOL.size()])
	return result

func get_rewards():
	var rewards = []
	for i in rewards_counts:
		rewards.append(get_random_reward())
	return rewards
