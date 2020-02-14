uniform float time;

float saturation = 0.8;
float value = 0.9;

// All components are in the range [0...1], including hue.
vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

vec4 effect(vec4 col, Image tex, vec2 tex_pos, vec2 screen_pos)
{
  vec4 tex_col = Texel(tex, tex_pos);
  if (tex_col.a < 0.8) {
    return vec4(0, 0, 0, 0);
  }

  vec3 rgb = hsv2rgb(
    vec3(
      (sin(time / 1.5 - screen_pos.x / love_ScreenSize.x) + 1) / 2,
      saturation,
      value
    )
  );

  return vec4(
    rgb.r,
    rgb.g,
    rgb.b,
    1
  );
}
