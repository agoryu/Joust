extends Node2D

class_name Level1

export var menu_presentation : bool = false

onready var spawn_locations = [$Spawn1, $Spawn2, $Spawn3, $Spawn4]
onready var Puppet = load("res://Scenes/Actors/Puppet.tscn")
onready var Armor_Puppet = load("res://Scenes/Actors/ArmorPuppet.tscn")
onready var Ostrich_Enemy = load("res://Scenes/Actors/OstrichEnemy.tscn")
onready var background = $Background
onready var sun = $Sun

var time : float = 63.0

var spawn_index: int = 1#rand_range(0, 4)

func _ready():
	if !menu_presentation:
		Game.connect("enemy_kill", self, "next_move")
		spawn_enemy()
	
func next_move():
	spawn_enemy()
	
func spawn_enemy():
	var position_enemy = spawn_locations[spawn_index].position
	var enemy#Ostrich_Enemy.instance()
	if Game.score < 5:
		enemy = Puppet.instance() as Enemy
	elif Game.score >= 5 and Game.score < 10:
		enemy = Armor_Puppet.instance() as Enemy
	else:
		enemy = Ostrich_Enemy.instance() as Enemy
		
	if spawn_index % 2 == 0:
		enemy.last_direction = Actor.LEFT
		enemy.current_direction = 2
		
	enemy.position = position_enemy
	add_child(enemy)
	spawn_index = (spawn_index + 1) % 4

func _process(delta):
	time += 0.024
	time = fmod(time, 240.0)
	background.material.set_shader_param("time", time)
