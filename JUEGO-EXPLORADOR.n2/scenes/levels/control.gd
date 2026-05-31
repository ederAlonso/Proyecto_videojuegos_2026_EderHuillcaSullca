extends Control
@onready var play = $MarginContainer/VBoxContainer/play

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")


func _on_optiones_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/niveles_control.tscn")
	 # Replace with function body.

func _on_exit_pressed() -> void:
	get_tree().quit()
