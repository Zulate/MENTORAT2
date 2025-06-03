extends Node3D

@onready var camera_next_position
@onready var camera = $"SubViewportContainer/SubViewport/grass-camera"

func camera_transition(node, property, fin_val, duration):
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(node, property, fin_val, duration)

func _on_areagrassleft_body_entered(_body: Node3D):
	camera_next_position = Vector3(0, 4, 12)
	camera_transition(camera, "position", camera_next_position, 1)

func _on_enterredlevel_body_entered(_body: Node3D) -> void:
	get_tree().change_scene_to_file("res://red.tscn");

func _on_areagrassright_2_body_entered(_body: Node3D):
	camera_next_position = Vector3(10, 4, 12)
	camera_transition(camera, "position", camera_next_position, 1)

func _on_areagrassright_3_body_entered(_body: Node3D) -> void:
	camera_next_position = Vector3(20, 4, 12)
	camera_transition(camera, "position", camera_next_position, 1)

func _on_areagrassright_4_body_entered(_body: Node3D) -> void:
	camera_next_position = Vector3(30, 4, 12)
	camera_transition(camera, "position", camera_next_position, 1)


#methods for denial-level interactions

func _on_memoryfragment_1_area_body_entered(_body: Node3D) -> void:
	GlobalVariables.insideFragment1 = true;
	GlobalVariables.pressFdisplay = true;

func _on_memoryfragment_1_area_body_exited(_body: Node3D) -> void:
	GlobalVariables.insideFragment1 = false;
	GlobalVariables.pressFdisplay = false;

func _on_memoryfragment_2_area_body_entered(_body: Node3D) -> void:
	GlobalVariables.insideFragment2 = true;
	GlobalVariables.pressFdisplay = true;

func _on_memoryfragment_2_area_body_exited(_body: Node3D) -> void:
	GlobalVariables.insideFragment2 = false;
	GlobalVariables.pressFdisplay = false;

func _on_memoryfragment_3_area_body_entered(_body: Node3D) -> void:
	GlobalVariables.insideFragment3 = true;
	GlobalVariables.pressFdisplay = true;

func _on_memoryfragment_3_area_body_exited(_body: Node3D) -> void:
	GlobalVariables.insideFragment3 = false;
	GlobalVariables.pressFdisplay = false;
