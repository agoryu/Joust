extends Node

signal score_updated
signal enemy_kill
signal game_over
signal player_touch
signal shake_screen

var score = 0 setget set_score
var life = 3

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
