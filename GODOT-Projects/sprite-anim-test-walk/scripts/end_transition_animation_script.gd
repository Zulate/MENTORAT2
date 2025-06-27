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
		StaticData.textData["end_transition"]["cube_dialogue_6"],
		StaticData.textData["end_transition"]["cube_dialogue_7"],
		StaticData.textData["end_transition"]["cube_dialogue_8"],
		StaticData.textData["end_transition"]["cube_dialogue_9"],
		StaticData.textData["end_transition"]["cube_dialogue_10"],
		StaticData.textData["end_transition"]["cube_dialogue_11"],
		StaticData.textData["end_transition"]["cube_dialogue_12"],
		StaticData.textData["end_transition"]["cube_dialogue_13"],
		StaticData.textData["end_transition"]["cube_dialogue_14"],
		StaticData.textData["end_transition"]["cube_dialogue_15"],
	]
	textBox.start_dialogue(lines)
	await get_tree().create_timer(2.0).timeout
	tween_transition($SubViewportContainer/SubViewport/Sprite3D, "modulate", Color(1, 1, 1), 4.0)
	await get_tree().create_timer(3.0).timeout
	tween_transition($SubViewportContainer/SubViewport/Sprite3D2, "modulate", Color(0.5, 0.5, 0.5), 4.0)
	await get_tree().create_timer(5.0).timeout
	tween_transition($SubViewportContainer/SubViewport/Sprite3D3, "modulate", Color(1, 1, 1), 4.0)
	


func tween_transition(node, property, fin_val, duration):
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(node, property, fin_val, duration)
