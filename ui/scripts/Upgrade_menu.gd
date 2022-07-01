extends Container

onready var upgrade_panel = $CenterContainer/PanelContainer
onready var stat_button = $CenterContainer/Button_up_stat

var player_instance = null

func _ready():
	visible = false

func open_upgrade(spirits_pivot):
	stat_button.menu_root = self
	get_tree().paused = true
	visible = true
	
	for spirit_wrapper in spirits_pivot.get_children():
		for spirit in spirit_wrapper.get_children():
			for name in spirit.upgrade_dictionary:
				var upgrade = spirit.upgrade_dictionary[name]
				if upgrade['upgrades'].has(upgrade['lvl']):
					upgrade_array.push_back(spirit.upgrade_dictionary[name])
	
	for spirit in upgrade_array:
		var new_stat_button = stat_button.duplicate()
		new_stat_button.data = spirit
		new_stat_button.menu_root = self
		upgrade_panel.add_child(new_stat_button)
		new_stat_button.visible = true

func close_upgrade():
	for button in upgrade_panel.get_children():
		button.queue_free()
		
	get_tree().paused = false
	visible = false

func clear_upgrade_object(obj):
	upgrade_array.erase(obj)


var upgrade_array = [
		{
			'name': 'light spirit',
			'node_link': 'res://src/spirits/light_spirit/light_spirit.tscn'
		},
		{
			'name': 'dark spirit',
			'node_link': 'res://src/spirits/dark_spirit/dark_spirit.tscn'
		}
	]
