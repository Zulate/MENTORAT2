extends Area3D


func _on_body_entered(_body: Node3D) -> void:
	Textbox.hide_textbox()
	Textbox.add_text(StaticData.textData["denialDialogue"]["spirit_dialogue_1"])
