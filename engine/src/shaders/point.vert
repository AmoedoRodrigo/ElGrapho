//#version 300 es

attribute vec4 aVertexPosition;
// TODO: this should be an int
attribute float aVertexColor;

uniform mat4 uModelViewMatrix;
uniform mat4 uProjectionMatrix;
uniform bool magicZoom;
uniform float nodeSize;
// TODO: focusedGroup and group should change to int
uniform float focusedGroup;

varying vec4 vVertexColor;

// const PALETTE_HEX = [
//   '3366CC',
//   'DC3912',
//   'FF9900',
//   '109618',
//   '990099',
//   '3B3EAC',
//   '0099C6',
//   'DD4477',
//   '66AA00',
//   'B82E2E',
//   '316395',
//   '994499',
//   '22AA99',
//   'AAAA11',
//   '6633CC',
//   'E67300',
//   '8B0707',
//   '329262',
//   '5574A6',
//   '3B3EAC'
// ];

void main() {
  gl_Position = uProjectionMatrix * uModelViewMatrix * aVertexPosition;

  if (magicZoom) {
    gl_PointSize = nodeSize; 
  }
  else {
    gl_PointSize = nodeSize * min(length(uModelViewMatrix[0]), length(uModelViewMatrix[1]));
  }

  float validColor = mod(aVertexColor, 8.0);

  // gl_VertexID

  bool isGray;

  if (focusedGroup == -1.0 || aVertexColor == focusedGroup) {
    isGray = false;
    // must be between -1 and 1
    gl_Position.z = -0.5;
  }
  else {
    isGray = true;
    gl_Position.z = -0.2;
  }

  if (isGray) {
    vVertexColor = vec4(220.0/255.0, 220.0/255.0, 220.0/255.0, 1.0); 
  }
  else if (validColor == 0.0) {
    vVertexColor = vec4(51.0/255.0, 102.0/255.0, 204.0/255.0, 1.0); // 3366CC
  }
  else if (validColor == 1.0) {
    vVertexColor = vec4(220.0/255.0, 57.0/255.0, 18.0/255.0, 1.0); // DC3912
  }
  else if (validColor == 2.0) {
    vVertexColor = vec4(255.0/255.0, 153.0/255.0, 0.0/255.0, 1.0); // FF9900
  }
  else if (validColor == 3.0) {
    vVertexColor = vec4(16.0/255.0, 150.0/255.0, 24.0/255.0, 1.0); // 109618
  }
  else if (validColor == 4.0) {
    vVertexColor = vec4(153.0/255.0, 0.0/255.0, 153.0/255.0, 1.0); // 990099
  }
  else if (validColor == 5.0) {
    vVertexColor = vec4(59.0/255.0, 62.0/255.0, 172.0/255.0, 1.0); // 3B3EAC
  }
  else if (validColor == 6.0) {
    vVertexColor = vec4(0.0/255.0, 153.0/255.0, 198.0/255.0, 1.0); // 0099C6
  }
  else if (validColor == 7.0) {
    vVertexColor = vec4(221.0/255.0, 68.0/255.0, 119.0/255.0, 1.0); // DD4477
  }

}