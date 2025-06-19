extends Node3D

@onready var outline_material = load("res://materials/outline_material.tres")
@onready var insideLight : bool = false
@onready var fin_val : Vector3 = $".".rotation_degrees
@onready var rotationFinished : bool = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("KeyF") && insideLight == true && rotationFinished == true && GlobalVariables.allFacingCenter == false:
		rotationFinished = false
		fin_val += Vector3(0, 45, 0)
		rotate_light()
		await get_tree().create_timer(1.0).timeout
		fin_val = $".".rotation_degrees
		rotationFinished = true
		GlobalVariables.allFacingCenter = all_facing_center($"../Podest")
		if is_facing_center_3d($".", $"../Podest") == true:
			$Area3D.queue_free()
			$Lampe.material_overlay = null
			GlobalVariables.pressFdisplay = false
			insideLight = false

func rotate_light() -> void:
	var tween_light = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween_light.tween_property($".", "rotation_degrees", fin_val, 1.0)

func _on_area_3d_body_entered(_body: Node3D) -> void:
	$Lampe.material_overlay = outline_material
	insideLight = true
	GlobalVariables.pressFdisplay = true

func _on_area_3d_body_exited(_body: Node3D) -> void:
	$Lampe.material_overlay = null
	insideLight = false
	GlobalVariables.pressFdisplay = false

func is_facing_center_3d(obj: Node3D, pos: Node3D, tolerance_deg := 15.0) -> bool:
	var to_center = (pos.global_position - obj.global_position).normalized()
	var forward = obj.global_transform.basis.x.normalized()  # Vorwärtsrichtung in Godot 3D
	var angle = rad_to_deg(forward.angle_to(to_center))
	return angle < tolerance_deg

func all_facing_center(center: Node3D, tolerance_deg := 30.0) -> bool:
	for obj in get_tree().get_nodes_in_group("lights"):
		var to_center = (center.global_position - obj.global_position).normalized()
		var forward = obj.global_transform.basis.x.normalized()  # deine Blickachse
		var angle = rad_to_deg(forward.angle_to(to_center))
		if angle > tolerance_deg:
			return false
	return true
