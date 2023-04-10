extends Node


@export var target: Node3D
@export var max_frames: int = 10
@export var width: float
@export var offset: Vector3
@export var curve: Curve
@export var material: Material


var _current_position: Vector3:
    get: return target.global_position + offset \
        * Basis(target.global_transform.basis.get_rotation_quaternion().inverse())

var _target_up: Vector3:
    get: return target.global_transform.basis.y

var _vertice_count: int:
    get: return max_frames * 2 + 2
    
var _surface_array: = []


func _generate_mesh() -> void:
    $View.mesh.clear_surfaces()
    
    _surface_array = []
    _surface_array.resize(Mesh.ARRAY_MAX)
    
    var vertices = PackedVector3Array()
    vertices.resize(_vertice_count)
    
    for i in range(0, _vertice_count, 2):
        vertices[i + 0] = _current_position + _target_up * width / 2
        vertices[i + 1] = _current_position - _target_up * width / 2
    
    var indices = PackedInt32Array()
    indices.resize(max_frames * 6)
    
    for i in range(0, max_frames):
        indices[i * 6 + 0] = i + 0
        indices[i * 6 + 1] = i + 1
        indices[i * 6 + 2] = i + 2
        
        indices[i * 6 + 3] = i + 1
        indices[i * 6 + 4] = i + 3
        indices[i * 6 + 5] = i + 2
    
    _surface_array[Mesh.ARRAY_VERTEX] = vertices
    _surface_array[Mesh.ARRAY_INDEX] = indices
    
    $View.mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, _surface_array)


func _update_mesh() -> void:
    $View.mesh.clear_surfaces()
    
    var vertices: PackedVector3Array = _surface_array[Mesh.ARRAY_VERTEX]
    vertices.remove_at(_vertice_count - 1)
    vertices.remove_at(_vertice_count - 2)
    vertices.insert(0, _current_position - _target_up * width / 2)
    vertices.insert(0, _current_position + _target_up * width / 2)
    
    if curve:
        for i in range(2, _vertice_count, 2):
            var center: = (vertices[i] + vertices[i + 1]) / 2
            var direction: = (vertices[i] - vertices[i + 1]).normalized()
            var curve_sample: = curve.sample(i / float(_vertice_count))
        
            vertices[i + 0] = center + direction * width / 2.0 * curve_sample
            vertices[i + 1] = center - direction * width / 2.0 * curve_sample
    
    $View.mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, _surface_array)


func enable(value: bool) -> void:
    set_process(value)
    $View.visible = value
    if value: _generate_mesh()


func _ready() -> void:
    enable(false)
    

func _process(delta: float) -> void:
    _update_mesh()
