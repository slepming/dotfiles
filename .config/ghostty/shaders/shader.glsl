// INFO: This shader is a port of https://www.shadertoy.com/view/3sySRK

// INFO: Change these variables to create some variation in the animation
#define BLACK_BLEND_THRESHOLD .4 // This is controls the dim of the screen
#define COLOR_SPEED 0.1          // This controls the speed at which the colors change
#define MOVEMENT_SPEED 0.1       // This controls the speed at which the balls move

float opSmoothUnion( float d1, float d2, float k )
{
    float h = clamp( 0.5 + 0.5*(d2-d1)/k, 0.0, 1.0 );
    return mix( d2, d1, h ) - k*h*(1.0-h);
}

float sdSphere( vec3 p, float s )
{
  return length(p)-s;
} 

float map(vec3 p)
{
	float d = 2.0;
	// PERFORMANCE OPTIMIZATION: Reduced from 16 to 6 spheres.
	// This drastically reduces the GPU math load while keeping the lava feel.
	for (int i = 0; i < 6; i++) {
		float fi = float(i);
		float time = iTime * (fract(fi * 412.531 + 0.513) - 0.5) * 2.0;
		d = opSmoothUnion(
            sdSphere(p + sin(time*MOVEMENT_SPEED + fi * vec3(52.5126, 64.62744, 632.25)) * vec3(2.0, 2.0, 0.8), mix(0.5, 1.0, fract(fi * 412.531 + 0.5124))),
			d,
			0.4
		);
	}
	return d;
}

// EXTREME PERFORMANCE OPTIMIZATION: Removed calcNormal entirely.
// Calculating normals for a 3D scene requires 4 extra 'map' evaluations per pixel.
// For dark background smoke, we can fake lighting using the 2D screen space and depth.

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    
	vec3 rayOri = vec3((uv - 0.5) * vec2(iResolution.x/iResolution.y, 1.0) * 6.0, 3.0);
	vec3 rayDir = vec3(0.0, 0.0, -1.0);
	
	float depth = 0.0;
	vec3 p;
	
	// EXTREME PERFORMANCE OPTIMIZATION: Reduced max steps from 24 to 12.
	// Increased collision threshold to 0.05.
	for(int i = 0; i < 12; i++) {
		p = rayOri + rayDir * depth;
		float dist = map(p);
        depth += dist;
		if (dist < 0.05) {
			break;
		}
	}
	
    depth = min(6.0, depth);
	
	// Fake lighting (b) using just the depth, saving millions of math operations.
	float b = clamp(1.0 - (depth - 1.0) * 0.25, 0.0, 1.0);

	// Calculate grayscale intensity for black/dark gray lava
	float intensity = 0.5 + 0.5 * cos((b + iTime*COLOR_SPEED * 2.0) + (uv.x + uv.y) * 1.5);
	vec3 col = mix(vec3(0.005), vec3(0.12), intensity * (0.5 + b * 0.5));
	col *= exp( -depth * 0.15 );


	vec2 termUV = fragCoord.xy / iResolution.xy;
	vec4 terminalColor = texture(iChannel0, termUV);

	float alpha = step(length(terminalColor.rgb), BLACK_BLEND_THRESHOLD);
	vec3 blendedColor = mix(terminalColor.rgb, col.rgb, alpha);

	// Transparency control for the window manager/compositor
	float backgroundAlpha = 0.7; // 0.0 is fully transparent, 1.0 is opaque
	float finalAlpha = mix(terminalColor.a, backgroundAlpha, alpha);

	fragColor = vec4(blendedColor, finalAlpha);

}

