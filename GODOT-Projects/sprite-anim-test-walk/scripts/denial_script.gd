extends Node3D

@onready var camera_next_position
@onready var camera = $"SubViewportContainer/SubViewport/grass-camera"
@onready var outline_material = load("res://materials/outline_material.tres")
@onready var SceneTransitionAnimation = $SubViewportContainer/SubViewport/scene_transition_animation/AnimationPlayer
@onready var textBox = $CanvasLayer
func camera_transition(node, property, fin_val, duration):
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(node, property, fin_val, duration)

func _ready() -> void:
	SceneTransitionAnimation.play("fade-out")
	var lines = [
		StaticData.textData["start_dialogue"]["start_dialogue_1"],
		StaticData.textData["start_dialogue"]["start_dialogue_2"],
		StaticData.textData["start_dialogue"]["start_dialogue_3"],
		StaticData.textData["start_dialogue"]["start_dialogue_4"],
		StaticData.textData["start_dialogue"]["start_dialogue_5"],
		StaticData.textData["start_dialogue"]["start_dialogue_6"]
	]
	await get_tree().create_timer(2.0).timeout
	textBox.start_dialogue(lines)

func _process(_delta):
	if Input.is_action_just_pressed("KeyF"):
		if GlobalVariables.insideGate == true:
			print("travelling to next realm")
			SceneTransitionAnimation.play("fade-in")
			await get_tree().create_timer(2.0).timeout
			get_tree().change_scene_to_file("res://scenes/Anger.tscn");
		else:
			pass
	else:
		pass

func _on_areagrassleft_body_entered(_body: Node3D):
	camera_next_position = Vector3(0, 4, 12)
	camera_transition(camera, "position", camera_next_position, 1)

func _on_areagrassright_2_body_entered(_body: Node3D):
	camera_next_position = Vector3(10, 4, 12)
	camera_transition(camera, "position", camera_next_position, 1)

func _on_areagrassright_3_body_entered(_body: Node3D) -> void:
	camera_next_position = Vector3(20, 4, 12)
	camera_transition(camera, "position", camera_next_position, 1)

func _on_areagrassright_4_body_entered(_body: Node3D) -> void:
	camera_next_position = Vector3(30, 4, 12)
	camera_transition(camera, "position", camera_next_position, 1)


#use realmgate to enter next level

func _on_gate_area_body_entered(_body: Node3D) -> void:
	$SubViewportContainer/SubViewport/GateToRealm.material_overlay = outline_material
	GlobalVariables.insideGate = true
	GlobalVariables.pressFdisplay = true

func _on_gate_area_body_exited(_body: Node3D) -> void:
	$SubViewportContainer/SubViewport/GateToRealm.material_overlay = null
	GlobalVariables.pressFdisplay = false
	GlobalVariables.insideGate = false

#methods for denial-level interactions

func _on_memoryfragment_1_area_body_entered(_body: Node3D) -> void:
	GlobalVariables.insideFragment1 = true;
	GlobalVariables.pressFdisplay = true;
	$"SubViewportContainer/SubViewport/Memory-fragment".material_overlay = outline_material

func _on_memoryfragment_1_area_body_exited(_body: Node3D) -> void:
	GlobalVariables.insideFragment1 = false;
	GlobalVariables.pressFdisplay = false;
	$"SubViewportContainer/SubViewport/Memory-fragment".material_overlay = null

func _on_memoryfragment_2_area_body_entered(_body: Node3D) -> void:
	GlobalVariables.insideFragment2 = true;
	GlobalVariables.pressFdisplay = true;
	$"SubViewportContainer/SubViewport/Memory-fragment2".material_overlay = outline_material

func _on_memoryfragment_2_area_body_exited(_body: Node3D) -> void:
	GlobalVariables.insideFragment2 = false;
	GlobalVariables.pressFdisplay = false;
	$"SubViewportContainer/SubViewport/Memory-fragment2".material_overlay = null

func _on_memoryfragment_3_area_body_entered(_body: Node3D) -> void:
	GlobalVariables.insideFragment3 = true;
	GlobalVariables.pressFdisplay = true;
	$"SubViewportContainer/SubViewport/Memory-fragment3".material_overlay = outline_material

func _on_memoryfragment_3_area_body_exited(_body: Node3D) -> void:
	GlobalVariables.insideFragment3 = false;
	GlobalVariables.pressFdisplay = false;
	$"SubViewportContainer/SubViewport/Memory-fragment3".material_overlay = null
