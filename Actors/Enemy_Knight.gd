extends Area2D

func die():
	get_parent().get_parent().die()
