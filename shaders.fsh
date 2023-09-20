void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = (fragCoord*2.0 - iResolution.xy) / iResolution.y;

    // Time varying pixel color
    // vec3 col = 0.5 + 0.5*cos(iTime+uv.xyx+vec3(0,2,4));

    // Output to screen
    float raw_angle = atan(uv.y/uv.x);
    float angle = raw_angle;
    angle = sin(0.5*angle);
    angle = abs(angle);
    angle += 0.5 * sin(iTime);
    angle = abs(angle);
    angle *= 2.0;

    float d = length(uv);
    d = sin(8.0 * d + iTime);
    d = abs(d);
    d *= abs(sin(raw_angle));
    //d = smoothstep(0.0, 1.0, d);
    //d = 0.5 - d;
    d = 0.1 / d;

    angle *= d;

    fragColor = vec4(d, d, 2.0*max(d, angle), 1.0);
}