extends Node3D

@onready var camera_next_position
@onready var camera = $"SubViewportContainer/SubViewport/depression-camera"
@onready var outline_material = load("res://materials/outline_material.tres")
@onready var SceneTransitionAnimation = $SubViewportContainer/SubViewport/scene_transition_animation/AnimationPlayer
@onready var textBox = $CanvasLayer

func _ready() -> void:
	GlobalVariables.insideGate = false
	SceneTransitionAnimation.play("fade-out")
	var lines = [
	StaticData.textData["bargaining_start_dialogue"]["start_dialogue_1"]
	]
	await get_tree().create_timer(2.0).timeout
	textBox.start_dialogue(lines)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("KeyF"):
		if GlobalVariables.insideGate == true:
			print("travelling to next realm")
			SceneTransitionAnimation.play("fade-in")
			await get_tree().create_timer(2.0).timeout
			get_tree().change_scene_to_file("res://scenes/Depression.tscn");
		else:
			pass
	else:
		pass
