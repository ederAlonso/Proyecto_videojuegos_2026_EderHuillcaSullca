extends Node2D
@onready var puerta := $Door

func _ready() -> void:
	puerta.connect("siguiente", _cambiar_escena)

func _cambiar_escena():
	call_deferred("_next_level")

func _next_level():
	get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")
