extends Node3D


@onready var _view: MeshInstance3D = $View


func start(skill: BaseSkill) -> void:
    _view.mesh = _construct_mesh(skill.distance, skill.radius)
    skill.execution.timeout.connect(finish, CONNECT_ONE_SHOT)


func finish() -> void:
    _view.mesh = null


func _construct_mesh(distance: float, width: float) -> ArrayMesh:
    const tip_offset: = 0.8
    const start_offset: = 0.7
    
    var vertices: = PackedVector3Array()
    vertices.push_back(Vector3(0, 0, distance))
    vertices.push_back(Vector3(width, 0, distance - tip_offset))
    vertices.push_back(Vector3(-width, 0, distance - tip_offset))
    vertices.push_back(Vector3(width, 0, start_offset))
    vertices.push_back(Vector3(-width, 0, start_offset))
    
    var indices: = PackedInt32Array()
    indices.append_array([0, 2, 1])
    indices.append_array([2, 4, 3])
    indices.append_array([2, 3, 1])
    
    var mesh: = ArrayMesh.new()
    var mesh_data: = []
    mesh_data.resize(Mesh.ARRAY_MAX)
    
    mesh_data[Mesh.ARRAY_VERTEX] = vertices
    mesh_data[Mesh.ARRAY_INDEX] = indices
    
    mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, mesh_data)
    
    return mesh
