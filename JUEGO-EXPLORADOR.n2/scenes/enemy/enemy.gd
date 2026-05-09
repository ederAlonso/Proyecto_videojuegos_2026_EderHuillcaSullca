extends CharacterBody2D

@export var speed  : float = 90.0
@export var gravity: float = 900.0

enum State { IDLE, RUN, ATTACK, DEAD }
var state = State.RUN
var direction : float = -1.0
var cambia_ruta : bool = true

var animacion = null
var raycast   = null

func _ready():
	if has_node("Anim"):
		animacion = $Anim
	if has_node("RayCast2D"):
		raycast = $RayCast2D
		raycast.enabled = true

func _physics_process(delta):
	match state:
		State.IDLE:
			idle_state(delta)
		State.RUN:
			run_state(delta)
	
	velocity.y += gravity * delta
	velocity.x = direction * speed
	move_and_slide()
	
	if is_on_wall():
		if cambia_ruta:
			direction *= -1.0
			cambia_ruta = false
	
	if raycast and not raycast.is_colliding():
		if cambia_ruta:
			direction *= -1.0
			cambia_ruta = false
	else:
		cambia_ruta = true

func idle_state(_delta):
	pass

func run_state(_delta):
	if animacion:
		animacion.play("run")
	handle_direction(direction)

func handle_direction(dir: float):
	if dir != 0.0 and animacion:
		animacion.flip_h = dir < 0.0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.die()
