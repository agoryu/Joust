extends VBoxContainer

onready var timer = $Timer

var buttons : Array = []

var nb_button = 0
var button_selected : int = 0

func _ready():
	for child in get_children():
		if child is Button:
			buttons.append(child)
	
	nb_button = buttons.size()

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
