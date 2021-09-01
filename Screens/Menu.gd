extends Control

onready var tree = get_tree()

export var level_scene = "res://Game/Joust.tscn"

func _on_Start_button_up():
	tree.change_scene(level_scene)

func _on_Quit_button_up():
	tree.quit()
