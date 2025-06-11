extends Node

#preloading scenes
@onready var denial_level = preload("res://scenes/Denial.tscn")
@onready var anger_level = preload("res://scenes/Anger.tscn")
@onready var bargaining_level = preload("res://scenes/Bargaining.tscn")
@onready var spirit_character = preload("res://scenes/spirit-character.tscn")
@onready var scene_transition = preload("res://scenes/scene_transition_animation.tscn")

#global variables
@onready var player_position
@onready var Speed = 2.5
@onready var Trigger = false

@onready var insideGate = false

#denial scene
@onready var insideFragment1 = false
@onready var insideFragment2 = false
@onready var insideFragment3 = false

@onready var denialDialogue1Status = false
@onready var denialDialogue2Status = false

#anger scene
@onready var insidePillar = false
@onready var insideTriangle = false
@onready var insideSphere = false
@onready var angerDialogue1Status = false
@onready var angerDialogue2Status = false
@onready var insideAngerSphere = false
@onready var angerBetweenStatus = false

@onready var pressFdisplay = false

@onready var fragmentsCollected = 0

func _ready() -> void:
	pass

func camera_transition(node, property, fin_val, duration):
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(node, property, fin_val, duration)
