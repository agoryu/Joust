extends Node2D

class_name Level1

onready var spawn_locations = [$Spawn1, $Spawn2, $Spawn3, $Spawn4]
onready var Puppet = load("res://Actors/Puppet.tscn")
onready var Armor_Puppet = load("res://Actors/ArmorPuppet.tscn")
onready var Ostrich_Enemy = load("res://Actors/OstrichEnemy.tscn")

var spawn_index: int = 1#rand_range(0, 4)

func _ready():
	Game.connect("enemy_kill", self, "next_move")
	spawn_enemy()
	
func next_move():
	spawn_enemy()
	
func spawn_enemy():
	var position_enemy = spawn_locations[spawn_index].position
	var enemy = Puppet.instance()
	#if Game.score <= 5:
	#	enemy = Puppet.instance() as Enemy
	#else:
	#	enemy = Armor_Puppet.instance() as Enemy
		
	if spawn_index % 2 == 0:
		enemy.last_direction = Actor.LEFT
		enemy.current_direction = 2
		
	enemy.position = position_enemy
	add_child(enemy)
	spawn_index = (spawn_index + 1) % 4
