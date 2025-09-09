extends CharacterBody2D

var SPEED: int = 200
var screensize: Vector2
var super_power: bool = false

func _ready() -> void:
	screensize = get_viewport_rect().size

func kill() -> void:
	hide()
	$CollisionShape2D.disabled = true
	get_parent().game_over()
	
func do_super() -> void:
	super_power = true
	SPEED += 10
	$AnimatedSprite2D.animation = "super"
	get_parent().change_music(true)
	$Timer.start()

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
		velocity.y = - SPEED
		rotation_degrees = - 180
	elif Input.is_action_pressed("ui_left"):
		velocity.x = - SPEED
		rotation_degrees = 90
	
	if velocity.length() > 0:
		var obj = move_and_collide(velocity * delta)
		if obj:
			if "Turtle" in obj.get_collider().name:
				if super_power:
					var other = obj.get_collider()
					other.kill()
					get_parent().make_point()
				else:
					kill()
			elif "Candy" in obj.get_collider().name:
				var other = obj.get_collider()
				other.kill()
				do_super()
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position.x = clamp(position.x, 25, screensize.x - 25)
	position.y = clamp(position.y, 25, screensize.y - 25)

func _on_timer_timeout() -> void:
	super_power = false
	SPEED -= 10
	$AnimatedSprite2D.animation = "normal"
	get_parent().change_music(false)
