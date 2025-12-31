shader_type canvas_item;

uniform vec4 bg_color : source_color = vec4(0.1, 0.1, 0.2, 1.0);
uniform vec4 fog_color : source_color = vec4(0.3, 0.2, 0.5, 1.0);
uniform float speed : hint_range(0.0, 1.0) = 0.1;

// Simple pseudo-random function
float random(vec2 uv) {
    return fract(sin(dot(uv.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

// 2D Noise
float noise(vec2 uv) {
    vec2 i = floor(uv);
    vec2 f = fract(uv);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    // Smooth Interpolation
    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) + (c - a)* u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

void fragment() {
    vec2 uv = UV;
    float time = TIME * speed;
    
    // Layer 1
    float n1 = noise(uv * 3.0 + vec2(time * 0.5, time * 0.2));
    
    // Layer 2 (smaller details)
    float n2 = noise(uv * 6.0 - vec2(time * 0.3, time * 0.6));
    
    float final_noise = mix(n1, n2, 0.5);
    
    // Mix colors based on noise
    vec4 final_color = mix(bg_color, fog_color, final_noise);
    
    COLOR = final_color;
}
