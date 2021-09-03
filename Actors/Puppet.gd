extends Enemy

class_name Puppet

onready var audio_player = $AudioStreamPlayer2D

func _ready():
	audio_player.play()

func _physics_process(delta):
	move_and_slide(Vector2(0.0, gravity * delta), Vector2.UP)
