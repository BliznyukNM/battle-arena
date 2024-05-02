class_name EffectSkinCallback extends BaseEffect


@export var method_name: String


func apply(owner: Node) -> void:
    var method = Callable(owner.skin, "play_%s" % method_name)
    assert(method, "Cannot call %s method from %s's skin" % [method_name, owner.name])
    method.call()


func clear(owner: Node) -> void:
    var method = Callable(owner.skin, "stop_%s" % method_name)
    assert(method, "Cannot call %s method from %s's skin" % [method_name, owner.name])
    method.call()
