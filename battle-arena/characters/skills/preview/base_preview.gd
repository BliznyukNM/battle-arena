extends Node3D


@onready var _view: MeshInstance3D = $View


var _get_options: Callable


func init(get_options: Callable) -> void:
    _get_options = get_options
    _view.mesh = _construct_mesh()


func _construct_mesh() -> Mesh:
    return Mesh.new()


func _process(delta: float) -> void:
    var options: Dictionary = _get_options.call()
    if options.has("target"): global_transform = options.target
