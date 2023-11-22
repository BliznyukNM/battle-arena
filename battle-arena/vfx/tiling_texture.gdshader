shader_type spatial;

render_mode blend_mix, unshaded;
uniform vec4 albedo : source_color;
uniform sampler2D main_texture : source_color, repeat_enable;
uniform vec2 tiling;
uniform vec2 speed;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
    vec2 uv = UV * tiling + speed * TIME;
	vec4 albedo_tex = texture(main_texture, uv);
	ALBEDO = albedo.rgb * albedo_tex.rgb;
	ALPHA = albedo_tex.a * albedo.a;
}

void light() {
	// Called for every pixel for every light affecting the material.
}
