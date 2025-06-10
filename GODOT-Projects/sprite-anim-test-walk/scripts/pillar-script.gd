extends Node3D

func _ready() -> void:
	for child in self.get_children():
		if child is RigidBody3D:
			child.freeze = true
		elif child is Area3D:
			pass

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("KeyF"):
		if GlobalVariables.insidePillar == true:
			activate_physics_pillar()
			GlobalVariables.pressFdisplay = false
			GlobalVariables.angerDialogue1Status = true
		else:
			pass
	else:
		pass

func activate_physics_pillar():
	for child in self.get_children():
		if child is RigidBody3D:
			child.freeze = false
		elif child is Area3D:
			pass
	
	$"pillar-area".queue_free();
	await get_tree().create_timer(8).timeout;

	queue_free();

func _on_pillararea_body_entered(_body: Node3D) -> void:
	GlobalVariables.pressFdisplay = true
	GlobalVariables.insidePillar = true


func _on_pillararea_body_exited(_body: Node3D) -> void:
	GlobalVariables.pressFdisplay = false
	GlobalVariables.insidePillar = false
