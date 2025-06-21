extends Node3D

@onready var outline_material = load("res://materials/outline_material.tres")
@onready var lines : Array
@onready var textBox = $"../../../CanvasLayer"

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("KeyF"):
		if GlobalVariables.insideLetter == true:
			GlobalVariables.promisesCollected += 1
			print(GlobalVariables.promisesCollected)
			$".".queue_free()
			lines = [
			StaticData.textData["loveLetter"]["letter_dialogue_1"],
			StaticData.textData["loveLetter"]["letter_dialogue_2"],
			StaticData.textData["loveLetter"]["letter_dialogue_3"],
			StaticData.textData["loveLetter"]["letter_dialogue_4"],
			StaticData.textData["loveLetter"]["letter_dialogue_5"],
			StaticData.textData["loveLetter"]["letter_dialogue_6"],
			StaticData.textData["loveLetter"]["letter_dialogue_7"],
			]
			textBox.start_dialogue(lines)
		else:
			pass
	else:
		pass

func _on_letterarea_body_entered(_body: Node3D) -> void:
	if GlobalVariables.bargainingStatus1 == true:
		$Cube_001.material_overlay = outline_material
		GlobalVariables.pressFdisplay = true
		GlobalVariables.insideLetter = true


func _on_letterarea_body_exited(_body: Node3D) -> void:
	if GlobalVariables.bargainingStatus1 == true:
		$Cube_001.material_overlay = null
		GlobalVariables.pressFdisplay = false
		GlobalVariables.insideLetter = false
