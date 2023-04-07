extends Node


enum Mode { Local, Client, Server }


@onready var offline_map: = preload("res://map/offline.tscn")
@onready var online_map: = preload("res://map/online.tscn")


func _ready() -> void:
    var args: = OS.get_cmdline_user_args()
    for arg in args: _parse_argument(arg)


func _parse_argument(arg: String) -> void:
    match arg:
        "--server":
            _start.call_deferred(Mode.Server)
        "--client":
            _start.call_deferred(Mode.Client)
        "--local":
            _start.call_deferred(Mode.Local)


func _change_ip(ip: String) -> void:
    ProjectSettings.set_setting("application/run/ip_address", ip)


func _start(mode: Mode) -> void:
    match mode:
        Mode.Local:
            get_tree().change_scene_to_packed(offline_map)
        Mode.Client, Mode.Server:
            get_tree().change_scene_to_packed(online_map)
            ProjectSettings.set_setting("application/run/server", mode == Mode.Server)
