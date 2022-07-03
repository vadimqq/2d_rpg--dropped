extends TextureButton

onready var label_container = $CenterContainer/MarginContainer2/MarginContainer/Label
onready var image_container = $CenterContainer/MarginContainer2/MarginContainer/CenterContainer/TextureRect
onready var lvl_container = $CenterContainer/MarginContainer2/MarginContainer/MarginContainer/VBoxContainer/lvl
onready var description_container = $CenterContainer/MarginContainer2/MarginContainer/MarginContainer/VBoxContainer/description

var menu_root = null
var data = {
	'name': '',
	'lvl': 0,
	'node_link': '',
	'updete_func': null
}

func _ready():
	label_container.text = data['name']
	if data.has('image_src'):
		var image_src = load(data['image_src'])
		image_container.texture = image_src
	
	if data.has('lvl'):
		lvl_container.text = 'lvl: ' + str(data['lvl'])
	elif data.has('type'):
		lvl_container.text = 'type: ' + str(data['type'])
	
	if data.has('description'):
		description_container.text = data['description']
	elif data.has('upgrades'):
		description_container.text = data['upgrades'][data['lvl']]['discription']

func _on_Upgrade_button_button_up():
	if data.has('node_link'):
		get_tree().get_nodes_in_group('player')[0].upgrade_spirit(data['node_link'])
		menu_root.close_upgrade()
	if data.has('updete_func'):
		data['updete_func'].call_func()
		menu_root.close_upgrade()
