vec3 palette(float t) {
    vec3 r = vec3(0.168, 0.388, 0.338);
    vec3 g = vec3(0.858, 0.468, 0.968);
    vec3 b = vec3(0.838, 0.998, 1.058);
    vec3 a = vec3(0.638, 0.468, 1.308);
    return r + g*cos(6.28318*b*t + a);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 raw_uv = (fragCoord*2.0 - iResolution.xy) / iResolution.y;
    float raw_angle = atan(raw_uv.y/raw_uv.x);

    vec2 uv = raw_uv;
    vec3 final_col = vec3(0);
    for (float i = 0.0; i < 6.0; i++) {
        uv = fract(uv * (1.5));
        uv -= 0.5;

        float d = sin(7.0*length(uv) + iTime);
        d = abs(d);
        d = 0.2 / d;
        vec3 col = palette(length(uv) + i + iTime*0.5);
        col += palette(length(raw_uv));
        col *= d;
        final_col += col;
    }

    final_col *= (1.0 - length(raw_uv));
    final_col *= (1.0 - length(raw_uv));

    fragColor = vec4(final_col, 1.0);
}