extends TextureButton

onready var label = $Label
onready var image = $TextureRect
var menu_root = null
var data = {
	'name': '',
	'lvl': 0,
	'node_link': '',
	'updete_func': null
}

func _ready():
	label.text = data['name'] + str(data['lvl']) if data.has('lvl') else data['name']
	if data.has('image_src'):
		var image_src = load(data['image_src'])
		image.texture = image_src

func _on_Button_up_stat_pressed():
	if data.has('node_link'):
		get_tree().get_nodes_in_group('player')[0].upgrade_spirit(data['node_link'])
		menu_root.close_upgrade()
	if data.has('updete_func'):
		data['updete_func'].call_func()
#		menu_root.clear_upgrade_object(data)
		menu_root.close_upgrade()
