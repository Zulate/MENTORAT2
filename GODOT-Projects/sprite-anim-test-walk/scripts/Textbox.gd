extends CanvasLayer

signal stop_movement

@onready var CHAR_READ_RATE = 0.025
@onready var talking_indicator = $"../SubViewportContainer/SubViewport/talking_indicator"

@onready var letter_sound = $LetterSound
var previous_visible_chars: int = 0

enum State{
	READY,
	READING,
	FINISHED
}

@onready var tween
var dialogue_queue: Array = []
var dialogue_index: int = 0

@onready var current_state = State.READY

@onready var DialogueBox = $DialogueBox
@onready var start_symbol = $DialogueBox/MarginContainer/HBoxContainer/Start
@onready var end_symbol = $DialogueBox/MarginContainer/HBoxContainer/End
@onready var label = $DialogueBox/MarginContainer/HBoxContainer/Label
@onready var lines

func _ready() -> void:
	print("Starting state: State.READY")
	hide_textbox()

func _process(_delta):
	match current_state:
		State.READY:
			pass
		State.READING:
			if Input.is_action_just_pressed("enter"):
				label.visible_ratio = 1
				tween.stop()
				end_symbol.text = "v"
				change_state(State.FINISHED)
				
		State.FINISHED:
			if Input.is_action_just_pressed("enter"):
				tween.stop()
				dialogue_index += 1
				change_state(State.READING)
				show_next_line()
				
	#Denial Level Fragment Logic
	if Input.is_action_just_pressed("KeyF"):
		if GlobalVariables.insideFragment1 == true:
			print("fragment 1 collected")
			GlobalVariables.fragmentsCollected += 1
			print(GlobalVariables.fragmentsCollected)
			$"../SubViewportContainer/SubViewport/Memory-fragment".queue_free()
			if GlobalVariables.fragmentsCollected == 1:
				lines = [
					StaticData.textData["fragmentDialogue"]["fragment1"],
					StaticData.textData["fragmentDialogue"]["fragment2"]
				]
				start_dialogue(lines)
		elif  GlobalVariables.insideFragment2 == true:
			$"../SubViewportContainer/SubViewport/Memory-fragment2".queue_free()
			print("fragment 2 collected")
			GlobalVariables.fragmentsCollected += 1
			print(GlobalVariables.fragmentsCollected)
			if GlobalVariables.fragmentsCollected == 1:
				lines = [
					StaticData.textData["fragmentDialogue"]["fragment1"],
					StaticData.textData["fragmentDialogue"]["fragment2"]
				]
				start_dialogue(lines)
		elif GlobalVariables.insideFragment3 == true:
			$"../SubViewportContainer/SubViewport/Memory-fragment3".queue_free()
			print("fragment 3 collected")
			GlobalVariables.fragmentsCollected += 1
			print(GlobalVariables.fragmentsCollected)
			if GlobalVariables.fragmentsCollected == 1:
				lines = [
					StaticData.textData["fragmentDialogue"]["fragment1"],
					StaticData.textData["fragmentDialogue"]["fragment2"]
				]
				start_dialogue(lines)
		else:
			pass
	elif current_state == State.READING:
		var current_visible_chars = int(label.visible_ratio * label.text.length())
		if current_visible_chars > previous_visible_chars:
			var new_char = label.text[previous_visible_chars]
			# optional: keine Sounds für Leerzeichen oder Satzzeichen
			if !new_char in [" "]:
				if not letter_sound.playing:
					letter_sound.play()
					await get_tree().create_timer(0.09).timeout
					letter_sound.stop()
			previous_visible_chars = current_visible_chars
	else:
		pass

func hide_textbox() -> void:
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	DialogueBox.hide()
	talking_indicator.hide()

func show_textbox() -> void:
	start_symbol.text = "*"
	DialogueBox.show()

func add_text(next_text) -> void:
	label.text = next_text
	change_state(State.READING)
	show_textbox()
	tween.tween_property(label, "visible_ratio", 1.0, len(next_text) * CHAR_READ_RATE)
	tween.play()
	tween.tween_callback(_on_tween_finished)
	

func _on_tween_finished() -> void:
	end_symbol.text = "v"
	change_state(State.FINISHED)

func change_state(next_state) -> void:
	current_state = next_state
	match current_state:
		State.READY:
			#print("Changing State to: State_READY")
			pass
		State.READING:
			#print("Changing State to: State_READING")
			pass
		State.FINISHED:
			#print("Changing State to: State_FINISHED")
			pass

func show_next_line():
	if dialogue_index < dialogue_queue.size():
		var next_text = dialogue_queue[dialogue_index]
		label.text = next_text
		label.visible_ratio = 0
		previous_visible_chars = 0
		change_state(State.READING)
		show_textbox()
		
		tween = create_tween()
		tween.tween_property(label, "visible_ratio", 1.0, next_text.length() * CHAR_READ_RATE)
		tween.tween_callback(_on_tween_finished)
		if dialogue_queue[dialogue_index].contains("Me:"):
			talking_indicator.show()
			#print("Me is talking")
			tween_transition(talking_indicator, "position",  $"../SubViewportContainer/SubViewport/CharacterBody3D".position + Vector3(-0.05, 0.75, 0), 0.25)
		elif dialogue_queue[dialogue_index].contains("???:") || dialogue_queue[dialogue_index].contains("Death:"):
			talking_indicator.show()
			#print("Death is talking")
			tween_transition(talking_indicator, "position", $"../SubViewportContainer/SubViewport/Spirit-Character".position + Vector3(0, 1.5, 0), 0.25)
		else:
			talking_indicator.hide()
	else:
		# All lines done
		hide_textbox()
		GlobalVariables.Trigger = false
		change_state(State.READY)

