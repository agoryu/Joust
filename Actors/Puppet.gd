extends Enemy

class_name Puppet

func _physics_process(delta):
	move_and_slide(Vector2(0.0, gravity * delta), Vector2.UP)
