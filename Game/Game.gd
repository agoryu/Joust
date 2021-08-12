extends Node

signal score_updated
signal enemy_kill

var score = 0 setget set_score

func delete_enemy():
	set_score(score + 1)
	emit_signal("enemy_kill")
	
func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")
