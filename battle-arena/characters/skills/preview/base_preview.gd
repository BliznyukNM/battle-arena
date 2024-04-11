extends Node3D


@onready var _view: MeshInstance3D = $View


var _get_options: Callable


func init(get_options: Callable) -> void:
    _get_options = get_options
    var options: Dictionary = _get_options.call()
    var distance: float = options.get("distance", 0.0)
    var radius: float = options.get("radius", 1.0)
    _view.mesh = _construct_mesh(distance, radius)


func _construct_mesh(distance: float, radius: float) -> Mesh:
    return Mesh.new()


func _process(delta: float) -> void:
    var options: Dictionary = _get_options.call()
    if options.has("target"): global_transform = options.target
