extends CharacterBody2D

@export var speed  : float = 90.0
@export var gravity: float = 900.0

@export var tiempo_min_ataque : float = 2.0
@export var tiempo_max_ataque : float = 5.0
@export var duracion_ataque : float = 2.0

enum State { IDLE, RUN, ATTACK, DEAD }
var state = State.RUN

var direction : float = -1.0
var cambia_ruta : bool = true
var atacando : bool = false

var animacion = null
var raycast   = null

func _ready():
	randomize()

	if has_node("Anim"):
		animacion = $Anim

	if has_node("RayCast2D"):
		raycast = $RayCast2D
		raycast.enabled = true

	iniciar_ataque_automatico()

func _physics_process(delta):

	match state:
		State.IDLE:
			idle_state(delta)

		State.RUN:
			run_state(delta)

		State.ATTACK:
			attack_state(delta)

	velocity.y += gravity * delta

	if state != State.ATTACK:
		velocity.x = direction * speed
	else:
		velocity.x = 0

	move_and_slide()

	if state != State.ATTACK:

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

func iniciar_ataque_automatico():

	await get_tree().create_timer(randf_range(0.5, 3.0)).timeout

	while true:
		await get_tree().create_timer(randf_range(tiempo_min_ataque, tiempo_max_ataque)).timeout

		atacando = true
		state = State.ATTACK

		await get_tree().create_timer(duracion_ataque).timeout

		state = State.RUN
		atacando = false

func idle_state(_delta):
	pass

func run_state(_delta):

	if animacion:
		animacion.play("run")

	handle_direction(direction)

func attack_state(_delta):

	if animacion:
		animacion.play("ataque")

	handle_direction(direction)

func handle_direction(dir: float):

	if dir != 0.0 and animacion:
		animacion.flip_h = dir < 0.0
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.recibir_daño()


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
