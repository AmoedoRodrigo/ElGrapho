#version 300 es

in vec4 aVertexPosition;
in vec4 normal;
in float aVertexColor;

uniform mat4 uModelViewMatrix;
uniform mat4 uProjectionMatrix;
uniform bool magicZoom;
uniform float nodeSize;
uniform float focusedGroup;

float MAX_NODE_SIZE = 16.0;
const float PI = 3.1415926535897932384626433832795;

out vec4 vVertexColor;

vec2 rotate(vec2 v, float a) {
	float s = sin(a);
	float c = cos(a);
	mat2 m = mat2(c, -s, s, c);
	return m * v;
}

// https://mattdesl.svbtle.com/drawing-lines-is-hard
// https://github.com/mattdesl/three-line-2d/blob/master/shaders/basic.js
void main() {
  float zoomX = length(uModelViewMatrix[0]);
  float zoomY = length(uModelViewMatrix[1]);
  // vec2 standardZoomVector = normalize(vec2(1.0, 0.0));
  // vec2 zoomVector = normalize(vec2(zoomX, zoomY));
  // float zoomAngle = dot(standardZoomVector, zoomVector);
  // vec2 vec2Normal = vec2(normal.xy);
  // vec2 rotatedNormal = rotate(vec2Normal, zoomAngle);
  // vec4 newNormal = vec4(rotatedNormal.x, rotatedNormal.y, 0.0, 0.0);

  vec4 newNormal = vec4(normal.x, normal.y, 0.0, 0.0);

  if (magicZoom) {
    gl_Position = uProjectionMatrix * ((uModelViewMatrix * aVertexPosition) + newNormal);
  }
  else {
    newNormal.x = newNormal.x * zoomX * nodeSize / MAX_NODE_SIZE;
    newNormal.y = newNormal.y * zoomY * nodeSize / MAX_NODE_SIZE;
    gl_Position = uProjectionMatrix * ((uModelViewMatrix * aVertexPosition) + newNormal);
  }

  //gl_Position.z = 0.0;
  
  float alpha;

  if (focusedGroup == -1.0 || aVertexColor == focusedGroup) {
    alpha = 1.0;
    gl_Position.z = -0.3;
  }
  else {
    alpha = 0.5;
    gl_Position.z = 0.0;
  }

  float validColor = mod(aVertexColor, 8.0);

  if (validColor == 0.0) {
    vVertexColor = vec4(51.0/255.0, 102.0/255.0, 204.0/255.0, alpha); // 3366CC
  }
  else if (validColor == 1.0) {
    vVertexColor = vec4(220.0/255.0, 57.0/255.0, 18.0/255.0, alpha); // DC3912
  }
  else if (validColor == 2.0) {
    vVertexColor = vec4(255.0/255.0, 153.0/255.0, 0.0/255.0, alpha); // FF9900
  }
  else if (validColor == 3.0) {
    vVertexColor = vec4(16.0/255.0, 150.0/255.0, 24.0/255.0, alpha); // 109618
  }
  else if (validColor == 4.0) {
    vVertexColor = vec4(153.0/255.0, 0.0/255.0, 153.0/255.0, alpha); // 990099
  }
  else if (validColor == 5.0) {
    vVertexColor = vec4(59.0/255.0, 62.0/255.0, 172.0/255.0, alpha); // 3B3EAC
  }
  else if (validColor == 6.0) {
    vVertexColor = vec4(0.0/255.0, 153.0/255.0, 198.0/255.0, alpha); // 0099C6
  }
  else if (validColor == 7.0) {
    vVertexColor = vec4(221.0/255.0, 68.0/255.0, 119.0/255.0, alpha); // DD4477
  }
}