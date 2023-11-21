class_name TrailInstance3D extends MeshInstance3D


@export_range(0, 100, 0.01, "or_greater") var time: float = 1


var _time_passed: float
var _original_position: Vector3


func _ready() -> void:
    scale = Vector3.ZERO
    _original_position = position


func _update_mesh(delta: float) -> void:
    if _time_passed >= time:
        set_process(false)
        return
    
    _time_passed = min(_time_passed + delta, 1)
    var normalized_time: = _time_passed / time
    scale = Vector3.ONE * normalized_time
    position = _original_position + Vector3.BACK / 2 * mesh.section_length * mesh.sections * (1 - normalized_time)


func _process(delta: float) -> void:
    _update_mesh(delta)
