extends Control


@onready var loader: = $Loader


var _config: = ConfigFile.new()
var _uuid


const CONFIG_FILE: = "user://local.ini"


func _ready() -> void:
    _restore()


func on_login_pressed() -> void:
    if $Nickname.text.is_empty(): return
    
    _save_username()
    _save_uuid()
    
    var result: = await Matchmaking.authenticate($Nickname.text)
    if result: loader.start_home()


func _on_register_pressed() -> void:
    if $Nickname.text.is_empty(): return
    
    _uuid = UUID.v4()
    
    _save_username()
    _save_uuid()
    
    var result: = await Matchmaking.authenticate($Nickname.text, $Nickname.text, true)
    if result: loader.start_home()


func _restore() -> void:
    var result: = _config.load(CONFIG_FILE)
    if result == ERR_FILE_CANT_OPEN: return
    
    $Nickname.text = _config.get_value("auth", "login", "")
    _uuid = _config.get_value("auth", "uuid", UUID.v4())


func _save_username() -> void:
    _config.set_value("auth", "login", $Nickname.text)
    _config.save(CONFIG_FILE)


func _save_uuid() -> void:
    _config.set_value("auth", "uuid", _uuid)
    _config.save(CONFIG_FILE)
