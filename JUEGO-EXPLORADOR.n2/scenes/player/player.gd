extends CharacterBody2D
@onready var animacion := $Anim
@onready var corazon = $"../CanvasLayer/life/corazon"
@onready var corazon2 = $"../CanvasLayer/life/corazon2"
@onready var corazon3 = $"../CanvasLayer/life/corazon3"

enum State { IDLE, RUN, JUMP, ATTACK, DEAD }
var state = State.IDLE
var speed = 100
var jump_force = -400
var gravity = 900
var has_key = false

var vidas = 3
var invulnerable = false

func actualizar_vidas():
	corazon.visible = vidas >= 1
	corazon2.visible = vidas >= 2
	corazon3.visible = vidas >= 3
	
func _ready() -> void:
	add_to_group("Player")

func _physics_process(delta):
	match state:
		State.IDLE:
			idle_state(delta)
		State.RUN:
			run_state(delta)
		State.JUMP:
			jump_state(delta)
		State.ATTACK:
			attack_state(delta)
		State.DEAD:
			dead_state(delta)
	velocity.y += gravity * delta
	move_and_slide()

func idle_state(_delta):
	animacion.play("idle")
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left"):
		state = State.RUN
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("move_jump"):
		velocity.y = jump_force
		state = State.JUMP

func run_state(_delta):
	animacion.play("run")
	var dir = Input.get_axis("ui_left", "ui_right")
	if dir == 0:
		dir = Input.get_axis("move_left", "move_right")
	handle_direction(dir)
	velocity.x = dir * speed
	if dir == 0:
		state = State.IDLE
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("move_jump"):
		velocity.y = jump_force
		state = State.JUMP

func jump_state(_delta):
	animacion.play("jump")
	var dir = Input.get_axis("ui_left", "ui_right")
	if dir == 0:
		dir = Input.get_axis("move_left", "move_right")
	handle_direction(dir)
	velocity.x = dir * speed
	if is_on_floor():
		state = State.IDLE

func attack_state(_delta):
	velocity.x = 0
	await get_tree().create_timer(0.3).timeout
	state = State.IDLE

func dead_state(_delta):
	velocity = Vector2.ZERO

func die():
	state = State.DEAD
	call_deferred("_reset_levels")

func handle_direction(dir: float):
	if dir != 0:
		animacion.flip_h = dir < 0

func _reset_levels():
	get_tree().reload_current_scene()

func recibir_daño():
	if invulnerable or state == State.DEAD:
		return

	vidas -= 1
	actualizar_vidas()

	if vidas <= 0:
		die()
	else:
		invulnerable = true
		await get_tree().create_timer(1.0).timeout
		invulnerable = false



	
	
