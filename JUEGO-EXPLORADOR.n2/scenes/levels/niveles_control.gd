extends Control
@onready var niveles = $MarginContainer/VBoxContainer/niveles

func _on_nivel_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")


func _on_nivel_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")


func _on_nivel_3_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_3.tscn")


func _on_volver_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/control.tscn")
