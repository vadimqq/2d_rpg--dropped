extends Container

onready var upgrade_panel = $CenterContainer/PanelContainer
onready var upgrade_button = $CenterContainer/Upgrade_button

var player_instance = null

func _ready():
	visible = false

func open_upgrade(spirits_pivot):
	upgrade_button.menu_root = self
	get_tree().paused = true
	visible = true
	create_upgrade_button(spirits_pivot)
	

func close_upgrade():
	for button in upgrade_panel.get_children():
		button.queue_free()
	get_tree().paused = false
	visible = false

func create_upgrade_button(spirits_pivot):
	var upgrade_array = []
	for spirit_wrapper in spirits_pivot.get_children():
		if spirit_wrapper.get_child_count() == 0:
			upgrade_array += spirts_array
			break
	for spirit_wrapper in spirits_pivot.get_children():
		for spirit in spirit_wrapper.get_children():
			for name in spirit.upgrade_dictionary:
				var upgrade = spirit.upgrade_dictionary[name]
				if upgrade['upgrades'].has(upgrade['lvl']):
					upgrade_array.push_back(spirit.upgrade_dictionary[name])
	
	var count_upgrade = 3 if upgrade_array.size() >= 3 else upgrade_array.size()
	
	for spirit in get_random_upgrade(upgrade_array, count_upgrade):
		var new_upgrade_button = upgrade_button.duplicate()
		new_upgrade_button.data = spirit
		new_upgrade_button.menu_root = self
		upgrade_panel.add_child(new_upgrade_button)
		new_upgrade_button.visible = true

func get_random_upgrade(array, count):
	if array.size() == 0:
		close_upgrade()
		return
	randomize()
	var result = []
	for i in count:
		var rand_index:int = randi() % array.size()
		if array[rand_index]:
			result.push_back(array[rand_index])
			array.remove(rand_index)
	
	return result

var spirts_array = [
		{
			'name': 'Thunder spirit',
			'type': 'lightning',
			'node_link': 'res://src/spirits/lightning_spirit/lightning_spirit.tscn',
			'image_src': 'res://src/spirits/lightning_spirit/lightning_spirit.png'
		},
		{
			'name': 'Void spirit',
			'type': 'dark',
			'node_link': 'res://src/spirits/dark_spirit/dark_spirit.tscn',
			'image_src': 'res://src/spirits/dark_spirit/dark_spirit.png'
		},
		{
			'name': 'Void spirit',
			'type': 'dark',
			'node_link': 'res://src/spirits/dark_spirit/dark_spirit.tscn',
			'image_src': 'res://src/spirits/dark_spirit/dark_spirit.png'
		}
	]
