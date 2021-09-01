extends Control

signal retry

onready var score_label = $Score
onready var overlay = $Overlay
onready var game_over_ui = $Overlay/GameOver

func _ready():
	Game.connect("score_updated", self, "update_score")
	Game.connect("game_over", self, "game_over")

func update_score():
	score_label.text = str(Game.score)
	
func game_over():
	overlay.visible = true
	game_over_ui.visible = true

func _on_Retry_button_up():
	emit_signal("retry")
