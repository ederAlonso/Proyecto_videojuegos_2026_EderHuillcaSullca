extends Area2D

func _ready():
	pass

func _on_body_entered(body):
	if body.is_in_group("Player"):
		call_deferred("_reset_levels")

func _reset_levels():
	get_tree().reload_current_scene()
