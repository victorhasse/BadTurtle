extends Node2D

func _physics_process(delta: float) -> void:
	$InfoScore.text = str(get_parent().score)
	$InfoTimeOut.text = str(int(get_parent().get_node("Timer").time_left))
	
