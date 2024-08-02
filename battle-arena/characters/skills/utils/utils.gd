@tool


const EXPRESSION_PLACEHOLDER: String = "Insert an expression..."


static func parse_expression(source: String, input_names: PackedStringArray = PackedStringArray()) -> Expression:
    var result: Expression = Expression.new()
    var error: int = result.parse(source, input_names)
    
    if not Engine.is_editor_hint() and error != OK:
        push_error(
            "[Leaf] Couldn't parse expression with source: `%s` Error text: `%s`" %\
            [source, result.get_error_text()]
        )
    
    return result


static func get_collision_mask(character: CharacterBody3D, collision_type: int) -> int:
    const default: = 1 << 0
    const team_a: = 1 << 1
    const team_b: = 1 << 2
    const neutral: = 1 << 3
    
    const enemy: = 1 << 0
    const ally: = 1 << 1
    
    var mask: = default
    if collision_type & enemy > 0: mask = mask | character.collision_layer ^ (team_a | team_b | neutral)
    if collision_type & ally > 0: mask = mask | character.collision_layer
    return mask
