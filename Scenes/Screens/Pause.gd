extends Control

signal set_pause

func _on_Continue_button_up():
	emit_signal("set_pause")
