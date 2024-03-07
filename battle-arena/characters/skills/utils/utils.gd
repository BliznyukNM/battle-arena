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
