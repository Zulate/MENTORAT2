extends Node3D

@onready var outline_material = load("res://materials/outline_material.tres")


func _on_letterarea_body_entered(_body: Node3D) -> void:
	$Cube_001.material_overlay = outline_material
	GlobalVariables.pressFdisplay = true
	GlobalVariables.insideLetter = true


func _on_letterarea_body_exited(_body: Node3D) -> void:
	$Cube_001.material_overlay = null
	GlobalVariables.pressFdisplay = false
	GlobalVariables.insideLetter = false
