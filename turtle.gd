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

func _physics_process(delta: float) -> void:
	var vel: Vector2 = Vector2()
	if direction == DOWN:
		vel.y = SPEED
		rotation_degrees = 0
	elif direction == RIGHT:
		vel.x = SPEED
		rotation_degrees = -90
	elif direction == UP:
		vel.y = -SPEED
		rotation_degrees = 180
	elif direction == LEFT:
		vel.x = -SPEED
		rotation_degrees = 90
	var obj = move_and_collide(vel * delta)
	if obj:
		if "Player" in obj.get_collider().name:
			obj.get_collider().kill()
		else:
			new_goal()
	if vel.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position.x = clamp(position.x, 25, screensize.x - 25)
	position.y = clamp(position.y, 25, screensize.y - 25)
	
func _on_timer_timeout() -> void:
	new_goal()
