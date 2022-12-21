extends Node

var item_list = []

var item_name_list = [
	"clock",
	"health_potion",
	"mana_potion",
	"jagged_steel"
]

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
	for i in item_list:
		if i.id == item.id:
			i.count += 1
			GAME_CORE.game_ui.update_artifact_count(item.id)
			GAME_CORE.player.STATS.apply_buff(item.stats)
			return
	
	item_list.push_back(
		{
			"name": item.item_name,
			"id": item.id,
			"count": 1
		}
	)
	GAME_CORE.player.add_artifact_icon(item.id)
	GAME_CORE.player.STATS.apply_buff(item.stats)

func reset_all_items():
	item_list.clear()

func get_randomize_item():
	var index = randi() % item_name_list.size()
	return load_instance(item_name_list[index])
