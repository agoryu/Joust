extends Control

export var scores_scene = "res://Scenes/Screens/Scores.tscn"
export var credits_scene = "res://Scenes/Screens/Credits.tscn"

onready var timer : Timer = $Timer
onready var tree = get_tree()

var button_selected : int = 0

func _ready():
	Game.load_data()

func _on_Quit_button_up():
	tree.quit()
	
func _on_Scores_button_up():
	tree.change_scene(scores_scene)

func _on_Credits_button_up():
	tree.change_scene(credits_scene)
