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

Frame road-block_06 {
 

 FrameTransformMatrix {
  1.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,-1.000000,0.000000,0.000000,1.000000,-0.000000,0.000000,0.000000,-12.670539,12.491668,1.000000;;
 }

 Frame {
  

  FrameTransformMatrix {
   1.000000,0.000000,0.000000,0.000000,0.000000,1.000000,0.000000,0.000000,0.000000,0.000000,1.000000,0.000000,0.000000,-0.000000,0.000000,1.000000;;
  }

  Mesh  {
   144;
   5.307610;-0.000007;-0.084595;,
   20.704742;-0.000003;-0.000000;,
   18.673584;15.091619;-0.000000;,
   18.673584;15.091619;-0.000000;,
   3.697105;10.966485;-0.084595;,
   5.307610;-0.000007;-0.084595;,
   20.704742;-0.000003;-0.000000;,
   36.101875;0.000002;0.084595;,
   33.650063;19.216753;0.084595;,
   33.650063;19.216753;0.084595;,
   18.673584;15.091619;-0.000000;,
   20.704742;-0.000003;-0.000000;,
   3.697105;10.966485;-0.084595;,
   18.673584;15.091619;-0.000000;,
   12.942676;28.658802;-0.000000;,
   12.942676;28.658802;-0.000000;,
   -0.452157;20.807158;-0.084595;,
   3.697105;10.966485;-0.084595;,
   18.673584;15.091619;-0.000000;,
   33.650063;19.216753;0.084595;,
   26.337507;36.510448;0.084595;,
   26.337507;36.510448;0.084595;,
   12.942676;28.658802;-0.000000;,
   18.673584;15.091619;-0.000000;,
   -0.452157;20.807158;-0.084595;,
   12.942676;28.658802;-0.000000;,
   4.055849;40.157719;-0.000000;,
   4.055849;40.157719;-0.000000;,
   -6.920532;29.181246;-0.084595;,
   -0.452157;20.807158;-0.084595;,
   12.942676;28.658802;-0.000000;,
   26.337507;36.510448;0.084595;,
   15.032232;51.134197;0.084595;,
   15.032232;51.134197;0.084595;,
   4.055849;40.157719;-0.000000;,
   12.942676;28.658802;-0.000000;,
   -6.920532;29.181246;-0.084595;,
   4.055849;40.157719;-0.000000;,
   -7.443079;49.044556;-0.000000;,
   -7.443079;49.044556;-0.000000;,
   -15.294697;35.649704;-0.084595;,
   -6.920532;29.181246;-0.084595;,
   4.055849;40.157719;-0.000000;,
   15.032232;51.134197;0.084595;,
   0.408536;62.439407;0.084595;,
   0.408536;62.439407;0.084595;,
   -7.443079;49.044556;-0.000000;,
   4.055849;40.157719;-0.000000;,
   -15.294697;35.649704;-0.084595;,
   -7.443079;49.044556;-0.000000;,
   -21.010260;54.775459;-0.000000;,
   -21.010260;54.775459;-0.000000;,
   -25.135324;39.798962;-0.084595;,
   -15.294697;35.649704;-0.084595;,
   -7.443079;49.044556;-0.000000;,
   0.408536;62.439407;0.084595;,
   -16.885195;69.751961;0.084595;,
   -16.885195;69.751961;0.084595;,
   -21.010260;54.775459;-0.000000;,
   -7.443079;49.044556;-0.000000;,
   -25.135324;39.798962;-0.084595;,
   -21.010260;54.775459;-0.000000;,
   -36.101879;56.806614;-0.000000;,
   -36.101879;56.806614;-0.000000;,
   -36.101868;41.409481;-0.084595;,
   -25.135324;39.798962;-0.084595;,
   -21.010260;54.775459;-0.000000;,
   -16.885195;69.751961;0.084595;,
   -36.101887;72.203751;0.084595;,
   -36.101887;72.203751;0.084595;,
   -36.101879;56.806614;-0.000000;,
   -21.010260;54.775459;-0.000000;,
   -36.101871;-41.409496;-0.084595;,
   -36.101871;-56.806629;0.000000;,
   -21.010254;-54.775467;-0.000000;,
   -21.010254;-54.775467;-0.000000;,
   -25.135387;-39.798988;-0.084595;,
   -36.101871;-41.409496;-0.084595;,
   -36.101871;-56.806629;0.000000;,
   -36.101871;-72.203758;0.084595;,
   -16.885120;-69.751945;0.084595;,
   -16.885120;-69.751945;0.084595;,
   -21.010254;-54.775467;-0.000000;,
   -36.101871;-56.806629;0.000000;,
   -25.135387;-39.798988;-0.084595;,
   -21.010254;-54.775467;-0.000000;,
   -7.443071;-49.044563;-0.000000;,
   -7.443071;-49.044563;-0.000000;,
   -15.294716;-35.649727;-0.084595;,
   -25.135387;-39.798988;-0.084595;,
   -21.010254;-54.775467;-0.000000;,
   -16.885120;-69.751945;0.084595;,
   0.408572;-62.439396;0.084595;,
   0.408572;-62.439396;0.084595;,
   -7.443071;-49.044563;-0.000000;,
   -21.010254;-54.775467;-0.000000;,
   -15.294716;-35.649727;-0.084595;,
   -7.443071;-49.044563;-0.000000;,
   4.055849;-40.157738;-0.000000;,
   4.055849;-40.157738;-0.000000;,
   -6.920626;-29.181353;-0.084595;,
   -15.294716;-35.649727;-0.084595;,
   -7.443071;-49.044563;-0.000000;,
   0.408572;-62.439396;0.084595;,
   15.032324;-51.134117;0.084595;,
   15.032324;-51.134117;0.084595;,
   4.055849;-40.157738;-0.000000;,
   -7.443071;-49.044563;-0.000000;,
   -6.920626;-29.181353;-0.084595;,
   4.055849;-40.157738;-0.000000;,
   12.942685;-28.658806;-0.000000;,
   12.942685;-28.658806;-0.000000;,
   -0.452167;-20.807188;-0.084595;,
   -6.920626;-29.181353;-0.084595;,
   4.055849;-40.157738;-0.000000;,
   15.032324;-51.134117;0.084595;,
   26.337538;-36.510422;0.084595;,
   26.337538;-36.510422;0.084595;,
   12.942685;-28.658806;-0.000000;,
   4.055849;-40.157738;-0.000000;,
   -0.452167;-20.807188;-0.084595;,
   12.942685;-28.658806;-0.000000;,
   18.673588;-15.091626;-0.000000;,
   18.673588;-15.091626;-0.000000;,
   3.697091;-10.966560;-0.084595;,
   -0.452167;-20.807188;-0.084595;,
   12.942685;-28.658806;-0.000000;,
   26.337538;-36.510422;0.084595;,
   33.650085;-19.216692;0.084595;,
   33.650085;-19.216692;0.084595;,
   18.673588;-15.091626;-0.000000;,
   12.942685;-28.658806;-0.000000;,
   3.697091;-10.966560;-0.084595;,
   18.673588;-15.091626;-0.000000;,
   20.704742;-0.000003;-0.000000;,
   20.704742;-0.000003;-0.000000;,
   5.307610;-0.000007;-0.084595;,
   3.697091;-10.966560;-0.084595;,
   18.673588;-15.091626;-0.000000;,
   33.650085;-19.216692;0.084595;,
   36.101875;0.000002;0.084595;,
   36.101875;0.000002;0.084595;,
   20.704742;-0.000003;-0.000000;,
   18.673588;-15.091626;-0.000000;;
   48;
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
   3;63,64,65;,
   3;66,67,68;,
   3;69,70,71;,
   3;72,73,74;,
   3;75,76,77;,
   3;78,79,80;,
   3;81,82,83;,
   3;84,85,86;,
   3;87,88,89;,
   3;90,91,92;,
   3;93,94,95;,
   3;96,97,98;,
   3;99,100,101;,
   3;102,103,104;,
   3;105,106,107;,
   3;108,109,110;,
   3;111,112,113;,
   3;114,115,116;,
   3;117,118,119;,
   3;120,121,122;,
   3;123,124,125;,
   3;126,127,128;,
   3;129,130,131;,
   3;132,133,134;,
   3;135,136,137;,
   3;138,139,140;,
   3;141,142,143;;

   MeshNormals  {
    144;
    -0.005478;0.000019;0.999985;,
    -0.005482;0.000012;0.999985;,
    -0.005258;-0.001442;0.999985;,
    -0.005258;-0.001442;0.999985;,
    -0.005245;-0.001468;0.999985;,
    -0.005478;0.000019;0.999985;,
    -0.005482;0.000012;0.999985;,
    -0.005485;0.000008;0.999985;,
    -0.005264;-0.001431;0.999985;,
    -0.005264;-0.001431;0.999985;,
    -0.005258;-0.001442;0.999985;,
    -0.005482;0.000012;0.999985;,
    -0.005245;-0.001468;0.999985;,
    -0.005258;-0.001442;0.999985;,
    -0.004704;-0.002748;0.999985;,
    -0.004704;-0.002748;0.999985;,
    -0.004706;-0.002746;0.999985;,
    -0.005245;-0.001468;0.999985;,
    -0.005258;-0.001442;0.999985;,
    -0.005264;-0.001431;0.999985;,
    -0.004703;-0.002750;0.999985;,
    -0.004703;-0.002750;0.999985;,
    -0.004704;-0.002748;0.999985;,
    -0.005258;-0.001442;0.999985;,
    -0.004706;-0.002746;0.999985;,
    -0.004704;-0.002748;0.999985;,
    -0.003853;-0.003853;0.999985;,
    -0.003853;-0.003853;0.999985;,
    -0.003853;-0.003853;0.999985;,
    -0.004706;-0.002746;0.999985;,
    -0.004704;-0.002748;0.999985;,
    -0.004703;-0.002750;0.999985;,
    -0.003853;-0.003853;0.999985;,
    -0.003853;-0.003853;0.999985;,
    -0.003853;-0.003853;0.999985;,
    -0.004704;-0.002748;0.999985;,
    -0.003853;-0.003853;0.999985;,
    -0.003853;-0.003853;0.999985;,
    -0.002749;-0.004704;0.999985;,
    -0.002749;-0.004704;0.999985;,
    -0.002746;-0.004705;0.999985;,
    -0.003853;-0.003853;0.999985;,
    -0.003853;-0.003853;0.999985;,
    -0.003853;-0.003853;0.999985;,
    -0.002750;-0.004703;0.999985;,
    -0.002750;-0.004703;0.999985;,
    -0.002749;-0.004704;0.999985;,
    -0.003853;-0.003853;0.999985;,
    -0.002746;-0.004705;0.999985;,
    -0.002749;-0.004704;0.999985;,
    -0.001430;-0.005261;0.999985;,
    -0.001430;-0.005261;0.999985;,
    -0.001453;-0.005265;0.999985;,
    -0.002746;-0.004705;0.999985;,
    -0.002749;-0.004704;0.999985;,
    -0.002750;-0.004703;0.999985;,
    -0.001420;-0.005258;0.999985;,
    -0.001420;-0.005258;0.999985;,
    -0.001430;-0.005261;0.999985;,
    -0.002749;-0.004704;0.999985;,
    -0.001453;-0.005265;0.999985;,
    -0.001430;-0.005261;0.999985;,
    -0.000750;-0.005481;0.999985;,
    -0.000750;-0.005481;0.999985;,
    -0.000807;-0.005494;0.999985;,
    -0.001453;-0.005265;0.999985;,
    -0.001430;-0.005261;0.999985;,
    -0.001420;-0.005258;0.999985;,
    -0.000718;-0.005475;0.999985;,
    -0.000718;-0.005475;0.999985;,
    -0.000750;-0.005481;0.999985;,
    -0.001430;-0.005261;0.999985;,
    -0.000769;0.005461;0.999985;,
    -0.000726;0.005483;0.999985;,
    -0.001442;0.005258;0.999985;,
    -0.001442;0.005258;0.999985;,
    -0.001468;0.005245;0.999985;,
    -0.000769;0.005461;0.999985;,
    -0.000726;0.005483;0.999985;,
    -0.000701;0.005494;0.999985;,
    -0.001431;0.005264;0.999985;,
    -0.001431;0.005264;0.999985;,
    -0.001442;0.005258;0.999985;,
    -0.000726;0.005483;0.999985;,
    -0.001468;0.005245;0.999985;,
    -0.001442;0.005258;0.999985;,
    -0.002748;0.004704;0.999985;,
    -0.002748;0.004704;0.999985;,
    -0.002746;0.004706;0.999985;,
    -0.001468;0.005245;0.999985;,
    -0.001442;0.005258;0.999985;,
    -0.001431;0.005264;0.999985;,
    -0.002750;0.004703;0.999985;,
    -0.002750;0.004703;0.999985;,
    -0.002748;0.004704;0.999985;,
    -0.001442;0.005258;0.999985;,
    -0.002746;0.004706;0.999985;,
    -0.002748;0.004704;0.999985;,
    -0.003853;0.003853;0.999985;,
    -0.003853;0.003853;0.999985;,
    -0.003853;0.003853;0.999985;,
    -0.002746;0.004706;0.999985;,
    -0.002748;0.004704;0.999985;,
    -0.002750;0.004703;0.999985;,
    -0.003853;0.003853;0.999985;,
    -0.003853;0.003853;0.999985;,
    -0.003853;0.003853;0.999985;,
    -0.002748;0.004704;0.999985;,
    -0.003853;0.003853;0.999985;,
    -0.003853;0.003853;0.999985;,
    -0.004704;0.002749;0.999985;,
    -0.004704;0.002749;0.999985;,
    -0.004705;0.002746;0.999985;,
    -0.003853;0.003853;0.999985;,
    -0.003853;0.003853;0.999985;,
    -0.003853;0.003853;0.999985;,
    -0.004703;0.002750;0.999985;,
    -0.004703;0.002750;0.999985;,
    -0.004704;0.002749;0.999985;,
    -0.003853;0.003853;0.999985;,
    -0.004705;0.002746;0.999985;,
    -0.004704;0.002749;0.999985;,
    -0.005261;0.001430;0.999985;,
    -0.005261;0.001430;0.999985;,
    -0.005265;0.001453;0.999985;,
    -0.004705;0.002746;0.999985;,
    -0.004704;0.002749;0.999985;,
    -0.004703;0.002750;0.999985;,
    -0.005258;0.001420;0.999985;,
    -0.005258;0.001420;0.999985;,
    -0.005261;0.001430;0.999985;,
    -0.004704;0.002749;0.999985;,
    -0.005265;0.001453;0.999985;,
    -0.005261;0.001430;0.999985;,
    -0.005482;0.000012;0.999985;,
    -0.005482;0.000012;0.999985;,
    -0.005478;0.000019;0.999985;,
    -0.005265;0.001453;0.999985;,
    -0.005261;0.001430;0.999985;,
    -0.005258;0.001420;0.999985;,
    -0.005485;0.000008;0.999985;,
    -0.005485;0.000008;0.999985;,
    -0.005482;0.000012;0.999985;,
    -0.005261;0.001430;0.999985;;
    48;
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
    3;63,64,65;,
    3;66,67,68;,
    3;69,70,71;,
    3;72,73,74;,
    3;75,76,77;,
    3;78,79,80;,
    3;81,82,83;,
    3;84,85,86;,
    3;87,88,89;,
    3;90,91,92;,
    3;93,94,95;,
    3;96,97,98;,
    3;99,100,101;,
    3;102,103,104;,
    3;105,106,107;,
    3;108,109,110;,
    3;111,112,113;,
    3;114,115,116;,
    3;117,118,119;,
    3;120,121,122;,
    3;123,124,125;,
    3;126,127,128;,
    3;129,130,131;,
    3;132,133,134;,
    3;135,136,137;,
    3;138,139,140;,
    3;141,142,143;;
   }

   MeshMaterialList  {
    1;
    48;
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
    0,
    0,
    0,
    0,
    0,
    0;
    { roads }
   }

   MeshTextureCoords  {
    144;
    0.822704;0.196665;,
    0.822704;0.002976;,
    0.740676;0.002976;,
    0.740676;0.002976;,
    0.740676;0.196665;,
    0.822704;0.196665;,
    0.822704;0.002976;,
    0.822704;0.197347;,
    0.740676;0.197347;,
    0.740676;0.197347;,
    0.740676;0.002976;,
    0.822704;0.002976;,
    0.740676;0.196665;,
    0.740676;0.002976;,
    0.661341;0.002976;,
    0.661341;0.002976;,
    0.661341;0.196665;,
    0.740676;0.196665;,
    0.740676;0.002976;,
    0.740676;0.197347;,
    0.661341;0.197347;,
    0.661341;0.197347;,
    0.661341;0.002976;,
    0.740676;0.002976;,
    0.661341;0.196665;,
    0.661341;0.002976;,
    0.583057;0.002976;,
    0.583057;0.002976;,
    0.583057;0.196665;,
    0.661341;0.196665;,
    0.661341;0.002976;,
    0.661341;0.197347;,
    0.583057;0.197347;,
    0.583057;0.197347;,
    0.583057;0.002976;,
    0.661341;0.002976;,
    0.583057;0.196665;,
    0.583057;0.002976;,
    0.504772;0.002976;,
    0.504772;0.002976;,
    0.504772;0.196665;,
    0.583057;0.196665;,
    0.583057;0.002976;,
    0.583057;0.197347;,
    0.504772;0.197347;,
    0.504772;0.197347;,
    0.504772;0.002976;,
    0.583057;0.002976;,
    0.504772;0.196665;,
    0.504772;0.002976;,
    0.425437;0.002976;,
    0.425437;0.002976;,
    0.425437;0.196665;,
    0.504772;0.196665;,
    0.504772;0.002976;,
    0.504772;0.197347;,
    0.425437;0.197347;,
    0.425437;0.197347;,
    0.425437;0.002976;,
    0.504772;0.002976;,
    0.425437;0.196665;,
    0.425437;0.002976;,
    0.343409;0.002976;,
    0.343409;0.002976;,
    0.343409;0.196665;,
    0.425437;0.196665;,
    0.425437;0.002976;,
    0.425437;0.197347;,
    0.343409;0.197347;,
    0.343409;0.197347;,
    0.343409;0.002976;,
    0.425437;0.002976;,
    0.822704;0.196665;,
    0.822704;0.002976;,
    0.740676;0.002976;,
    0.740676;0.002976;,
    0.740676;0.196665;,
    0.822704;0.196665;,
    0.822704;0.002976;,
    0.822704;0.197347;,
    0.740676;0.197347;,
    0.740676;0.197347;,
    0.740676;0.002976;,
    0.822704;0.002976;,
    0.740676;0.196665;,
    0.740676;0.002976;,
    0.661341;0.002976;,
    0.661341;0.002976;,
    0.661341;0.196665;,
    0.740676;0.196665;,
    0.740676;0.002976;,
    0.740676;0.197347;,
    0.661341;0.197347;,
    0.661341;0.197347;,
    0.661341;0.002976;,
    0.740676;0.002976;,
    0.661341;0.196665;,
    0.661341;0.002976;,
    0.583057;0.002976;,
    0.583057;0.002976;,
    0.583057;0.196665;,
    0.661341;0.196665;,
    0.661341;0.002976;,
    0.661341;0.197347;,
    0.583057;0.197347;,
    0.583057;0.197347;,
    0.583057;0.002976;,
    0.661341;0.002976;,
    0.583057;0.196665;,
    0.583057;0.002976;,
    0.504772;0.002976;,
    0.504772;0.002976;,
    0.504772;0.196665;,
    0.583057;0.196665;,
    0.583057;0.002976;,
    0.583057;0.197347;,
    0.504772;0.197347;,
    0.504772;0.197347;,
    0.504772;0.002976;,
    0.583057;0.002976;,
    0.504772;0.196665;,
    0.504772;0.002976;,
    0.425437;0.002976;,
    0.425437;0.002976;,
    0.425437;0.196665;,
    0.504772;0.196665;,
    0.504772;0.002976;,
    0.504772;0.197347;,
    0.425437;0.197347;,
    0.425437;0.197347;,
    0.425437;0.002976;,
    0.504772;0.002976;,
    0.425437;0.196665;,
    0.425437;0.002976;,
    0.343409;0.002976;,
    0.343409;0.002976;,
    0.343409;0.196665;,
    0.425437;0.196665;,
    0.425437;0.002976;,
    0.425437;0.197347;,
    0.343409;0.197347;,
    0.343409;0.197347;,
    0.343409;0.002976;,
    0.425437;0.002976;;
   }
  }
 }
}