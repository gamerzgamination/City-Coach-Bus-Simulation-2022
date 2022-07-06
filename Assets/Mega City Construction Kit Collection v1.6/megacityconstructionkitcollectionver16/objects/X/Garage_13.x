xof 0303txt 0032
template XSkinMeshHeader {
 <3cf169ce-ff7c-44ab-93c0-f78f62d172e2>
 WORD nMaxSkinWeightsPerVertex;
 WORD nMaxSkinWeightsPerFace;
 WORD nBones;
}

template VertexDuplicationIndices {
 <b8d65549-d7c9-4995-89cf-53a9a8b031e3>
 DWORD nIndices;
 DWORD nOriginalVertices;
 array DWORD indices[nIndices];
}

template SkinWeights {
 <6f0d123b-bad2-4167-a0d0-80224f25fabb>
 STRING transformNodeName;
 DWORD nWeights;
 array DWORD vertexIndices[nWeights];
 array FLOAT weights[nWeights];
 Matrix4x4 matrixOffset;
}

template FVFData {
 <b6e70a0e-8ef9-4e83-94ad-ecc8b0c04897>
 DWORD dwFVF;
 DWORD nDWords;
 array DWORD data[nDWords];
}

template EffectInstance {
 <e331f7e4-0559-4cc2-8e99-1cec1657928f>
 STRING EffectFilename;
 [...]
}

template EffectParamFloats {
 <3014b9a0-62f5-478c-9b86-e4ac9f4e418b>
 STRING ParamName;
 DWORD nFloats;
 array FLOAT Floats[nFloats];
}

template EffectParamString {
 <1dbc4c88-94c1-46ee-9076-2c28818c9481>
 STRING ParamName;
 STRING Value;
}

template EffectParamDWord {
 <e13963bc-ae51-4c5d-b00f-cfa3a9d97ce5>
 STRING ParamName;
 DWORD Value;
}


Material skyscrapers {
 1.000000;1.000000;1.000000;1.000000;;
 3.200000;
 0.000000;0.000000;0.000000;;
 0.000000;0.000000;0.000000;;

 TextureFilename {
  "Skyscrp.tga";
 }
}

Material buildz1 {
 1.000000;1.000000;1.000000;1.000000;;
 3.200000;
 0.000000;0.000000;0.000000;;
 0.000000;0.000000;0.000000;;

 TextureFilename {
  "buildz1.tga";
 }
}

Material buildz3 {
 1.000000;1.000000;1.000000;1.000000;;
 3.200000;
 0.000000;0.000000;0.000000;;
 0.000000;0.000000;0.000000;;

 TextureFilename {
  "buildz3.tga";
 }
}

Material buildz4 {
 1.000000;1.000000;1.000000;1.000000;;
 3.200000;
 0.000000;0.000000;0.000000;;
 0.000000;0.000000;0.000000;;

 TextureFilename {
  "buildz4.tga";
 }
}

Material buildz5 {
 1.000000;1.000000;1.000000;1.000000;;
 3.200000;
 0.000000;0.000000;0.000000;;
 0.000000;0.000000;0.000000;;

 TextureFilename {
  "buildz5.tga";
 }
}

Material buildz6 {
 1.000000;1.000000;1.000000;1.000000;;
 3.200000;
 0.000000;0.000000;0.000000;;
 0.000000;0.000000;0.000000;;

 TextureFilename {
  "buildz6.tga";
 }
}

Material buildz2 {
 1.000000;1.000000;1.000000;1.000000;;
 3.200000;
 0.000000;0.000000;0.000000;;
 0.000000;0.000000;0.000000;;

 TextureFilename {
  "buildz2.tga";
 }
}

Material roads {
 1.000000;1.000000;1.000000;1.000000;;
 3.200000;
 0.000000;0.000000;0.000000;;
 0.000000;0.000000;0.000000;;

 TextureFilename {
  "roads.tga";
 }
}

Material roads-2 {
 1.000000;1.000000;1.000000;1.000000;;
 3.200000;
 0.000000;0.000000;0.000000;;
 0.000000;0.000000;0.000000;;

 TextureFilename {
  "roads2.tga";
 }
}

Material tree-01 {
 1.000000;1.000000;1.000000;1.000000;;
 3.200000;
 0.000000;0.000000;0.000000;;
 0.000000;0.000000;0.000000;;

 TextureFilename {
  "trees-02.tga";
 }
}

