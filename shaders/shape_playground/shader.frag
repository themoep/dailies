// http://thebookofshaders.com/edit.php?log=170126093114

// Author: themoep
// Title: shaping playground

// this playground shall help to play with shaping functions, the first
// lesson fromthe book of shaders: http://thebookofshaders.com/05/
// scroll down to the smiley to get started right away

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.141567

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

/* 
 * functions by Iñigo Quiles
 * see http://www.iquilezles.org/www/articles/functions/functions.htm
 */
float almostIdentity( float x, float m, float n ) {
    if( x>m ) return x;
    float a = 2.0*n - m;
    float b = 2.0*m - 3.0*n;
    float t = x/m;
    return (a*t + b)*t*t + n;
}
float impulse( float k, float x ) {
    float h = k*x;
    return h*exp(1.0-h);
}
float cubicPulse( float c, float w, float x ) {
    x = abs(x - c);
    if( x>w ) return 0.0;
    x /= w;
    return 1.0 - x*x*(3.0-2.0*x);
}
float expStep( float x, float k, float n ) {
    return exp( -k*pow(x,n) );
}
float parabola( float x, float k ) {
    return pow( 4.0*x*(1.0-x), k );
}
float pcurve( float x, float a, float b ) {
    float k = pow(a+b,a+b) / (pow(a,a)*pow(b,b));
    return k * pow( x, a ) * pow( 1.0-x, b );
}


/*
 * INTERESSTING STUFF HAPPENS HERE :)
 * 
 * the function to shape takes a float and shapes it to a different float
 * last uncommented r = decides what is drawn
 */
float shape(float x) {
    // when drawing upper row, we get values bigger than 1.0 as input
    // to make sure we stay within bounds, uncomment this line
    //x = clamp(x, -1., 1.);
    
    float r = x;
    r = smoothstep(0.1,0.9,x); // default 0.1, 0.9
    
    // functions by Iñigo Quiles
    //r = almostIdentity(x, .2, .5);
	r = impulse(5., x);
	r = cubicPulse(0.5, 0.2, x);
	//r = expStep(x, 5., 5.);
	//r = parabola(x, 5.);
	//r = pcurve(x, 3., 0.5);        
        
    // function by Kynd
    // https://www.flickr.com/photos/kynd/9546075099/
    //r = 1.0 - pow(abs(x), 0.5); // default 1.0, 0.5
    //r = pow(cos(PI*x/2.0),0.5); // default 2.0, 0.5
    //r = 1.0 - pow(abs(sin(PI*x/2.0)), 0.5); // default 1.0 2.0, 0.5
    //r = pow(min(cos(PI*x/2.0), 1.0-abs(x)),0.5); // default 2.0, 1.0, 0.5
    //r = 1.0 - pow(max(0.0, abs(x)*2.0-1.0),0.5); // default 1.0, 0.0, 2.0, 1.0, 0.5
    
    // functions by 
    return r;
}

/* plot function from the book of shaders */
float plot(vec2 st, float pct){
  return  smoothstep( pct-0.02, pct, st.y) - 
          smoothstep( pct, pct+0.02, st.y);
}

void main() {
    vec3 color = vec3(1.);
    
    // adjust y to go from 0.0-1.0 and x accordingly to ratio
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;
	
    // upper left corner, draw circle
    if (st.y > .5 && st.x < .5) {
        // adjust coordinates to go from -1 to 1
        st.y = (st.y-.75)*4.;
        st.x = (st.x-.25)*4.;
        
        float d = distance(vec2(0.), st);
        float y = shape(d);
        
        color = vec3(y);
    }
    // upper right corner, draw circle segment
    else if(st.y > .5 && st.x > .5) {
        // adjust coordinates to go from 0 to 1
        st = (st-.5)*2.;
        float d = distance(vec2(0.), st);
        float y = shape(d);
        color = vec3(y);
    }
    // lower part
    else if(st.y < .5) {
        // adjust coordinates so x goes from -1 to 1 and y from 0 to 1
    	st.y *= 2.;
		st.x = st.x*2.-1.;
    	float y = shape(st.x);
    	color = vec3(y);
        // plot gradient & green line
    	float pct = plot(st,y);
        color = (1.0-pct)*color+pct*vec3(0.0,1.0,0.0);
    }
    
    gl_FragColor = vec4(color,1.0);
}
