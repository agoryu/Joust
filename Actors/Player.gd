extends Actor

onready var jumpTimer = $JumpTimer
onready var animated_sprite = $AnimatedSprite

func _physics_process(delta):
	_velocity = move_and_slide(calculate_move_velocity(), Vector2.UP)
	position.x = wrapf(position.x, 0, screen_size.x)
	
	if current_direction > 0 and last_direction == LEFT:
		last_direction = RIGHT
		scale.x *= -1
	if current_direction < 0 and last_direction == RIGHT:
		last_direction = LEFT
		scale.x *= -1
	
	if animated_sprite.is_playing():
		if _velocity.x == 0 or _velocity.y != 0:
			animated_sprite.stop()
			animated_sprite.frame = 1
	elif _velocity.x != 0 and _velocity.y == 0:
		animated_sprite.play("run")

func get_direction() -> Vector2:
	current_direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	return Vector2(
		current_direction,
		-1.0 if Input.get_action_strength("ui_up") else 1.0 #and is_on_floor() else 1.0
	)

func calculate_move_velocity():
	var direction: = get_direction()
	var out: = _velocity
	
	if direction.x < 0 || (direction.x == 0 and _velocity.x > 0):
		out.x = max(_velocity.x - acceleration, speed.x * direction.x)
	elif direction.x > 0 || (direction.x == 0 and _velocity.x < 0):
		out.x = min(_velocity.x + acceleration, speed.x * direction.x)
	
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0 and jumpTimer.is_stopped() and nb_jump > 0:
		out.y = speed.y * direction.y
		nb_jump -= 1
		jumpTimer.start()
		
	if is_on_floor() and nb_jump <= 0:
		nb_jump = NB_JUMP_MAX
		
	return out


func _on_Spear_body_entered(body):
	body.die()

func _on_Horse_area_entered(area):
	_velocity.x *= -2 

func _on_Knight_area_entered(area):
	Game.game_over()
