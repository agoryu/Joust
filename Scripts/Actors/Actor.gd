extends KinematicBody2D

class_name Actor

onready var screen_size = get_viewport_rect().size

export (int) var gravity = 3000.0
export var speed: = Vector2(400.0, 600.0)
export var acceleration = 7
export var NB_JUMP_MAX = 5
export var bump_value = 100.0

const RIGHT: int = 1
const LEFT: int = -1

var is_jump: bool = false
var last_direction: int = RIGHT
var current_direction = 0
var _velocity: Vector2 = Vector2.ZERO
var nb_jump = NB_JUMP_MAX

