extends Node

var quest_list = []

func _ready():
	pass # Replace with function body.

func check_quests():
	for quest in GAME_CORE.game_ui.quest_list.get_children():
		quest.update()

func add_new_quest(name):
	var quest: Base_quest = load_instance(name)
	GAME_CORE.player.game_ui.quest_list.add_child(quest)

func load_instance(name):
	var scene = load("res://src/quests/" + name + "/" + name + ".tscn")
	var instance = scene.instance()
	return instance
