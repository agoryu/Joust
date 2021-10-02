extends "res://Actors/Enemy.gd"

class_name ArmorPuppet

func _ready():
	if last_direction == LEFT:
		$Armor.scale.x *= -1

func _physics_process(delta):
	move_and_slide(Vector2(0.0, gravity * delta), Vector2.UP)
