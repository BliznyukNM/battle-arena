class_name EffectSkinCallback extends BaseEffect


@export var method_name: String


func trigger(owner: Node) -> void:
    var method = Callable(owner.skin, method_name)
    assert(method, "Cannot call %s method from %s's skin" % [method_name, owner.name])
    method.call(_parent)
