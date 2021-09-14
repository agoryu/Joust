extends Control

export var level_scene = "res://Game/Joust.tscn"
onready var buttons : Array = [
	$VBoxContainer/Start, 
	$VBoxContainer/Scores,
	$VBoxContainer/Credits,
	$VBoxContainer/Quit
]
onready var nb_button = buttons.size()
onready var timer : Timer = $Timer
onready var tree = get_tree()

var button_selected : int = 0

func _process(delta):
	buttons[button_selected].grab_focus()
	if Input.is_action_pressed("ui_accept"):
		buttons[button_selected].pressed = true
	
	if (Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_right")) and timer.is_stopped():
		timer.start()
		button_selected = wrapi(button_selected + 1, 0, nb_button)
		
	if (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_left")) and timer.is_stopped():
		timer.start()
		button_selected = wrapi(button_selected - 1, 0, nb_button)

func _on_Start_button_up():
	tree.change_scene(level_scene)

func _on_Quit_button_up():
	tree.quit()
	
