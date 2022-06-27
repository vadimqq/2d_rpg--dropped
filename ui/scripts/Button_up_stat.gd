extends TextureButton

onready var label = $Label
onready var wrapper = $stat_wrapper
onready var stat = $stat_wrapper/Stat

var menu_root = null

func _ready():
	pass

func set_stat(arr_stats):
	for item in arr_stats:
		var new_stat = stat.duplicate()
		wrapper.add_child(new_stat)
		
		var stat_name = new_stat.get_child(0)
		var current_value = new_stat.get_child(1)
		var next_value = new_stat.get_child(3)
		
		stat_name.text = str(item['name']) + ':'
		current_value.text = str(item['current_value'])
		next_value.text = str(item['next_value'])
		new_stat.visible = true


func _on_Button_up_stat_pressed():
	menu_root.upgrade_stat_by_name(label.text)
