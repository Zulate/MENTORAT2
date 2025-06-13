extends Node3D

@onready var outline_material = load("res://materials/outline_material.tres")


func _on_area_3d_body_entered(_body: Node3D) -> void:
	$"broken-mirror".material_overlay = outline_material
	GlobalVariables.pressFdisplay = true
	GlobalVariables.insideMirror = true


func _on_area_3d_body_exited(_body: Node3D) -> void:
	$"broken-mirror".material_overlay = null
	GlobalVariables.pressFdisplay = false
	GlobalVariables.insideMirror = false
