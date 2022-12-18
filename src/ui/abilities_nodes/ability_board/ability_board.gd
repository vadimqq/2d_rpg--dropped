extends CanvasLayer

class_name Ability_board

onready var bow_tree = $VBoxContainer/HBoxContainer/bow_tree

onready var bow_button = $VBoxContainer/HBoxContainer/GridContainer/Bow_tree_button
onready var material_counter = $VBoxContainer/HBoxContainer/GridContainer/Material_counter

onready var dict = {
	"bow_tree": bow_tree
}

var active_tree: VBoxContainer = bow_tree

func _process(delta):
	material_counter.text =  "POINTS: " + str(CURRENCY_MANAGER.upgrade_points)

func open_tree(name):
	active_tree.visible = false
	active_tree = dict[name]
	active_tree.load_info()
	active_tree.visible = true

func _on_Bow_tree_button_button_down():
	open_tree("bow_tree")
