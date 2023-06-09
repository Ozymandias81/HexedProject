// https://www.shadertoy.com/view/4sSSzz

// Set this to 0 to disable the chromatic abberation - Nash
#define DO_CHROMO 1

// Fisheye effect strength - higher number means more intense effect
#define FISHEYE_EFFECT_STRENGTH 0.0904

void main(void)
{
	vec2 texSize = textureSize(InputTexture, 0);
	vec2 uv = TexCoord.xy;
	float aspectRatio = texSize.x / texSize.y;
	float strength = FISHEYE_EFFECT_STRENGTH;

	vec2 intensity = vec2(strength * aspectRatio, strength * aspectRatio);

	vec2 coords = uv;
	coords = (coords - 0.5) * 2.0;

	vec2 realCoordOffs;
	realCoordOffs.x = (1.0 - coords.y * coords.y) * intensity.y * (coords.x);
	realCoordOffs.y = (1.0 - coords.x * coords.x) * intensity.x * (coords.y);

	vec4 color = texture(InputTexture, uv - realCoordOffs);

#if DO_CHROMO
	float chromo_x = 0.044;
	float chromo_y = 0.044;
	FragColor = vec4
	(
		texture(InputTexture, vec2((uv.x - realCoordOffs.x) - chromo_x * 0.016, (uv.y - realCoordOffs.y) - chromo_y * 0.009)).r,
		texture(InputTexture, vec2((uv.x - realCoordOffs.x) + chromo_x * 0.0125, (uv.y - realCoordOffs.y) - chromo_y * 0.004)).g,
		texture(InputTexture, vec2((uv.x - realCoordOffs.x) - chromo_x * 0.0045, (uv.y - realCoordOffs.y) + chromo_y * 0.0085)).b,
		1.0
	);
#else
	FragColor = vec4(color);
#endif
}