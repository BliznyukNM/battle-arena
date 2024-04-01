extends Area3D


@export_file("*.tscn") var trap_scene: String
@export var flight_time: float = 1.0


const G = 9.81


var velocity: Vector3
var target_position: Vector3


func init(options: Dictionary) -> void:
    target_position = options.target.origin


func _ready() -> void:
    var height: = position.y - target_position.y - 0.3
    var distance: = (target_position - position).length()
    
    var viy = (height / flight_time) - (0.5 * G * flight_time)
    var vx = distance / flight_time
    var vi = sqrt(vx * vx + viy * viy)
    var angle = atan(viy / vx)
    
    rotate_object_local(Vector3.RIGHT, angle)
    velocity = transform.basis.z * vi


func _process(delta: float) -> void:
    velocity.y -= delta * G
    position += velocity * delta


func _on_ground_entered(body: Node3D) -> void:
    if not body is GridMap: return
    var spawn_transform: = transform.translated_local(Vector3(0.0, -0.3, 0.0))
    owner.spawner.spawn({"path": trap_scene, "transform": spawn_transform})
    queue_free()
