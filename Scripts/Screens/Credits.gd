extends Control

const main_screen_scene = "res://Scenes/Screens/MainScreen.tscn"

func _ready():
	$Menu.grab_focus()

func _on_Button_button_up():
	get_tree().change_scene(main_screen_scene)
