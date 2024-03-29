#version 330

layout(location = 0) in vec3 aPosition;
layout(location = 1) in vec3 aNormal;
layout(location = 2) in vec2 aTexCoords;
layout(location = 3) in vec3 aTangent;
layout(location = 4) in vec3 aBitangent;

out vec3 vViewSpacePosition;
out vec3 vViewSpaceNormal;
out vec2 vTexCoords;
out mat3 vTBN;

uniform mat4 uModelViewProjMatrix;
uniform mat4 uModelViewMatrix;
uniform mat4 uNormalMatrix;
uniform mat4 uModelMatrix;

void main()
{
  vViewSpacePosition = vec3(uModelViewMatrix * vec4(aPosition, 1));
  vViewSpaceNormal = normalize(vec3(uNormalMatrix * vec4(aNormal, 0)));
  vec3 T = normalize(vec3(uModelMatrix * vec4(aTangent, 0.0)));
  // vec3 B = normalize(vec3(uModelMatrix * vec4(aBitangent, 0.0)));
  vec3 N = vViewSpaceNormal;

  T = normalize(T - dot(T, N) * N);
  vec3 B = cross(N, T);
  mat3 TBN = mat3(T, B, N);

  vTexCoords = aTexCoords;
  gl_Position = uModelViewProjMatrix * vec4(aPosition, 1);
}