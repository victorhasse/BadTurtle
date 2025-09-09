extends Node2D

var score: int = 0

func game_over() -> void:
	$MusicNormal.stop()
	$MusicSuper.stop()
	$SoundGameOver.play()
	$GameOver.visible = true
	
func change_music(superPower) -> void:
	if superPower:
		$MusicNormal.stop()
		$MusicSuper.play()
	else:
		$MusicSuper.stop()
		$MusicNormal.play()
		
func make_point() -> void:
	$Timer.start($Timer.time_left + 5)
	score += 1
	
func _on_timer_timeout() -> void:
	$Player.kill()
