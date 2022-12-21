extends Item_with_popup

export (int) var GAIN_MANA = 200

func _on_mana_potion_item_entered(body):
	body.STATS.apply_buff({
		"GAIN_MANA": GAIN_MANA
	})

func _on_mana_potion_item_exited(body):
	body.STATS.apply_buff({
		"GAIN_MANA": -GAIN_MANA
	})
