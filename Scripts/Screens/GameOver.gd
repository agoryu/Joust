extends Control

onready var button_ok = $AcceptName
onready var player_name_label = $PlayerName
onready var buttons = $VBoxContainer
onready var box_container = $HBoxContainer
onready var box_score = $HBoxScore
onready var score_value = $HBoxScore/Score
onready var timer = $Timer
onready var animation = $HBoxContainer/AnimationPlayer

onready var label = [$HBoxContainer/Label, $HBoxContainer/Label2, $HBoxContainer/Label3]
onready var letter = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']

var player_name = []
var letter_selected = 0
var label_selected = 0
var accepted = false
var is_ok = false
var button_selected = 0

func _unhandled_input(event):
	if self.visible:
		if !accepted:
			if event.is_action_pressed("ui_up") and !is_ok:
				letter_selected = fmod(letter_selected + 1, 26) 
				label[label_selected].text = letter[letter_selected]
				label[label_selected].grab_focus()
			if event.is_action_pressed("ui_down") and !is_ok:
				letter_selected = fmod(letter_selected - 1, 26) 
				label[label_selected].text = letter[letter_selected]
				label[label_selected].grab_focus()
			if event.is_action_released("ui_accept") and !is_ok:
				if label_selected == 2:
					player_name.push_back(letter[letter_selected])
					button_ok.visible = true
					button_ok.grab_focus()
					is_ok = true
				else:
					label_selected += 1
					player_name.push_back(letter[letter_selected])
					letter_selected = 0
					animation.stop()
					label[label_selected - 1].valign = 1
			if event.is_action_released("ui_back"):
				if is_ok:
					button_ok.visible = false
					button_ok.release_focus()
					is_ok = false
				elif label_selected != 0:
					label_selected -= 1
					player_name.push_back(letter[letter_selected])
		else:
			if event.is_action_pressed("ui_up"):
				timer.start()
				button_selected = wrapi(button_selected + 1, 0, buttons.get_child_count())
			if event.is_action_pressed("ui_down") and timer.is_stopped():
				timer.start()
				button_selected = wrapi(button_selected - 1, 0, buttons.get_child_count())
			if event.is_action_released("ui_accept") and timer.is_stopped():
				buttons.get_child(button_selected).pressed = true


func _on_AcceptName_button_up():
	box_container.visible = false
	box_score.visible = true
	score_value.text = String(Game.score)
	player_name_label.text = player_name[0] + player_name[1] + player_name[2]
	player_name_label.visible = true
	button_ok.visible = false
	buttons.visible = true
	accepted = true
	Game.save_score(Game.score, player_name_label.text)
	buttons.get_child(0).grab_focus()
	
func _process(delta):
	if !accepted and !is_ok and !animation.is_playing():
		animation.play(String(label_selected))
