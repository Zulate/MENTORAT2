extends MeshInstance3D

var im := ImmediateMesh.new()
var material := StandardMaterial3D.new()

func _ready():
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.RED  # Standardfarbe
	mesh = im

func draw_line(from: Vector3, to: Vector3, color: Color):
	# Clear und begin
	im.clear_surfaces()
	material.albedo_color = color
	im.surface_begin(Mesh.PRIMITIVE_LINES, material)
	
	im.surface_add_vertex(from)
	im.surface_add_vertex(to)
	
	im.surface_end()
