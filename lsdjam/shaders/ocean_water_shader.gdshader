shader_type spatial;

uniform float amplitude;

void vertex() {
	VERTEX.x += sin(TIME * 2.0 + VERTEX.y * 2.0);
	VERTEX.y += sin(TIME + VERTEX.x * 0.5)*0.5 + sin(TIME * 0.1) * 2.0;
	}
	
void fragment() {
	ALBEDO = vec3(0.2, 0.5, 0.7);
	ALPHA = 0.7;
	}