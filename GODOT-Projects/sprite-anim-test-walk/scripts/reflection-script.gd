extends Node3D

@onready var camera_next_position
@onready var camera = $"SubViewportContainer/SubViewport/reflection-camera"
@onready var outline_material = load("res://materials/outline_material.tres")
@onready var SceneTransitionAnimation = $SubViewportContainer/SubViewport/scene_transition_animation/AnimationPlayer
@onready var textBox = $CanvasLayer
@onready var lines : Array

func _ready() -> void:
	GlobalVariables.insideGate = false
	SceneTransitionAnimation.play("fade-out")
	lines = [
	StaticData.textData["reflection_start_dialogue"]["cube_dialogue_1"]
	]
	await get_tree().create_timer(2.0).timeout
	textBox.start_dialogue(lines)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("KeyF"):
		if GlobalVariables.insideGate == true:
			print("Travelling to next Realm...")
			SceneTransitionAnimation.play("fade-in")
			await get_tree().create_timer(2.0).timeout
			get_tree().change_scene_to_file("res://scenes/Acceptance.tscn");
		else:
			pass
	else:
		pass

func _on_area_1_body_entered(_body: Node3D) -> void:
	camera_next_position = Vector3(0, 4, 12)
	GlobalVariables.camera_transition(camera, "position", camera_next_position, 1)


func _on_area_2_body_entered(_body: Node3D) -> void:
	camera_next_position = Vector3(10, 4, 12)
	GlobalVariables.camera_transition(camera, "position", camera_next_position, 1)


func _on_area_3_body_entered(_body: Node3D) -> void:
	camera_next_position = Vector3(20, 4, 12)
	GlobalVariables.camera_transition(camera, "position", camera_next_position, 1)


func _on_gate_area_body_entered(_body: Node3D) -> void:
	$SubViewportContainer/SubViewport/GateToRealm.material_overlay = outline_material
	GlobalVariables.insideGate = true
	GlobalVariables.pressFdisplay = true


func _on_gate_area_body_exited(_body: Node3D) -> void:
	$SubViewportContainer/SubViewport/GateToRealm.material_overlay = null
	GlobalVariables.insideGate = false
	GlobalVariables.pressFdisplay = false


func _on_dialogue_activator_1_body_entered(_body: Node3D) -> void:
	if GlobalVariables.reflectionStatus1 == false:
		lines = [
		StaticData.textData["reflectionDialogue_1"]["cube_dialogue_1"],
		StaticData.textData["reflectionDialogue_1"]["cube_dialogue_2"],
		StaticData.textData["reflectionDialogue_1"]["death_dialogue_1"],
		StaticData.textData["reflectionDialogue_1"]["death_dialogue_2"],
		StaticData.textData["reflectionDialogue_1"]["cube_dialogue_3"],
		StaticData.textData["reflectionDialogue_1"]["death_dialogue_3"],
		StaticData.textData["reflectionDialogue_1"]["cube_dialogue_4"],
		StaticData.textData["reflectionDialogue_1"]["cube_dialogue_5"],
		StaticData.textData["reflectionDialogue_1"]["cube_dialogue_6"],
		StaticData.textData["reflectionDialogue_1"]["death_dialogue_4"],
		StaticData.textData["reflectionDialogue_1"]["cube_dialogue_7"],
		StaticData.textData["reflectionDialogue_1"]["death_dialogue_5"],
		]
		textBox.start_dialogue(lines)
		GlobalVariables.reflectionStatus1 = true
		$SubViewportContainer/SubViewport/Floor/gateBlocker.queue_free()
	elif GlobalVariables.reflectionStatus1 == true:
		lines = [
			StaticData.textData["reflectionBetweenDialogue"]["death_dialogue_1"]
		]
		textBox.start_dialogue(lines)
