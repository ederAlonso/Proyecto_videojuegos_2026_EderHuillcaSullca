extends Area2D
# puerta para pasar nivel

signal siguiente

func _on_body_entered(body):
	if body.name == "Player" and body.has_key:
		emit_signal("siguiente")
		print("Nivel completado")
