#ifdef GL_ES
precision mediump float;
#endif

#define PROCESSING_COLOR_SHADER

uniform vec2 u_resolution;
uniform vec3 u_mouse;
uniform float u_time;

uniform int numTimes;
uniform float[20] times;

void main() {
    vec2 st = gl_FragCoord.st/u_resolution;

    float t = numTimes/20.0;
    float col = numTimes % 2;

    int i;
    for(i = 0; i < numTimes; i++) {
        float d = distance(st,vec2(.5));
        if (d < u_time-times[i] || d > u_time+0.01-times[i]) {
            col = 1.0-col;
        }
    }
    
    gl_FragColor = vec4(vec3(col),1.0);
}
