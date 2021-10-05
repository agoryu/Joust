extends Node

signal score_updated
signal enemy_kill
signal game_over
signal player_touch
signal shake_screen
signal retry

onready var CustomSortScore = preload("res://Scripts/Sort/CustomSortScore.gd")
onready var SAVE_PATH = "res://scores.json"
onready var save_file = File.new()

var score = 0 setget set_score
var life = 3

var scores = Dictionary()

func delete_enemy():
	set_score(score + 1)
	emit_signal("enemy_kill")
	
func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")
	
func player_touch():
	emit_signal("player_touch")
	life -= 1
	if life == 0:
		emit_signal("game_over")
		
func shake_screen():
	emit_signal("shake_screen")
	
func load_data():
	if not save_file.file_exists(SAVE_PATH):
		print("ERROR: file does not exist (res://scores.json)")
		return 
	
	save_file.open(SAVE_PATH, File.READ)
	scores = parse_json(save_file.get_as_text())
	save_file.close()
	
func save_score(score: int, player_name):
	if scores == null or scores.empty():
		scores[player_name + String(score)] = [score, player_name]
	else:
		var score_list = scores.values()
		score_list.sort_custom(CustomSortScore, "sort_ascending")
		var previous_score = []
		for old_score in score_list:
			if score > old_score[0]:
				previous_score = old_score
			else:
				break
		
		if previous_score != []:
			if scores.size() > 9:
				scores.erase(score_list[0][1] + String(score_list[0][0]))
			scores[player_name + String(score)] = [score, player_name]
	
	save_file.open(SAVE_PATH, File.WRITE)
	save_file.store_line(to_json(scores))
	save_file.close()

func start_game():
	get_tree().change_scene("res://Scenes/Game/Joust.tscn")
	get_tree().paused = false
	Game.life = 3
	Game.score = 0
