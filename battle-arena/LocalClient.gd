extends Node


var client: NakamaClient
var socket: NakamaSocket
var session: NakamaSession


func _ready() -> void:
    const scheme: = "http"
    const host: = "127.0.0.1"
    const port: = 7350
    const server_key: = "defaultkey"
    
    client = Nakama.create_client(server_key, host, port, scheme)
    
    assert(client, "cannot connect to %s:%d" % [host, port])
    if not client: return
    
    session = await client.authenticate_device_async(OS.get_unique_id())
    
    assert(client, str(session.exception))
    if session.is_exception(): return
    
    socket = Nakama.create_socket_from(client)
    await socket.connect_async(session)
    print(socket)
