extends CollisionShape3D

func _on_areagrassright_area_entered(_area: Area3D) -> void:
	$"../Camera3D".position = Vector3(10, 4, 12);
