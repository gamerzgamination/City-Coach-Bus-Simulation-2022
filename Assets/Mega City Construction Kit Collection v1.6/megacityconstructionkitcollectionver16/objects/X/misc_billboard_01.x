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

Frame misc_billboard_01 {
 

 FrameTransformMatrix {
  1.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,-1.000000,0.000000,0.000000,1.000000,-0.000000,0.000000,-0.004512,-12.670539,12.751022,1.000000;;
 }

 Frame {
  

  FrameTransformMatrix {
   1.000000,0.000000,0.000000,0.000000,0.000000,1.000000,0.000000,0.000000,0.000000,0.000000,1.000000,0.000000,0.000000,-0.000000,0.000000,1.000000;;
  }

  Mesh  {
   60;
   0.808084;-0.889284;6.454972;,
   0.167796;-0.889284;6.454972;,
   0.167796;-0.889284;0.052097;,
   0.167796;-0.889284;0.052097;,
   0.808084;-0.889284;0.052097;,
   0.808084;-0.889284;6.454972;,
   0.808084;-0.248996;6.454972;,
   0.808084;-0.889284;6.454972;,
   0.808084;-0.889284;0.052097;,
   0.808084;-0.889284;0.052097;,
   0.808084;-0.248996;0.052097;,
   0.808084;-0.248996;6.454972;,
   0.167797;-0.248996;6.454972;,
   0.808084;-0.248996;6.454972;,
   0.808084;-0.248996;0.052097;,
   0.808084;-0.248996;0.052097;,
   0.167797;-0.248996;0.052097;,
   0.167797;-0.248996;6.454972;,
   0.167796;-0.889284;6.454972;,
   0.167797;-0.248996;6.454972;,
   0.167797;-0.248996;0.052097;,
   0.167797;-0.248996;0.052097;,
   0.167796;-0.889284;0.052097;,
   0.167796;-0.889284;6.454972;,
   -4.489121;-0.821036;6.278137;,
   2.886992;-5.292874;6.278137;,
   2.886992;-5.292874;10.120445;,
   2.886992;-5.292874;10.120445;,
   -4.489121;-0.821036;10.120445;,
   -4.489121;-0.821036;6.278137;,
   2.886992;-5.292874;6.278137;,
   2.886992;4.082122;6.278137;,
   2.886992;4.082122;10.120445;,
   2.886992;4.082122;10.120445;,
   2.886992;-5.292874;10.120445;,
   2.886992;-5.292874;6.278137;,
   2.886992;4.082122;6.278137;,
   -4.489121;-0.821036;6.278137;,
   -4.489121;-0.821036;10.120445;,
   -4.489121;-0.821036;10.120445;,
   2.886992;4.082122;10.120445;,
   2.886992;4.082122;6.278137;,
   -4.489121;-0.821036;10.120445;,
   2.886992;-5.292874;10.120445;,
   0.497890;-0.583877;10.236843;,
   0.497890;-0.583877;10.236843;,
   2.886992;-5.292874;10.120445;,
   2.886992;4.082122;10.120445;,
   -4.489121;-0.821036;10.120445;,
   0.497890;-0.583877;10.236843;,
   2.886992;4.082122;10.120445;,
   2.886992;-5.292874;6.278137;,
   -4.489121;-0.821036;6.278137;,
   0.497890;-0.583877;6.393951;,
   2.886992;-5.292874;6.278137;,
   0.497890;-0.583877;6.393951;,
   2.886992;4.082122;6.278137;,
   0.497890;-0.583877;6.393951;,
   -4.489121;-0.821036;6.278137;,
   2.886992;4.082122;6.278137;;
   20;
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
   3;57,58,59;;

   MeshNormals  {
    60;
    -0.000000;-1.000000;0.000000;,
    -0.000000;-1.000000;0.000000;,
    -0.000000;-1.000000;0.000000;,
    -0.000000;-1.000000;0.000000;,
    -0.000000;-1.000000;0.000000;,
    -0.000000;-1.000000;0.000000;,
    1.000000;0.000000;0.000000;,
    1.000000;0.000000;0.000000;,
    1.000000;0.000000;0.000000;,
    1.000000;0.000000;0.000000;,
    1.000000;0.000000;0.000000;,
    1.000000;0.000000;0.000000;,
    0.000000;1.000000;0.000000;,
    0.000000;1.000000;0.000000;,
    0.000000;1.000000;0.000000;,
    0.000000;1.000000;0.000000;,
    0.000000;1.000000;0.000000;,
    0.000000;1.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -0.518426;-0.855122;0.000000;,
    -0.518426;-0.855122;0.000000;,
    -0.518426;-0.855122;0.000000;,
    -0.518426;-0.855122;0.000000;,
    -0.518426;-0.855122;0.000000;,
    -0.518426;-0.855122;0.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    -0.553586;0.832792;0.000000;,
    -0.553586;0.832792;0.000000;,
    -0.553586;0.832792;0.000000;,
    -0.553586;0.832792;0.000000;,
    -0.553586;0.832792;0.000000;,
    -0.553586;0.832792;0.000000;,
    -0.023302;-0.000674;0.999728;,
    0.010560;-0.019354;0.999757;,
    0.001814;0.001264;0.999998;,
    0.001814;0.001264;0.999998;,
    0.010560;-0.019354;0.999757;,
    0.010374;0.019628;0.999754;,
    -0.023302;-0.000674;0.999728;,
    0.001814;0.001264;0.999998;,
    0.010374;0.019628;0.999754;,
    -0.010507;0.019257;-0.999759;,
    0.023185;0.000671;-0.999731;,
    -0.001805;-0.001258;-0.999998;,
    -0.010507;0.019257;-0.999759;,
    -0.001805;-0.001258;-0.999998;,
    -0.010322;-0.019530;-0.999756;,
    -0.001805;-0.001258;-0.999998;,
    0.023185;0.000671;-0.999731;,
    -0.010322;-0.019530;-0.999756;;
    20;
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
    3;57,58,59;;
   }

   MeshMaterialList  {
    1;
    20;
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
    60;
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
    0.755241;0.309377;,
    0.996961;0.309377;,
    0.996961;0.197448;,
    0.996961;0.197448;,
    0.755241;0.197448;,
    0.755241;0.309377;,
    0.748808;0.441891;,
    0.997631;0.441891;,
    0.997631;0.326559;,
    0.997631;0.326559;,
    0.748808;0.326559;,
    0.748808;0.441891;,
    0.151882;0.334242;,
    0.437098;0.334242;,
    0.437098;0.200640;,
    0.437098;0.200640;,
    0.151882;0.200640;,
    0.151882;0.334242;,
    0.547735;0.775537;,
    0.674630;0.775537;,
    0.610538;0.735023;,
    0.610538;0.735023;,
    0.674630;0.775537;,
    0.547735;0.775537;,
    0.674630;0.775537;,
    0.610538;0.735023;,
    0.547735;0.775537;,
    0.674630;0.775537;,
    0.547735;0.775537;,
    0.610538;0.735023;,
    0.674630;0.775537;,
    0.610538;0.735023;,
    0.547735;0.775537;,
    0.610538;0.735023;,
    0.674630;0.775537;,
    0.547735;0.775537;;
   }
  }
 }
}