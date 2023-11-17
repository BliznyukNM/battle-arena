shader_type spatial;

render_mode blend_mix, unshaded;

uniform vec4 albedo : source_color;
uniform sampler2D main_texture : source_color, repeat_enable;
uniform sampler2D depth_texture : source_color, hint_depth_texture;
uniform vec2 tiling;
uniform vec2 speed;


void vertex() {
	vec3 local_up = MODEL_MATRIX[1].xyz;
	//cross of:
	//	local_transform.basis.y     and    to_world(view_space.forward)
	//normalized
	//(represents right direction)
	vec4 ax = vec4(normalize(cross(local_up, INV_VIEW_MATRIX[2].xyz)), 0.0);
	//local_transform.basis.y
	//(represents up direction)
	vec4 ay = vec4(local_up.xyz, 0.0);
	//cross of:
	//	to_world(view_space.right)    and    local_transform.basis.y
	//(represents forward direction)
	vec4 az = vec4(normalize(cross(INV_VIEW_MATRIX[0].xyz, local_up)), 0.0);
	MODELVIEW_MATRIX = VIEW_MATRIX * mat4(ax, ay, az, MODEL_MATRIX[3]);
	MODELVIEW_NORMAL_MATRIX = mat3(MODELVIEW_MATRIX);
}

void fragment() {
    float depth = texture(depth_texture, SCREEN_UV).x;
    
    
	vec2 uv = UV.yx * tiling + speed * TIME;
	vec4 albedo_tex = texture(main_texture, uv);
	ALBEDO = albedo.rgb * albedo_tex.rgb;
	ALPHA = albedo_tex.a * albedo.a;
}