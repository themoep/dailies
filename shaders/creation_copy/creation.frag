//https://www.shadertoy.com/view/XsXXDn


// http://www.pouet.net/prod.php?which=57245

#define t iGlobalTime
#define r iResolution.xy

void mainImage( out vec4 fragColor, in vec2 fragCoord ){
	vec3 c;
	float l;
    float z=t;

    // for each "color" channel
	for(int i=0;i<3;i++) {
		
        // p is relative position from 0 to 1
        vec2 p = fragCoord.xy/r;
		vec2 uv = p;
        
        // move p to be  -0.5 to 0.5 so the center is at (0,0)
		p-=.5;
        
        // adjust p.x to be streched to adjust for resolution ratio
		p.x*=r.x/r.y;
        
        // advance z for each loop to shift colors
		z+=.07;
        
        // calculate the distance from the center (because we moved p (0,0) to the center)
		l=length(p);
        
        
        c[i] = (sin(z)+1.);
        continue;
        
        vec2 tmp1 = p/l*(sin(z)+1.)*abs(sin(l*9.-z*2.));
        
		uv = uv + tmp1;
		c[i]=.01/length(abs(mod(uv,1.)-.5));
	}
    
	fragColor=vec4(c/l,t);
}
