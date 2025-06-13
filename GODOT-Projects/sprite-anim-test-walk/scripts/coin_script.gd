extends Node3D

@onready var outline_material = load("res://materials/outline_material.tres")


func _on_coin_area_body_entered(_body: Node3D) -> void:
	$coin.material_overlay = outline_material
	GlobalVariables.pressFdisplay = true
	GlobalVariables.insideCoin = true


func _on_coin_area_body_exited(_body: Node3D) -> void:
	$coin.material_overlay = null
	GlobalVariables.pressFdisplay = false
	GlobalVariables.insideCoin = false
