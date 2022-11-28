extends Item_with_popup

var count = 1

func _init():
	item_name = "Health potion"
	description = "increases max health"
	stats = {
		"HEALTH": 10
	}
