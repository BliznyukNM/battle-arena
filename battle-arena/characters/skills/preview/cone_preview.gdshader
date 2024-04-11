shader_type spatial;


uniform sampler2D fillTexture;
uniform float angle;

uniform vec2 uvScale = vec2(1, 1);


mat2 tex_rotate(float _angle){
	return mat2(vec2(cos(_angle), -sin(_angle)), vec2(sin(_angle), cos(_angle)));
}

void fragment() {
    vec2 uv = -(UV * 2. - 1.) * tex_rotate(-radians(angle / 2.0));
    vec4 tex = texture(fillTexture, UV * uvScale + (vec2(1, 1) - uvScale) / 2.0);
    
    if (atan(uv.x, uv.y) + PI > radians(angle)) {
		ALPHA = 0.0;
	} else {
        ALPHA = tex.a;
    }
    
    ALBEDO = tex.rgb;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
