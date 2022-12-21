extends Node2D

onready var animation = $Animation

func _ready():
	animation.play("open")

func spawn_rewards():
	var reward_list = PACT_MANAGER.get_rewards()
	for reward in reward_list:
		var instance: Area2D = reward.instance()
		add_child(instance)

