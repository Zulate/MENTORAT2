extends Node3D

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("KeyF"):
		if GlobalVariables.insideWeight == true:
			GlobalVariables.weightStatus = true
			remove_weight_area()
		else:
			pass
	elif GlobalVariables.weightStatus == true:
		$".".position = GlobalVariables.player_position + Vector3(-0.04, 0.81 , 0.1)
		GlobalVariables.Speed = 1


func remove_weight_area() -> void:
	if GlobalVariables.weightStatus == true:
		$WeightArea.queue_free()
