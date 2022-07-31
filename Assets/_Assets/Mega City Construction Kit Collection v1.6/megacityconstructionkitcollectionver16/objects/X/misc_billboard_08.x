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

Frame misc_billboard_08 {
 

 FrameTransformMatrix {
  1.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,-1.000000,0.000000,0.000000,1.000000,-0.000000,0.000000,-0.004512,-12.670539,12.751022,1.000000;;
 }

 Frame {
  

  FrameTransformMatrix {
   1.000000,0.000000,0.000000,0.000000,0.000000,1.000000,0.000000,0.000000,0.000000,0.000000,1.000000,0.000000,0.000000,-0.000000,0.000000,1.000000;;
  }

  Mesh  {
   66;
   -0.115892;4.687503;5.590312;,
   -0.115890;-4.687498;5.590312;,
   -0.115892;4.687503;9.432038;,
   -0.115890;-4.687498;9.432038;,
   -0.115892;4.687503;9.432038;,
   -0.115890;-4.687498;5.590312;,
   0.041828;-4.687500;5.590312;,
   0.041826;4.687503;5.590312;,
   0.041826;4.687503;9.432038;,
   0.041826;4.687503;9.432038;,
   0.041828;-4.687500;9.432038;,
   0.041828;-4.687500;5.590312;,
   -0.115890;-4.687498;5.590312;,
   -0.115892;4.687503;5.590312;,
   0.041826;4.687503;5.590312;,
   0.041826;4.687503;5.590312;,
   0.041828;-4.687500;5.590312;,
   -0.115890;-4.687498;5.590312;,
   -0.115892;4.687503;5.590312;,
   -0.115892;4.687503;9.432038;,
   0.041826;4.687503;9.432038;,
   0.041826;4.687503;9.432038;,
   0.041826;4.687503;5.590312;,
   -0.115892;4.687503;5.590312;,
   -0.115892;4.687503;9.432038;,
   -0.115890;-4.687498;9.432038;,
   0.041828;-4.687500;9.432038;,
   0.041828;-4.687500;9.432038;,
   0.041826;4.687503;9.432038;,
   -0.115892;4.687503;9.432038;,
   -0.115890;-4.687498;9.432038;,
   -0.115890;-4.687498;5.590312;,
   0.041828;-4.687500;5.590312;,
   0.041828;-4.687500;5.590312;,
   0.041828;-4.687500;9.432038;,
   -0.115890;-4.687498;9.432038;,
   0.275948;-0.479289;5.635587;,
   -0.361363;-0.490462;5.635587;,
   -0.363955;-0.501634;0.013644;,
   -0.363955;-0.501634;0.013644;,
   0.275945;-0.479289;0.013644;,
   0.275948;-0.479289;5.635587;,
   0.253602;0.160607;5.635587;,
   0.275948;-0.479289;5.635587;,
   0.275945;-0.479289;0.013644;,
   0.275945;-0.479289;0.013644;,
   0.253600;0.160607;0.013644;,
   0.253602;0.160607;5.635587;,
   -0.383706;0.149435;5.635587;,
   0.253602;0.160607;5.635587;,
   0.253600;0.160607;0.013644;,
   0.253600;0.160607;0.013644;,
   -0.386298;0.138263;0.013644;,
   -0.383706;0.149435;5.635587;,
   -0.361363;-0.490462;5.635587;,
   -0.383706;0.149435;5.635587;,
   -0.386298;0.138263;0.013644;,
   -0.386298;0.138263;0.013644;,
   -0.363955;-0.501634;0.013644;,
   -0.361363;-0.490462;5.635587;,
   -0.383706;0.149435;5.635587;,
   -0.361363;-0.490462;5.635587;,
   0.275948;-0.479289;5.635587;,
   0.275948;-0.479289;5.635587;,
   0.253602;0.160607;5.635587;,
   -0.383706;0.149435;5.635587;;
   22;
   3;0,1,2;,
   3;3,4,5;,
   3;6,7,8;,
   3;9,10,11;,
   3;12,13,14;,
   3;15,16,17;,
   3;18,19,20;,
   3;21,22,23;,
   3;24,25,26;,
   3;27,28,29;,
   3;30,31,32;,
   3;33,34,35;,
   3;36,37,38;,
   3;39,40,41;,
   3;42,43,44;,
   3;45,46,47;,
   3;48,49,50;,
   3;51,52,53;,
   3;54,55,56;,
   3;57,58,59;,
   3;60,61,62;,
   3;63,64,65;;

   MeshNormals  {
    66;
    -1.000000;-0.000000;0.000000;,
    -1.000000;-0.000000;0.000000;,
    -1.000000;-0.000000;0.000000;,
    -1.000000;-0.000000;0.000000;,
    -1.000000;-0.000000;0.000000;,
    -1.000000;-0.000000;0.000000;,
    1.000000;0.000000;0.000000;,
    1.000000;0.000000;0.000000;,
    1.000000;0.000000;0.000000;,
    1.000000;0.000000;0.000000;,
    1.000000;0.000000;0.000000;,
    1.000000;0.000000;0.000000;,
    0.000000;0.000000;-1.000000;,
    0.000000;0.000000;-1.000000;,
    0.000000;0.000000;-1.000000;,
    0.000000;0.000000;-1.000000;,
    0.000000;0.000000;-1.000000;,
    0.000000;0.000000;-1.000000;,
    0.000000;1.000000;0.000000;,
    0.000000;1.000000;0.000000;,
    0.000000;1.000000;0.000000;,
    0.000000;1.000000;0.000000;,
    0.000000;1.000000;0.000000;,
    0.000000;1.000000;0.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    -0.000015;-1.000000;0.000000;,
    -0.000015;-1.000000;0.000000;,
    -0.000015;-1.000000;0.000000;,
    -0.000015;-1.000000;0.000000;,
    -0.000015;-1.000000;0.000000;,
    -0.000015;-1.000000;0.000000;,
    0.018782;-0.999822;0.001836;,
    0.017527;-0.999844;0.001979;,
    0.033649;-0.999434;0.000142;,
    0.033649;-0.999434;0.000142;,
    0.034897;-0.999391;-0.000000;,
    0.018782;-0.999822;0.001836;,
    0.702778;0.024541;0.710986;,
    0.710596;0.024814;0.703163;,
    0.999391;0.034899;-0.000000;,
    0.999391;0.034899;-0.000000;,
    0.999391;0.034899;-0.000000;,
    0.702778;0.024541;0.710986;,
    -0.018781;0.999824;-0.000142;,
    -0.017528;0.999846;0.000000;,
    -0.033649;0.999432;-0.001828;,
    -0.033649;0.999432;-0.001828;,
    -0.034897;0.999389;-0.001970;,
    -0.018781;0.999824;-0.000142;,
    -0.999391;-0.034895;0.000530;,
    -0.999391;-0.034895;0.000530;,
    -0.999391;-0.034895;0.000530;,
    -0.999391;-0.034895;0.000530;,
    -0.999391;-0.034895;0.000530;,
    -0.999391;-0.034895;0.000530;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.710596;0.024814;0.703163;,
    0.710596;0.024814;0.703163;,
    0.702778;0.024541;0.710986;,
    0.000000;0.000000;1.000000;;
    22;
    3;0,1,2;,
    3;3,4,5;,
    3;6,7,8;,
    3;9,10,11;,
    3;12,13,14;,
    3;15,16,17;,
    3;18,19,20;,
    3;21,22,23;,
    3;24,25,26;,
    3;27,28,29;,
    3;30,31,32;,
    3;33,34,35;,
    3;36,37,38;,
    3;39,40,41;,
    3;42,43,44;,
    3;45,46,47;,
    3;48,49,50;,
    3;51,52,53;,
    3;54,55,56;,
    3;57,58,59;,
    3;60,61,62;,
    3;63,64,65;;
   }

   MeshMaterialList  {
    1;
    22;
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
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
    { roads }
   }

   MeshTextureCoords  {
    66;
    0.459033;0.331149;,
    0.731850;0.331149;,
    0.459033;0.195514;,
    0.731850;0.195514;,
    0.459033;0.195514;,
    0.731850;0.331149;,
    0.459033;0.331149;,
    0.731850;0.331149;,
    0.731850;0.195514;,
    0.731850;0.195514;,
    0.459033;0.195514;,
    0.459033;0.331149;,
    0.459033;0.331149;,
    0.731850;0.331149;,
    0.731850;0.331149;,
    0.731850;0.331149;,
    0.459033;0.331149;,
    0.459033;0.331149;,
    0.731850;0.331149;,
    0.731850;0.195514;,
    0.731850;0.195514;,
    0.731850;0.195514;,
    0.731850;0.331149;,
    0.731850;0.331149;,
    0.731850;0.195514;,
    0.459033;0.195514;,
    0.459033;0.195514;,
    0.459033;0.195514;,
    0.731850;0.195514;,
    0.731850;0.195514;,
    0.459033;0.195514;,
    0.459033;0.331149;,
    0.459033;0.331149;,
    0.459033;0.331149;,
    0.459033;0.195514;,
    0.459033;0.195514;,
    0.409176;0.872322;,
    0.409176;0.916838;,
    0.998799;0.916838;,
    0.998799;0.916838;,
    0.998799;0.872322;,
    0.409176;0.872322;,
    0.409176;0.872322;,
    0.409176;0.916838;,
    0.998799;0.916838;,
    0.998799;0.916838;,
    0.998799;0.872322;,
    0.409176;0.872322;,
    0.409176;0.872322;,
    0.409176;0.916838;,
    0.998799;0.916838;,
    0.998799;0.916838;,
    0.998799;0.872322;,
    0.409176;0.872322;,
    0.409176;0.872322;,
    0.409176;0.916838;,
    0.998799;0.916838;,
    0.998799;0.916838;,
    0.998799;0.872322;,
    0.409176;0.872322;,
    0.409176;0.872322;,
    0.409176;0.916838;,
    0.409176;0.916838;,
    0.409176;0.916838;,
    0.409176;0.872322;,
    0.409176;0.872322;;
   }
  }
 }
}