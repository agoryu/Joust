extends Node2D

onready var tree = get_tree()

func _ready():
	Game.connect("game_over", self, "game_over")
	
func game_over():
	tree.paused = true

func _on_UI_retry():
	tree.change_scene("res://Game/Joust.tscn")
	tree.paused = false
