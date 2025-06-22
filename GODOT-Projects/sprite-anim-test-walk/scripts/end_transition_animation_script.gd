extends Node3D

@onready var SceneTransitionAnimation = $SubViewportContainer/SubViewport/scene_transition_animation/AnimationPlayer
@onready var textBox = $CanvasLayer
@onready var lines : Array

func _ready() -> void:
	GlobalVariables.insideGate = false
	SceneTransitionAnimation.play("fade-out")
	await get_tree().create_timer(2.0).timeout
	$AnimationPlayer.play("the_end")
	await get_tree().create_timer(10.0).timeout
	lines = [
		StaticData.textData["end_transition"]["cube_dialogue_1"],
		StaticData.textData["end_transition"]["cube_dialogue_2"],
		StaticData.textData["end_transition"]["cube_dialogue_3"],
		StaticData.textData["end_transition"]["cube_dialogue_4"],
		StaticData.textData["end_transition"]["cube_dialogue_5"],
	]
	textBox.start_dialogue(lines)
