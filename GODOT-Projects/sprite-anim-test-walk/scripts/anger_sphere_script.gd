extends Node3D

func _ready() -> void:
	for child in $Node3D.get_children():
		if child is RigidBody3D:
			child.freeze = true
		elif child is Area3D:
			pass

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("KeyF"):
		if GlobalVariables.insideAngerSphere == true && GlobalVariables.angerBetweenStatus == true:
			$AnimationPlayer.play("RESET")
			activate_anger_sphere()
			GlobalVariables.pressFdisplay = false
			$Area3D.queue_free()
			$"../../../AudioStreamPlayer3D".volume_db = -50
			GlobalVariables.insideAngerSphere = false
			GlobalVariables.angerDialogue2Status = true
			GlobalVariables.angerBetweenStatus = false
			await get_tree().create_timer(8).timeout
			$Node3D.queue_free()
		else:
			pass
	else:
		pass

func activate_anger_sphere() -> void:
	for child in $Node3D.get_children():
		if child is RigidBody3D:
			child.freeze = false
		elif child is Area3D:
			pass
		else:
			pass


func _on_area_3d_body_entered(_body: Node3D) -> void:
	if GlobalVariables.angerDialogue1Status == true && GlobalVariables.angerBetweenStatus == true:
		GlobalVariables.pressFdisplay = true
		GlobalVariables.insideAngerSphere = true
	else:
		GlobalVariables.insideAngerSphere = false


func _on_area_3d_body_exited(_body: Node3D) -> void:
	GlobalVariables.pressFdisplay = false
	GlobalVariables.insideAngerSphere = false
