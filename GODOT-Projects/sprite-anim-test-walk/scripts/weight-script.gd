extends Node3D

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("KeyF"):
		if GlobalVariables.insideWeight == true:
			GlobalVariables.weightStatus = true
			$WeightArea.queue_free()
			$"../Floor/gateBlocker".queue_free()
		else:
			pass
	elif GlobalVariables.weightStatus == true:
		$".".position = GlobalVariables.player_position + Vector3(-0.14, 0.82 , 0.15)
		GlobalVariables.Speed = 1
