shader_type canvas_item;

uniform float time = 0.0;

float get_value(float last_value, float next_value, float last_time, float next_time, float time_value) {
	return (next_value - last_value) / (next_time - last_time) * (time_value - last_time);
}

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	if (color.a > 0.0) {
		return;
	}
	COLOR = vec4(0.5, 0.5, 1.0, 1.0);
	if (time < 63.0) {
		COLOR.r = get_value(0.0, 0.1, 0.0, 63.0, time);
		COLOR.g = get_value(0.0, 0.1, 0.0, 63.0, time);
		COLOR.b = get_value(0.0, 0.4, 0.0, 63.0, time);
	} else if (time >= 63.0 && time < 73.0) {
		COLOR.r = 0.1 + get_value(0.1, 0.5, 63.0, 73.0, time);
		COLOR.g = 0.1;
		COLOR.b = 0.4 + get_value(0.4, 0.6, 63.0, 73.0, time);
	} else if (time >= 73.0 && time < 83.0) {
		COLOR.r = 0.5;
		COLOR.g = 0.1 + get_value(0.1, 0.5, 73.0, 83.0, time);
		COLOR.b = 0.6 + get_value(0.6, 0.7, 73.0, 83.0, time);
	} else if (time >= 83.0 && time < 120.0) {
		COLOR.r = 0.5;
		COLOR.g = 0.5;
		COLOR.b = 0.7 + get_value(0.7, 1.0, 83.0, 120.0, time);
	} else if (time >= 120.0 && time < 200.0) {
		COLOR.r = 0.5 - get_value(0.4, 0.5, 120.0, 200.0, time);
		COLOR.g = 0.5 - get_value(0.4, 0.5, 120.0, 200.0, time);
		COLOR.b = 1.0 - get_value(0.7, 1.0, 120.0, 200.0, time);
	} else if (time >= 200.0 && time < 210.0) {
		COLOR.r = 0.4;
		COLOR.g = 0.4 - get_value(0.1, 0.4, 200.0, 210.0, time);
		COLOR.b = 0.7 - get_value(0.6, 0.7, 200.0, 210.0, time);
	} else if (time >= 210.0 && time < 220.0) {
		COLOR.r = 0.5 - get_value(0.1, 0.5, 210.0, 220.0, time);
		COLOR.g = 0.1;
		COLOR.b = 0.6 - get_value(0.4, 0.6, 210.0, 220.0, time);
	} else {
		COLOR.r = 0.1 - get_value(0.0, 0.1, 220.0, 240.0, time);
		COLOR.g = 0.1 - get_value(0.0, 0.1, 220.0, 240.0, time);
		COLOR.b = 0.4 - get_value(0.0, 0.4, 220.0, 240.0, time);
	}
}