extends Control

onready var score_label = $Score

func _ready():
	Game.connect("score_updated", self, "update_score")

func update_score():
	score_label.text = str(Game.score)
	
