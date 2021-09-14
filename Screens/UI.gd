extends Control

signal retry

const menu_scene : String = "res://Screens/Menu.tscn"
onready var tree := get_tree()
onready var score_label = $Score
onready var overlay = $Overlay
onready var game_over_ui = $Overlay/GameOver
onready var lives = [$HBoxContainer/Heart1, $HBoxContainer/Heart2, $HBoxContainer/Heart3]
onready var pause_menu = $Overlay/Pause

onready var pause_buttons = [
	$Overlay/Pause/VBoxContainer/Continue, 
	$Overlay/Pause/VBoxContainer/Retry, 
	$Overlay/Pause/VBoxContainer/Menu
]
onready var nb_pause_button = pause_buttons.size()
onready var pause_timer = $Overlay/Pause/Timer
var pause_button_selected : int = 0

var paused :bool = false setget set_paused

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		make_pause()

func _ready():
	Game.connect("score_updated", self, "update_score")
	Game.connect("game_over", self, "game_over")
	Game.connect("player_touch", self, "player_touch")

func update_score():
	score_label.text = str(Game.score)
	
func player_touch():
	var life: TextureRect = lives.pop_back()
	life.visible = false
	lives.push_front(life)
	
func game_over():
	overlay.visible = true
	game_over_ui.visible = true

func _on_Retry_button_up():
	emit_signal("retry")
	
func _process(delta):
	if pause_menu.visible:
		control_menu()
		
func control_menu():
	pause_buttons[pause_button_selected].grab_focus()
	if Input.is_action_pressed("ui_accept"):
		pause_buttons[pause_button_selected].pressed = true
	
	if (Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_right")) and pause_timer.is_stopped():
		pause_timer.start()
		pause_button_selected = wrapi(pause_button_selected + 1, 0, nb_pause_button)
		
	if (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_left")) and pause_timer.is_stopped():
		pause_timer.start()
		pause_button_selected = wrapi(pause_button_selected - 1, 0, nb_pause_button)
		
func set_paused(value: bool):
	paused = value
	tree.paused = value
	overlay.visible = value
	pause_menu.visible = value

func make_pause():
	self.paused = !paused
	tree.set_input_as_handled()
	
func _on_Continue_button_up():
	make_pause() 

func _on_Menu_button_up():
	tree.change_scene(menu_scene)
