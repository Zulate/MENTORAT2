extends MultiMeshInstance3D

func _ready() -> void:
	if material_override and material_override is ShaderMaterial:
		material_override.set_shader_parameter("player_position", GlobalVariables.player_position);

func _process(_delta) -> void:
	if material_override and material_override is ShaderMaterial:
		material_override.set_shader_parameter("player_position", GlobalVariables.player_position);
