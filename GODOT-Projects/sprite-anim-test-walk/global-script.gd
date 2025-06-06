extends Node

#preloading scenes
@onready var denial_level = preload("res://scenes/Denial.tscn")
@onready var anger_level = preload("res://scenes/Anger.tscn")
@onready var spirit_character = preload("res://scenes/spirit-character.tscn")
@onready var scene_transition = preload("res://scenes/scene_transition_animation.tscn")

@onready var player_position
@onready var Speed = 2.5
@onready var Trigger = false

@onready var insideFragment1 = false
@onready var insideFragment2 = false
@onready var insideFragment3 = false

@onready var insideGate = false

@onready var denialDialogue1Status = false
@onready var denialDialogue2Status = false

@onready var pressFdisplay = false

@onready var fragmentsCollected = 0

func _ready() -> void:
	pass

func camera_transition(node, property, fin_val, duration):
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(node, property, fin_val, duration)
