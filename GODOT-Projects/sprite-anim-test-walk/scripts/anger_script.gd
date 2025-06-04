extends Node3D

@onready var camera_next_position
@onready var camera = $"SubViewportContainer/SubViewport/anger-camera"
@onready var outline_material = load("res://materials/outline_material.tres")
@onready var SceneTransitionAnimation = $SubViewportContainer/SubViewport/scene_transition_animation/AnimationPlayer

func _process(_delta) -> void:
	$SubViewportContainer/SubViewport/SpotLight3D.position = GlobalVariables.player_position + Vector3(0.3, 3, 0.5)

func _ready() -> void:
	SceneTransitionAnimation.play("fade-out")
