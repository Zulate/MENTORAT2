extends Node3D

@onready var camera_next_position
@onready var camera = $"SubViewportContainer/SubViewport/depression-camera"
@onready var outline_material = load("res://materials/outline_material.tres")
@onready var SceneTransitionAnimation = $SubViewportContainer/SubViewport/scene_transition_animation/AnimationPlayer
@onready var textBox = $CanvasLayer
@onready var lines : Array

func _ready() -> void:
	GlobalVariables.insideGate = false
	SceneTransitionAnimation.play("fade-out")
	lines = [
	StaticData.textData["depression_start_dialogue"]["start_dialogue_1"]
	]
	await get_tree().create_timer(2.0).timeout
	textBox.start_dialogue(lines)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("KeyF"):
		if GlobalVariables.insideGate == true:
			print("travelling to next realm")
			SceneTransitionAnimation.play("fade-in")
			await get_tree().create_timer(2.0).timeout
			get_tree().change_scene_to_file("res://scenes/Reflection.tscn");
		else:
			pass
	elif GlobalVariables.player_position.y < -3.0:
		$SubViewportContainer/SubViewport/CharacterBody3D.position = Vector3(0, 9, 0)
		camera_next_position = Vector3(0, 4, 12)
		GlobalVariables.camera_transition(camera, "position", camera_next_position, 1)
	else:
		pass

func _on_weight_area_body_entered(_body: Node3D) -> void:
	GlobalVariables.insideWeight = true
	GlobalVariables.pressFdisplay = true
	$"SubViewportContainer/SubViewport/Weight/StaticBody3D/Weight-object".material_overlay = outline_material

func _on_weight_area_body_exited(_body: Node3D) -> void:
	GlobalVariables.insideWeight = false
	GlobalVariables.pressFdisplay = false
	$"SubViewportContainer/SubViewport/Weight/StaticBody3D/Weight-object".material_overlay = null

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
	$"SubViewportContainer/SubViewport/Spirit-Character".position = $SubViewportContainer/SubViewport/Marker3D.position


func _on_gate_area_body_entered(_body: Node3D) -> void:
	$SubViewportContainer/SubViewport/GateToRealm.material_overlay = outline_material
	GlobalVariables.insideGate = true
	GlobalVariables.pressFdisplay = true


func _on_gate_area_body_exited(_body: Node3D) -> void:
	$SubViewportContainer/SubViewport/GateToRealm.material_overlay = null
	GlobalVariables.pressFdisplay = false
	GlobalVariables.insideGate = false

func _on_dialogue_activator_1_body_entered(_body: Node3D) -> void:
	lines = [
	StaticData.textData["depressionDialogue_1"]["death_dialogue_1"],
	StaticData.textData["depressionDialogue_1"]["cube_dialogue_1"]
	]
	textBox.start_dialogue(lines)
	$SubViewportContainer/SubViewport/dialogue_activator_1.queue_free()

func _on_dialogue_activator_2_body_entered(_body: Node3D) -> void:
	lines = [
	StaticData.textData["depressionDialogue_2"]["death_dialogue_1"],
	StaticData.textData["depressionDialogue_2"]["death_dialogue_2"]
	]
	textBox.start_dialogue(lines)
	$SubViewportContainer/SubViewport/Weight.queue_free()
	$SubViewportContainer/SubViewport/dialogue_activator_2.queue_free()
	GlobalVariables.Speed = 2.5
