extends Camera2D

onready var timer : Timer = $Timer

var shake_amount : float = 3.0

func _ready():
	Game.connect("shake_screen", self, "begin_shake")

func _process(delta):
	if !timer.is_stopped():
		offset = Vector2(
			rand_range(-1.0, 1.0) * shake_amount,
			rand_range(-1.0, 1.0) * shake_amount
		)
	else:
		offset = Vector2.ZERO

func begin_shake():
	timer.start()
