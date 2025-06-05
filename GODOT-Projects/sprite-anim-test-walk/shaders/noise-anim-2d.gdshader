shader_type canvas_item;

uniform sampler2D noise_tex;
uniform float scale = 2.5;
uniform float speed = 0.3;
uniform int octaves = 4;
uniform float distortion_strength = 0.5;
uniform float opacity_threshold : hint_range(0.0, 1.0); // Animierbarer Übergangsregler

float fbm(vec2 uv) {
    float value = 0.0;
    float amplitude = 0.5;
    float frequency = 1.0;

    for (int i = 0; i < octaves; i++) {
        value += amplitude * texture(noise_tex, fract(uv * frequency)).r;
        frequency *= 2.0;
        amplitude *= 0.5;
    }

    return value;
}

void fragment() {
    vec2 uv = fract(UV * scale);

    vec2 offset = vec2(
        texture(noise_tex, fract(uv + vec2(TIME * 0.1, 0.0))).r,
        texture(noise_tex, fract(uv + vec2(0.0, TIME * 0.15))).r
    );

    uv += (offset - 0.5) * distortion_strength;

    float n = fbm(fract(uv + TIME * speed));

    // Farben
    vec3 color1 = vec3(-0.5, -0.5, -0.5);
    vec3 color2 = vec3(1.5, 1.5, 1.5);
    vec3 final_color = mix(color1, color2, n);

    // ✅ Opacity basierend auf Noise
    float opacity = smoothstep(opacity_threshold - 0.1, opacity_threshold + 0.1, n);

    COLOR = vec4(final_color, opacity);
}
