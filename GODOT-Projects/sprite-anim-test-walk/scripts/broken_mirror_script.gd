extends Node3D

@onready var outline_material = load("res://materials/outline_material.tres")
@onready var lines : Array
@onready var textBox = $"../../../CanvasLayer"

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("KeyF"):
		if GlobalVariables.insideMirror == true:
			GlobalVariables.promisesCollected += 1
			print(GlobalVariables.promisesCollected)
			$".".queue_free()
			lines = [
			StaticData.textData["brokenMirror"]["mirror_dialogue_1"],
			StaticData.textData["brokenMirror"]["mirror_dialogue_2"],
			StaticData.textData["brokenMirror"]["mirror_dialogue_3"],
			StaticData.textData["brokenMirror"]["mirror_dialogue_4"],
			StaticData.textData["brokenMirror"]["mirror_dialogue_5"],
			StaticData.textData["brokenMirror"]["mirror_dialogue_6"],
			StaticData.textData["brokenMirror"]["mirror_dialogue_7"],
			StaticData.textData["brokenMirror"]["mirror_dialogue_8"],
			StaticData.textData["brokenMirror"]["mirror_dialogue_9"],
			]
			textBox.start_dialogue(lines)
		else:
			pass
	else:
		pass

func _on_area_3d_body_entered(_body: Node3D) -> void:
	if GlobalVariables.bargainingStatus1 == true:
		$"broken-mirror".material_overlay = outline_material
		GlobalVariables.pressFdisplay = true
		GlobalVariables.insideMirror = true


func _on_area_3d_body_exited(_body: Node3D) -> void:
	if GlobalVariables.bargainingStatus1 == true:
		$"broken-mirror".material_overlay = null
		GlobalVariables.pressFdisplay = false
		GlobalVariables.insideMirror = false