func start_dialogue(text_list: Array) -> void:
	stop_movement.emit()
	dialogue_queue = text_list
	dialogue_index = 0
	show_next_line()

#denial dialogues

func _on_dialogue_2_activator_body_entered(_body: CharacterBody3D) -> void:
	if GlobalVariables.fragmentsCollected == 0 && GlobalVariables.denialDialogue1Status == false:
		lines = [
			StaticData.textData["denialDialogue_1"]["cube_dialogue_1"],
			StaticData.textData["denialDialogue_1"]["death_dialogue_1"],
			StaticData.textData["denialDialogue_1"]["cube_dialogue_2"],
			StaticData.textData["denialDialogue_1"]["death_dialogue_2"],
			StaticData.textData["denialDialogue_1"]["cube_dialogue_3"],
			StaticData.textData["denialDialogue_1"]["death_dialogue_3"],
			StaticData.textData["denialDialogue_1"]["death_dialogue_4"]
		]
		start_dialogue(lines)
		GlobalVariables.denialDialogue1Status = true
	elif GlobalVariables.fragmentsCollected == 1 || GlobalVariables.fragmentsCollected == 2:
		lines = [
			StaticData.textData["denialBetweenDialogue"]["between_1"]
		]
		start_dialogue(lines)
	elif GlobalVariables.fragmentsCollected == 3 && GlobalVariables.denialDialogue2Status == false:
		lines = [
			StaticData.textData["denialDialogue_2"]["cube_dialogue_1"],
			StaticData.textData["denialDialogue_2"]["death_dialogue_1"],
			StaticData.textData["denialDialogue_2"]["cube_dialogue_2"],
			StaticData.textData["denialDialogue_2"]["cube_dialogue_3"],
			StaticData.textData["denialDialogue_2"]["death_dialogue_2"],
			StaticData.textData["denialDialogue_2"]["death_dialogue_3"],
			StaticData.textData["denialDialogue_2"]["cube_dialogue_4"],
			StaticData.textData["denialDialogue_2"]["death_dialogue_4"],
			StaticData.textData["denialDialogue_2"]["death_dialogue_5"],
			StaticData.textData["denialDialogue_2"]["cube_dialogue_5"],
			StaticData.textData["denialDialogue_2"]["death_dialogue_6"],
			StaticData.textData["denialDialogue_2"]["cube_dialogue_6"],
			StaticData.textData["denialDialogue_2"]["death_dialogue_7"],
			StaticData.textData["denialDialogue_2"]["death_dialogue_8"]
		]
		start_dialogue(lines)
		GlobalVariables.denialDialogue2Status = true
		$"../SubViewportContainer/SubViewport/Floor/CollisionShape3D2".queue_free()
	else:
		print("error")

#anger dialogues

func _on_area_3d_body_entered(_body: Node3D) -> void:
	if GlobalVariables.angerDialogue1Status == false && GlobalVariables.angerBetweenStatus == false:
		lines = [
			StaticData.textData["angerDialogue_1"]["cube_dialogue_1"],
			StaticData.textData["angerDialogue_1"]["death_dialogue_1"],
			StaticData.textData["angerDialogue_1"]["cube_dialogue_2"],
			StaticData.textData["angerDialogue_1"]["death_dialogue_2"],
			StaticData.textData["angerDialogue_1"]["death_dialogue_3"],
			StaticData.textData["angerDialogue_1"]["death_dialogue_4"],
			StaticData.textData["angerDialogue_1"]["cube_dialogue_3"],
			StaticData.textData["angerDialogue_1"]["death_dialogue_5"],
			StaticData.textData["angerDialogue_1"]["death_dialogue_6"],
			StaticData.textData["angerDialogue_1"]["death_dialogue_7"],
			StaticData.textData["angerDialogue_1"]["death_dialogue_8"]
		]
		start_dialogue(lines)
		GlobalVariables.angerBetweenStatus = true
	elif GlobalVariables.angerDialogue1Status == true && GlobalVariables.angerDialogue2Status == false && GlobalVariables.angerBetweenStatus == false:
		lines = [
			StaticData.textData["angerDialogue_2"]["cube_dialogue_1"],
			StaticData.textData["angerDialogue_2"]["death_dialogue_1"],
			StaticData.textData["angerDialogue_2"]["cube_dialogue_2"],
			StaticData.textData["angerDialogue_2"]["death_dialogue_2"],
			StaticData.textData["angerDialogue_2"]["cube_dialogue_3"],
			StaticData.textData["angerDialogue_2"]["cube_dialogue_4"]
		]
		start_dialogue(lines)
		GlobalVariables.angerDialogue2Status = true
		GlobalVariables.angerBetweenStatus = true
		$"../SubViewportContainer/SubViewport/Floor/CollisionShape3D2".queue_free()
	elif GlobalVariables.angerDialogue1Status == true && GlobalVariables.angerDialogue2Status == true && GlobalVariables.angerBetweenStatus == false:
		lines = [
			StaticData.textData["angerDialogue_3"]["death_dialogue_1"],
			StaticData.textData["angerDialogue_3"]["death_dialogue_2"]
		]
		start_dialogue(lines)
		$"../SubViewportContainer/SubViewport/Area3D".queue_free()
	elif GlobalVariables.angerBetweenStatus == true:
		lines = [
			StaticData.textData["angerBetweenDialogue"]["death_dialogue_1"]
		]
		start_dialogue(lines)
	else:
		pass


func tween_transition(node, property, fin_val, duration):
	var tween_indicator = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween_indicator.tween_property(node, property, fin_val, duration)
