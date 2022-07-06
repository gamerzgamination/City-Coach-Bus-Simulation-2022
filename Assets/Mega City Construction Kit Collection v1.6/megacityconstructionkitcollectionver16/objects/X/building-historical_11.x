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

Frame building-historical_11 {
 

 FrameTransformMatrix {
  1.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,-1.000000,0.000000,0.000000,1.000000,-0.000000,0.000000,0.000000,-12.670539,12.491668,1.000000;;
 }

 Frame {
  

  FrameTransformMatrix {
   1.000000,0.000000,0.000000,0.000000,0.000000,1.000000,0.000000,0.000000,0.000000,0.000000,1.000000,0.000000,0.000000,-0.000000,0.000000,1.000000;;
  }

  Mesh  {
   54;
   -6.094851;-0.042126;6.625235;,
   -7.156645;-0.059442;4.477865;,
   -7.157457;-4.563860;4.472925;,
   7.154747;-4.563849;0.000000;,
   7.158560;-0.053340;4.472928;,
   7.156936;-4.563852;4.472926;,
   7.158560;-0.053340;4.472928;,
   7.154747;-4.563849;0.000000;,
   7.154743;4.563876;0.000000;,
   -7.158555;4.563868;0.000000;,
   -7.157460;4.563866;4.472925;,
   7.156932;4.563874;4.472926;,
   7.156932;4.563874;4.472926;,
   7.154743;4.563876;0.000000;,
   -7.158555;4.563868;0.000000;,
   7.154747;-4.563849;0.000000;,
   7.156936;-4.563852;4.472926;,
   -7.157457;-4.563860;4.472925;,
   -7.157457;-4.563860;4.472925;,
   -7.158551;-4.563858;0.000000;,
   7.154747;-4.563849;0.000000;,
   -7.157460;4.563866;4.472925;,
   -7.156645;-0.059442;4.477865;,
   -6.094851;-0.042126;6.625235;,
   -7.157457;-4.563860;4.472925;,
   7.156936;-4.563852;4.472926;,
   6.099442;-0.042119;6.625235;,
   6.099442;-0.042119;6.625235;,
   -6.094851;-0.042126;6.625235;,
   -7.157457;-4.563860;4.472925;,
   -6.094851;-0.042126;6.625235;,
   6.099442;-0.042119;6.625235;,
   7.156932;4.563874;4.472926;,
   7.156932;4.563874;4.472926;,
   -7.157460;4.563866;4.472925;,
   -6.094851;-0.042126;6.625235;,
   7.158560;-0.053340;4.472928;,
   6.099442;-0.042119;6.625235;,
   7.156936;-4.563852;4.472926;,
   7.158560;-0.053340;4.472928;,
   7.156932;4.563874;4.472926;,
   6.099442;-0.042119;6.625235;,
   7.154743;4.563876;0.000000;,
   7.156932;4.563874;4.472926;,
   7.158560;-0.053340;4.472928;,
   -7.156645;-0.059442;4.477865;,
   -7.158551;-4.563858;0.000000;,
   -7.157457;-4.563860;4.472925;,
   -7.158551;-4.563858;0.000000;,
   -7.156645;-0.059442;4.477865;,
   -7.158555;4.563868;0.000000;,
   -7.157460;4.563866;4.472925;,
   -7.158555;4.563868;0.000000;,
   -7.156645;-0.059442;4.477865;;
   18;
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
   3;51,52,53;;

   MeshNormals  {
    54;
    -0.422407;-0.002767;0.906402;,
    -0.896404;-0.000006;0.443238;,
    -0.269555;-0.361504;0.892555;,
    1.000000;-0.000181;-0.000670;,
    1.000000;-0.000003;-0.000674;,
    1.000000;-0.000360;-0.000489;,
    1.000000;-0.000003;-0.000674;,
    1.000000;-0.000181;-0.000670;,
    1.000000;0.000180;-0.000668;,
    -0.000001;1.000000;0.000000;,
    -0.000001;1.000000;0.000000;,
    -0.000001;1.000000;0.000000;,
    -0.000001;1.000000;0.000000;,
    -0.000001;1.000000;0.000000;,
    -0.000001;1.000000;0.000000;,
    0.000001;-1.000000;-0.000001;,
    0.000001;-1.000000;-0.000001;,
    0.000001;-1.000000;-0.000000;,
    0.000001;-1.000000;-0.000000;,
    0.000001;-1.000000;-0.000000;,
    0.000001;-1.000000;-0.000001;,
    -0.265581;0.357176;0.895484;,
    -0.896404;-0.000006;0.443238;,
    -0.422407;-0.002767;0.906402;,
    -0.269555;-0.361504;0.892555;,
    0.270131;-0.361577;0.892352;,
    0.423286;-0.002766;0.905992;,
    0.423286;-0.002766;0.905992;,
    -0.422407;-0.002767;0.906402;,
    -0.269555;-0.361504;0.892555;,
    -0.422407;-0.002767;0.906402;,
    0.423286;-0.002766;0.905992;,
    0.266145;0.357250;0.895287;,
    0.266145;0.357250;0.895287;,
    -0.265581;0.357176;0.895484;,
    -0.422407;-0.002767;0.906402;,
    0.897250;-0.000004;0.441523;,
    0.423286;-0.002766;0.905992;,
    0.270131;-0.361577;0.892352;,
    0.897250;-0.000004;0.441523;,
    0.266145;0.357250;0.895287;,
    0.423286;-0.002766;0.905992;,
    1.000000;0.000180;-0.000668;,
    1.000000;0.000353;-0.000489;,
    1.000000;-0.000003;-0.000674;,
    -1.000000;0.000001;0.000337;,
    -1.000000;0.000090;0.000335;,
    -1.000000;0.000180;0.000245;,
    -1.000000;0.000090;0.000335;,
    -1.000000;0.000001;0.000337;,
    -1.000000;-0.000090;0.000334;,
    -1.000000;-0.000176;0.000245;,
    -1.000000;-0.000090;0.000334;,
    -1.000000;0.000001;0.000337;;
    18;
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
    3;51,52,53;;
   }

   MeshMaterialList  {
    1;
    18;
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
    { buildz2 }
   }

   MeshTextureCoords  {
    54;
    0.627512;0.028362;,
    0.627546;0.009005;,
    0.649861;0.009005;,
    -0.757552;0.586722;,
    -0.622299;0.456506;,
    -0.757552;0.456506;,
    -0.622299;0.456506;,
    -0.757552;0.586722;,
    -0.484592;0.586722;,
    0.026567;0.586722;,
    0.026576;0.464020;,
    -0.519315;0.464020;,
    -0.519315;0.464020;,
    -0.519315;0.586722;,
    0.026567;0.586722;,
    0.026567;0.586722;,
    0.026576;0.464020;,
    -0.519315;0.464020;,
    -0.519315;0.464020;,
    -0.519315;0.586722;,
    0.026567;0.586722;,
    0.604188;0.009004;,
    0.627546;0.009005;,
    0.627512;0.028362;,
    1.210034;0.027221;,
    1.397301;0.027220;,
    1.380471;0.011623;,
    1.380471;0.011623;,
    1.221212;0.011109;,
    1.210034;0.027221;,
    1.221212;0.011109;,
    1.380471;0.011623;,
    1.397299;0.027520;,
    1.397299;0.027520;,
    1.210033;0.027521;,
    1.221212;0.011109;,
    0.627546;0.009005;,
    0.627512;0.028362;,
    0.649861;0.009005;,
    0.627546;0.009005;,
    0.604188;0.009004;,
    0.627512;0.028362;,
    -0.484592;0.586722;,
    -0.484584;0.456506;,
    -0.622299;0.456506;,
    -0.641190;0.464020;,
    -0.791321;0.586722;,
    -0.791321;0.464020;,
    -0.791321;0.586722;,
    -0.641190;0.464020;,
    -0.488336;0.586722;,
    -0.488327;0.464020;,
    -0.488336;0.586722;,
    -0.641190;0.464020;;
   }
  }
 }
}