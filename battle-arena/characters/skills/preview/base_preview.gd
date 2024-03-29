extends Node3D


@onready var _view: MeshInstance3D = $View


var _skill: BaseSkill
var _distance: float


func _ready() -> void:
    set_process(false)


func start(skill: BaseSkill) -> void:
    if skill.owner.player_id != multiplayer.get_unique_id(): return
    
    _skill = skill
    _distance = skill.distance
    _view.mesh = _construct_mesh(skill)
    skill.execution.timeout.connect(finish, CONNECT_ONE_SHOT)
    set_process(true)
    _process(0.0)


func finish() -> void:
    _view.mesh = null
    _skill = null
    set_process(false)


func _construct_mesh(skill: BaseSkill) -> Mesh:
    return Mesh.new()


func _process(delta: float) -> void:
    var target_position = _skill.get("target_position")
    
    if not target_position:
        rotation = _skill.owner.rotation
        position = _skill.owner.position
    else:
        position = target_position
    
    var distance: float = _skill.distance
    if not is_equal_approx(distance, _distance):
        _view.mesh = _construct_mesh(_skill)
