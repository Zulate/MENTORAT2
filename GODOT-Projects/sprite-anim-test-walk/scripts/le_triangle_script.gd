extends Node3D

func _ready() -> void:
	for child in self.get_children():
		if child is RigidBody3D:
			child.freeze = true
		elif child is Area3D:
			pass

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("KeyF"):
		if GlobalVariables.insideTriangle == true:
			activate_physics_triangle()
			GlobalVariables.pressFdisplay = false
		else:
			pass
	else:
		pass

func activate_physics_triangle():
	for child in self.get_children():
		if child is RigidBody3D:
			child.freeze = false
		elif child is Area3D:
			pass
	
	$"triangle-area".queue_free();
	await get_tree().create_timer(8).timeout;

	queue_free();

func _on_trianglearea_body_entered(_body: Node3D) -> void:
	GlobalVariables.pressFdisplay = true
	GlobalVariables.insideTriangle = true


func _on_trianglearea_body_exited(_body: Node3D) -> void:
	GlobalVariables.pressFdisplay = false
	GlobalVariables.insideTriangle = false
