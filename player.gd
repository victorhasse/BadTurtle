extends CharacterBody2D

var SPEED: int = 200
var screensize: Vector2

func _ready() -> void:
	screensize = get_viewport_rect().size

func kill() -> void:
	hide()
	$CollisionShape2D.disabled = true

func _physics_process(delta: float) -> void:
	velocity.x = 0
	velocity.y = 0
	if Input.is_action_pressed("ui_down"):
		velocity.y = SPEED
		rotation_degrees = 0
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		rotation_degrees = - 90
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -SPEED
		rotation_degrees = - 180
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		rotation_degrees = 90
	move_and_slide()
	if velocity.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position.x = clamp(position.x, 25, screensize.x - 25)
	position.y = clamp(position.y, 25, screensize.y - 25)
