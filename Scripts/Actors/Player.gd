extends Actor

onready var jumpTimer = $JumpTimer
onready var animated_sprite = $AnimatedSprite
onready var audio_walk = $AudioWalk
onready var audio_fly = $AudioFly
onready var audio_attack = $AudioAttack

func _physics_process(delta):
	_velocity = move_and_slide(calculate_move_velocity(), Vector2.UP)
	position.x = wrapf(position.x, 0, screen_size.x)
	switch_direction()
	animate_sprite()

func get_direction() -> Vector2:
	current_direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	return Vector2(
		current_direction,
		-1.0 if Input.get_action_strength("ui_up") || Input.get_action_strength("ui_accept") else 1.0 #and is_on_floor() else 1.0
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
		audio_fly.play()
		
	return out

func switch_direction():
	if current_direction > 0 and last_direction == LEFT:
		last_direction = RIGHT
		scale.x *= -1
	if current_direction < 0 and last_direction == RIGHT:
		last_direction = LEFT
		scale.x *= -1
		
func animate_sprite():
	if animated_sprite.is_playing():
		if current_direction == 0:
			animated_sprite.stop()
			animated_sprite.frame = 1
	else:
		if current_direction != 0 and _velocity.y == 0:
			animated_sprite.play("run")
		if is_jump and animated_sprite.is_playing(): 
			animated_sprite.play("jump")
	
	# First jump
	if !is_jump:
		if !is_on_floor():
			animated_sprite.play("jump")
			$AnimatedSprite/Horse/HorseCollision.scale.y = 0.5
			is_jump = true
	elif is_on_floor():
		animated_sprite.play("run")
		$AnimatedSprite/Horse/HorseCollision.scale.y = 1
		is_jump = false
		nb_jump = NB_JUMP_MAX

func _on_Spear_body_entered(body):
	if body is Knight or body is Puppet or body is ArmorPuppet:
		body.die()
		audio_attack.play()
		Game.shake_screen()
	else:
		bump()

func _on_Horse_area_entered(area):
	bump()

func _on_Knight_area_entered(area):
	Game.player_touch()

func _on_AnimatedSprite_frame_changed():
	if !audio_walk.playing:
		audio_walk.play()

func _on_Spear_area_entered(area):
	if area is Knight:
		area.die()
		audio_attack.play()
		Game.shake_screen()
	else:
		bump()
	
func bump():
	_velocity.x = (_velocity.x + bump_value) * -1
