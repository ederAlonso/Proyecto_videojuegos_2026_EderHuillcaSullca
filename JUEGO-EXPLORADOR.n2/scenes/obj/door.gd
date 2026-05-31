extends Area2D
# puerta para pasar nivel

signal siguiente

func _on_body_entered(body):
	if body.name == "Player" and body.has_key:
		get_tree().change_scene_to_file("res://scenes/levels/juego_terminado.tscn")
		print("Nivel completado")
