shader_type canvas_item;

uniform float margin;
uniform float gradient_amount;
uniform vec4 color: source_color;

void fragment() {
	float gradient = margin + gradient_amount;
	float left_border = smoothstep(margin, gradient, UV.x);
	float right_border = 1. - smoothstep(1. - gradient, 1. - margin, UV.x);
	float upper_border = smoothstep(margin, gradient, UV.y);
	float lower_border = 1. - smoothstep(1. - gradient, 1. - margin, UV.y);
	float border = 1. - (left_border * right_border * upper_border * lower_border);
	COLOR.rgba = vec4(color.r, color.g, color.b, border * color.a);
}
