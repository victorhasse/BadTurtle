extends CharacterBody2D

const DOWN: int = 0
const RIGHT: int = 1
const UP: int = 2
const LEFT: int = 3

var SPEED: int = 100
var direction: int = DOWN
var screensize: Vector2

func _ready() -> void:
	screensize = get_viewport_rect().size
	randomize()
	new_goal()

func new_goal() -> void:
	direction = randi() % 4
	$Timer.start((randi() % 20) / 10.0)

func kill() -> void:
	hide()
	$CollisionShape2D.disabled = true
	$SoundKill.play()
	
func _physics_process(delta) -> void:
	var vel = Vector2()
	if direction == DOWN:
		vel.y += SPEED
		rotation_degrees = 0
	elif direction == RIGHT:
		vel.x += SPEED
		rotation_degrees = -90
	elif direction == UP:
		vel.y -= SPEED
		rotation_degrees = 180
	elif direction == LEFT:
		vel.x -= SPEED
		rotation_degrees = 90
	
	var obj = move_and_collide(vel * delta)
	if obj:
		if 'Player' in obj.get_collider().name:
			var other = obj.get_collider()
			if other.super_power:
				kill()
			else:
				other.kill()
		elif 'Candy' in obj.get_collider().name:
			var other = obj.get_collider()
			add_collision_exception_with(other)
		else:
			new_goal()
	$AnimatedSprite2D.play()

	position.x = clamp(position.x, 25, screensize.x - 25)
	position.y = clamp(position.y, 25, screensize.y - 25)

	if position.x == screensize.x - 25 or position.x == 25 or position.y == screensize.y - 25 or position.y == 25:
		new_goal()

	if position.x == screensize.x - 25 or position.x == 25 or position.y == screensize.y - 25 or position.y == 25:
		new_goal()

func _on_timer_timeout() -> void:
	new_goal()
