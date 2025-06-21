extends Node3D

@onready var camera_next_position
@onready var camera = $"SubViewportContainer/SubViewport/acceptance-camera"
@onready var outline_material = load("res://materials/outline_material.tres")
@onready var SceneTransitionAnimation = $SubViewportContainer/SubViewport/scene_transition_animation/AnimationPlayer
@onready var textBox = $CanvasLayer
@onready var lines : Array

func _ready() -> void:
	GlobalVariables.insideGate = false
	SceneTransitionAnimation.play("fade-out")
	await get_tree().create_timer(2.0).timeout

func _process(_delta: float) -> void:
	$SubViewportContainer/SubViewport/SpotLight3D.position = GlobalVariables.player_position + Vector3(1.5, 4.0, -1.5)
	if Input.is_action_just_pressed("KeyF"):
		if GlobalVariables.insideGate == true:
			print("travelling to next realm")
			SceneTransitionAnimation.play("fade-in")
			await get_tree().create_timer(2.0).timeout
			get_tree().change_scene_to_file("res://scenes/Transition.tscn");
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
	if GlobalVariables.allFacingCenter == false:
		pass
	elif GlobalVariables.allFacingCenter == true:
		lines = [
			StaticData.textData["acceptance_dialogue_1"]["death_dialogue_1"],
		]
		textBox.start_dialogue(lines)
		$SubViewportContainer/SubViewport/Floor/gateBlocker.queue_free()
