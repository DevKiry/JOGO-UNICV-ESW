extends CharacterBody2D

@export var speed: float = 200.0
@export var jump_force: float = -450.0
@export var gravity: float = 900.0

var dead := false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):

	if dead:
		return

	# Gravidade
	if not is_on_floor():
		velocity.y += gravity * delta

	# Movimento horizontal
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = direction * speed
		sprite.flip_h = direction < 0

		if is_on_floor():
			sprite.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

		if is_on_floor():
			sprite.play("idle")

	# Pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force
		sprite.play("jump")

	move_and_slide()
