extends Node3D

@onready var camera_next_position
@onready var camera = $"SubViewportContainer/SubViewport/bargaining-camera"
@onready var outline_material = load("res://materials/outline_material.tres")
@onready var SceneTransitionAnimation = $SubViewportContainer/SubViewport/scene_transition_animation/AnimationPlayer
@onready var textBox = $CanvasLayer
@onready var lines : Array

func _ready() -> void:
	GlobalVariables.insideGate = false
	SceneTransitionAnimation.play("fade-out")
	lines = [
	StaticData.textData["bargaining_start_dialogue"]["start_dialogue_1"]
	]
	await get_tree().create_timer(2.0).timeout
	textBox.start_dialogue(lines)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("KeyF"):
		if GlobalVariables.insideGate == true:
			print("Travelling to next Realm...")
			SceneTransitionAnimation.play("fade-in")
			await get_tree().create_timer(2.0).timeout
			get_tree().change_scene_to_file("res://scenes/Depression.tscn");
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


func _on_area_4_body_entered(_body: Node3D) -> void:
	camera_next_position = Vector3(30, 4, 12)
	GlobalVariables.camera_transition(camera, "position", camera_next_position, 1)

func _on_gate_area_body_entered(_body: Node3D) -> void:
	$SubViewportContainer/SubViewport/GateToRealm.material_overlay = outline_material
	GlobalVariables.insideGate = true
	GlobalVariables.pressFdisplay = true

func _on_gate_area_body_exited(_body: Node3D) -> void:
	$SubViewportContainer/SubViewport/GateToRealm.material_overlay = null
	GlobalVariables.pressFdisplay = false
	GlobalVariables.insideGate = false


func _on_area_3d_body_entered(_body: Node3D) -> void:
	if GlobalVariables.bargainingStatus1 == false:
		lines = [
		StaticData.textData["bargainingDialogue_1"]["death_dialogue_1"],
		StaticData.textData["bargainingDialogue_1"]["cube_dialogue_1"],
		StaticData.textData["bargainingDialogue_1"]["death_dialogue_2"],
		StaticData.textData["bargainingDialogue_1"]["cube_dialogue_2"],
		StaticData.textData["bargainingDialogue_1"]["death_dialogue_3"],
		StaticData.textData["bargainingDialogue_1"]["cube_dialogue_3"],
		StaticData.textData["bargainingDialogue_1"]["cube_dialogue_4"],
		StaticData.textData["bargainingDialogue_1"]["death_dialogue_4"],
		StaticData.textData["bargainingDialogue_1"]["cube_dialogue_5"],
		StaticData.textData["bargainingDialogue_1"]["death_dialogue_5"],
		]
		textBox.start_dialogue(lines)
		GlobalVariables.bargainingStatus1 = true
	elif  GlobalVariables.bargainingStatus1 == true && GlobalVariables.promisesCollected <= 2:
		lines = [
			StaticData.textData["bargainingBetweenDialogue"]["death_dialogue_1"],
		]
		textBox.start_dialogue(lines)
	elif GlobalVariables.bargainingStatus1 == true && GlobalVariables.promisesCollected == 3:
		lines = [
		StaticData.textData["bargainingDialogue_2"]["death_dialogue_1"],
		StaticData.textData["bargainingDialogue_2"]["cube_dialogue_1"],
		StaticData.textData["bargainingDialogue_2"]["death_dialogue_2"],
		StaticData.textData["bargainingDialogue_2"]["cube_dialogue_2"],
		StaticData.textData["bargainingDialogue_2"]["death_dialogue_3"],
		]
		textBox.start_dialogue(lines)
		$SubViewportContainer/SubViewport/Floor/gateBlocker.queue_free()
		$SubViewportContainer/SubViewport/Area3D.queue_free()
