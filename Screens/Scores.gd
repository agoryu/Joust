extends Control

onready var nodes = $VBoxContainer.get_children()
onready var CustomSortScore = preload("res://Scripts/CustomSortScore.gd")

const menu_scene = "res://Screens/Menu.tscn"

func _ready():
	var scores = Game.scores
	var score_list = scores.values()
	
	if scores.size() > 1:
		score_list.sort_custom(CustomSortScore, "sort_descending")
	
	for i in scores.size():
		nodes[i].get_node("PlayerName").text = score_list[i][1]
		nodes[i].get_node("Score").text = String(score_list[i][0])
		
	$Menu.grab_focus()

func _on_Button_button_up():
	get_tree().change_scene(menu_scene)
