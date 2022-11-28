extends Node

var item_list = []

func load_weapon_item(postion: Vector2, item_name):
	var scene = load("res://src/items/weapons/" + item_name + "/" + item_name + ".tscn")
	var instance: Base_item = scene.instance()
	instance.global_position = postion
	get_node("/root").add_child(instance)

func load_instance(name):
	var scene = load("res://src/items/artifacts/" + name + "/" + name + ".tscn")
	var instance = scene.instance()
	return instance

func take_item(item: Item_with_popup):
	for item_dict in item_list:
		if item_dict.name == item.item_name:
			item_dict.count += 1
			GAME_CORE.game_ui.update_artifact_count(item.item_name)
			GAME_CORE.player.STATS.apply_buff(item.stats)
			return
	
	item_list.push_back(
		{
			"name": item.item_name,
			"count": 1
		}
	)
	GAME_CORE.game_ui.add_artifact_icon(item.name)
	GAME_CORE.player.STATS.apply_buff(item.stats)
