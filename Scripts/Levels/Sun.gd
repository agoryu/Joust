extends Path2D

onready var astre = [$PathFollow2D/Sun, $PathFollow2D/Moon]
onready var path_follow_sun = $PathFollow2D
onready var curve_length : float = self.get_curve().get_baked_length()

export var total_time_sun = 60.0
export var total_time_moon = 20.0

var delta_time = 0.0
var isDay : bool = true

func _process(delta):
	if isDay:
		run_path(total_time_sun, delta)
	else:
		run_path(total_time_moon, delta)
	
func run_path(time : float, delta : float):
	if delta_time > time:
		delta_time = 0.0
		isDay = !isDay
		astre[0].visible = isDay
		astre[1].visible = !isDay
		
	delta_time += delta
	var offset_sun = (delta_time / time) * curve_length
	path_follow_sun.set_offset(offset_sun)
