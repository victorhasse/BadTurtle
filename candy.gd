extends StaticBody2D

func kill() -> void:
	hide()
	$CollisionShape2D.disabled = true
