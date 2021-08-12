extends "res://Actors/Enemy.gd"

class_name ArmorPuppet

onready var anim_player = $AnimationPlayer

func _physics_process(delta):
	move_and_slide(Vector2(0.0, gravity * delta), Vector2.UP)
	
	if current_direction > 1:
		current_direction = 0
		if last_direction == RIGHT:
			anim_player.play("right")
		else:
			anim_player.play("left")
