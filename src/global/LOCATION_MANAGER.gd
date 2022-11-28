extends Node

const HUB = "res://src/levels/hub/hub.tscn"
const GLADE = "res://src/levels/glade/glade.tscn"

var on_location = false

func load_location(name):
	if on_location:
		get_tree().get_current_scene().y_sort.remove_child(GAME_CORE.player)
		GAME_CORE.player.global_position = Vector2.ZERO
	on_location = true
	get_tree().change_scene(name)
	yield(get_tree(),"idle_frame")
	get_tree().get_current_scene().y_sort.add_child(GAME_CORE.player)
