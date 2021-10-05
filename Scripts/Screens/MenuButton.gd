extends Button

const main_screen_scene : String = "res://Scenes/Screens/MainScreen.tscn"

func _on_Menu_button_up():
	get_tree().change_scene(main_screen_scene)
	get_tree().paused = false
