extends VBoxContainer

export var select_sound : AudioStream
export var accept_sound : AudioStream

onready var timer = $Timer
onready var select_audio = $SelectAudio
onready var accept_audio = $AcceptAudio

var buttons : Array = []

var nb_button = 0
var button_selected : int = 0

func _ready():
	for child in get_children():
		if child is Button:
			buttons.append(child)
	
	nb_button = buttons.size()
	select_audio.stream = select_sound
	accept_audio.stream = accept_sound

func _process(delta):
	buttons[button_selected].grab_focus()
	if Input.is_action_pressed("ui_accept"):
		buttons[button_selected].pressed = true
		accept_audio.play()
		#yield(accept_audio, "finished")
		yield(get_tree().create_timer(2.0), "timeout")
	
	if (Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_right")) and timer.is_stopped():
		timer.start()
		button_selected = wrapi(button_selected + 1, 0, nb_button)
		select_audio.play()
		
	if (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_left")) and timer.is_stopped():
		timer.start()
		button_selected = wrapi(button_selected - 1, 0, nb_button)
		select_audio.play()
