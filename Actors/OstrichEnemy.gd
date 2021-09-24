extends Enemy

class_name OstrichEnemy

onready var jumpTimer = $JumpTimer
onready var animated_sprite = $AnimatedSprite
onready var audio_attack = $AudioAttack

func _physics_process(delta):
	_velocity = move_and_slide(calculate_move_velocity(), Vector2.UP)
	position.x = wrapf(position.x, 0, screen_size.x)

func calculate_move_velocity():
	var direction: = Vector2(1.0, 0.0)
	var out: = _velocity
	
	out.x = min(_velocity.x + acceleration, speed.x * direction.x)
#
	out.y += gravity * get_physics_process_delta_time()
	if jumpTimer.is_stopped():
		out.y = -speed.y
		jumpTimer.start()
		
	animation()
	
	return out

func _on_Horse_area_entered(area):
	_velocity.x *= -2

func animation():
	if !is_on_floor():
		animated_sprite.play("jump")
		$AnimatedSprite/Horse/HorseCollision.scale.y = 0.5
	else:
		animated_sprite.play("run")
		$AnimatedSprite/Horse/HorseCollision.scale.y = 1.0
