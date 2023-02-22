extends Node2D

onready var animation = $Animation

var reward_list := []

func _ready():
	animation.play("open")
	reward_list.append_array(PACT_MANAGER.get_rewards())

func spawn_rewards():
	var instance: RigidBody2D = reward_list.pop_front().instance()
	instance.apply_central_impulse(Vector2(rand_range(-50, 50), -75))
	add_child(instance)

func _on_Timer_timeout():
	if reward_list.size() > 0:
		spawn_rewards()
	else:
		$Timer.stop()
