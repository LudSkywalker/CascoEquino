shader_type spatial;

uniform vec3 color_gap: source_color = vec3(0.0,0.0,0.0);
uniform vec3 color_stripe: source_color = vec3(1.0,1.0,1.0);
uniform float divisions = 10.0; // increase for more stripe density
uniform float stripe_bias = 2.5; // 1.0 means no stripes; 2.0 means stripes and gaps are equal size


void fragment() {
	float w =  UV.x + UV.y;
	if (floor(mod(w * divisions*divisions, stripe_bias)) < 0.001) {
		ALBEDO = color_gap;
	} else {
		ALBEDO = color_stripe;
	}
}