Frame Garage_13 {
 

 FrameTransformMatrix {
  1.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,-1.000000,0.000000,0.000000,1.000000,-0.000000,0.000000,0.000000,-12.670539,12.491668,1.000000;;
 }

 Frame {
  

  FrameTransformMatrix {
   1.000000,0.000000,0.000000,0.000000,0.000000,1.000000,0.000000,0.000000,0.000000,0.000000,1.000000,0.000000,0.000000,-0.000000,0.000000,1.000000;;
  }

  Mesh  {
   30;
   -24.042938;-4.719937;6.510965;,
   24.042950;-4.719927;6.510965;,
   24.042950;4.719958;6.510965;,
   24.042950;4.719958;6.510965;,
   -24.042938;4.719949;6.510965;,
   -24.042938;-4.719937;6.510965;,
   -24.042946;4.719950;-0.000000;,
   -24.042944;-4.719937;-0.000000;,
   -24.042938;-4.719937;6.510965;,
   -24.042938;-4.719937;6.510965;,
   -24.042938;4.719949;6.510965;,
   -24.042946;4.719950;-0.000000;,
   24.042950;-4.719927;6.510965;,
   -24.042938;-4.719937;6.510965;,
   -24.042944;-4.719937;-0.000000;,
   -24.042944;-4.719937;-0.000000;,
   24.042950;-4.719927;-0.000000;,
   24.042950;-4.719927;6.510965;,
   24.042950;-4.719927;-0.000000;,
   24.042950;4.719959;0.000000;,
   24.042950;4.719958;6.510965;,
   24.042950;4.719958;6.510965;,
   24.042950;-4.719927;6.510965;,
   24.042950;-4.719927;-0.000000;,
   -24.042938;4.719949;6.510965;,
   24.042950;4.719958;6.510965;,
   24.042950;4.719959;0.000000;,
   24.042950;4.719959;0.000000;,
   -24.042946;4.719950;-0.000000;,
   -24.042938;4.719949;6.510965;;
   10;
   3;0,1,2;,
   3;3,4,5;,
   3;6,7,8;,
   3;9,10,11;,
   3;12,13,14;,
   3;15,16,17;,
   3;18,19,20;,
   3;21,22,23;,
   3;24,25,26;,
   3;27,28,29;;

   MeshNormals  {
    30;
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    -1.000000;-0.000000;0.000001;,
    -1.000000;-0.000000;0.000001;,
    -1.000000;-0.000000;0.000001;,
    -1.000000;-0.000000;0.000001;,
    -1.000000;0.000000;0.000001;,
    -1.000000;-0.000000;0.000001;,
    0.000000;-1.000000;-0.000000;,
    0.000000;-1.000000;-0.000000;,
    0.000000;-1.000000;-0.000000;,
    0.000000;-1.000000;-0.000000;,
    0.000000;-1.000000;0.000000;,
    0.000000;-1.000000;-0.000000;,
    1.000000;0.000000;0.000000;,
    1.000000;0.000000;0.000000;,
    1.000000;0.000000;0.000000;,
    1.000000;0.000000;0.000000;,
    1.000000;0.000000;0.000000;,
    1.000000;0.000000;0.000000;,
    -0.000000;1.000000;0.000000;,
    -0.000000;1.000000;0.000000;,
    -0.000000;1.000000;0.000000;,
    -0.000000;1.000000;0.000000;,
    -0.000000;1.000000;0.000000;,
    -0.000000;1.000000;0.000000;;
    10;
    3;0,1,2;,
    3;3,4,5;,
    3;6,7,8;,
    3;9,10,11;,
    3;12,13,14;,
    3;15,16,17;,
    3;18,19,20;,
    3;21,22,23;,
    3;24,25,26;,
    3;27,28,29;;
   }

   MeshMaterialList  {
    1;
    10;
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0;
    { buildz6 }
   }

   MeshTextureCoords  {
    30;
    0.728694;0.433081;,
    0.997691;0.432970;,
    0.997691;0.387215;,
    0.997691;0.387215;,
    0.728694;0.387311;,
    0.728694;0.433081;,
    0.474595;0.266466;,
    0.693043;0.265919;,
    0.693043;0.133734;,
    0.693043;0.133734;,
    0.474595;0.134280;,
    0.474595;0.266466;,
    0.997490;0.133734;,
    0.002990;0.133734;,
    0.002990;0.265919;,
    0.002990;0.265919;,
    0.997490;0.265919;,
    0.997490;0.133734;,
    0.474595;0.266466;,
    0.693043;0.265919;,
    0.693043;0.133734;,
    0.693043;0.133734;,
    0.474595;0.134280;,
    0.474595;0.266466;,
    0.997490;0.133734;,
    0.002990;0.133734;,
    0.002990;0.265919;,
    0.002990;0.265919;,
    0.997490;0.265919;,
    0.997490;0.133734;;
   }
  }
 }
}