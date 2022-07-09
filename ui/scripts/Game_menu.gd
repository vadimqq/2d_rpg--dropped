extends Container

func _on_Exit_pressed():
	GAME_CORE.close_game_menu()
	GAME_CORE.open_main_menu()

func _on_button_continue_pressed():
		GAME_CORE.close_game_menu()
