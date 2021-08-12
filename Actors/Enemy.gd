extends Actor

class_name Enemy

func die():
	queue_free()
	Game.delete_enemy()
