vec3 palette(float t) {
    vec3 col = vec3(1.0);
    if (t > 0.85) {
        col.r += 0.5*t;
    } else if (t < 0.1) {
        col.b += 5.0*t;
    }
    return col;
}

float rand(float x) {
    return fract(sin(x)*929846.0);
}

float rand(vec2 x) {
    return rand(dot(x, vec2(19420.6, 8998.0)));
}

vec2 rocket_location(float x) {
    float steepness = 4.0;
    return vec2(x, -exp(-steepness * x));
}

vec3 rocket_trail_color(float x, float y) {
    float t = 0.7 - 0.7*exp(-0.1*iTime);
    if (x > t) {
        return vec3(0.0);
    }

    float dist = length(rocket_location(x) - vec2(x, y));
    if (dist < 0.1) {
        dist *= 20.0;
        dist = 0.1 / dist;
        return vec3(1.0) * dist;
    } else {
        return vec3(0.0);
    }
}

vec3 rocket_burn_color(float x, float y) {
    float t = 0.7 - 0.7*exp(-0.1*iTime);
    float flicker_rate = 50.0;
    vec2 rocket_location = rocket_location(t);
    float distance = length(vec2(x, y) - rocket_location);
    float point_1 = rand(floor(iTime*flicker_rate));
    float point_2 = rand(floor(iTime*flicker_rate)+1.0);
    float interpolated_point = point_1 + (point_2 - point_1)*fract(iTime*flicker_rate);
    float flicker = 0.01 + (interpolated_point * 0.003);
    return vec3(1.3, 1.1, 1.0) * (flicker / distance);
}

vec3 star_color(vec2 raw_uv) {
    vec2 f = fract(16.0*raw_uv);
    vec2 i = floor(16.0*raw_uv);
    float hash = i.x*10000.0 + i.y;
    vec2 coords = vec2(rand(i), rand(i)) * 0.8 + 0.1;
    float dist = length(f - coords);
    float phase = rand(hash+2.0) * 5.0;
    float mul = rand(hash+1.0) * 2.0;
    float div = rand(hash+2.0) * 2.0 + 1.0;
    float twinkle = (sin(iTime * mul + phase) + 1.0) / div;
    float size = rand(hash) * 0.01 * twinkle;
    return palette(rand(hash+8.0)) * (size / dist) * (raw_uv.y + 1.0);
}

vec3 sky_color(float x, float y) {
    return vec3(0.0, -y-0.8, -y-0.3);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord ) {
    vec2 raw_uv = (fragCoord*2.0 - iResolution.xy) / iResolution.y;
    float raw_angle = atan(raw_uv.y/raw_uv.x);
    vec3 col = max(
            max(star_color(raw_uv), rocket_trail_color(raw_uv.x, raw_uv.y)),
            max(rocket_burn_color(raw_uv.x, raw_uv.y), sky_color(raw_uv.x, raw_uv.y)));
    fragColor = vec4(col, 1.0);
}