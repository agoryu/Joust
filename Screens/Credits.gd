extends Control

const menu_scene = "res://Screens/Menu.tscn"

func _ready():
	$Menu.grab_focus()

func _on_Button_button_up():
	get_tree().change_scene(menu_scene)
