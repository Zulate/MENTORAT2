extends MultiMeshInstance3D

func _ready():
	if material_override and material_override is ShaderMaterial:
		material_override.set_shader_parameter("player_position", GlobalVariables.player_position);

func _process(_delta):
	if material_override and material_override is ShaderMaterial:
		material_override.set_shader_parameter("player_position", GlobalVariables.player_position);
