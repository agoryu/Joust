extends Node2D

onready var tree = get_tree()

func _ready():
	Game.connect("game_over", self, "game_over")
	Game.player = $Player
	
func game_over():
	tree.paused = true

func _on_UI_retry():
	Game.retry()
