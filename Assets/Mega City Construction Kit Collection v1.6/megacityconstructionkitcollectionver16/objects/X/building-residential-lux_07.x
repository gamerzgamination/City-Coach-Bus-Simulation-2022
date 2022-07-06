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

Frame building-residential-lux_07 {
 

 FrameTransformMatrix {
  1.000000,0.000000,0.000000,0.000000,0.000000,-0.000000,-1.000000,0.000000,0.000000,1.000000,-0.000000,0.000000,0.000000,-12.670539,12.491668,1.000000;;
 }

 Frame {
  

  FrameTransformMatrix {
   1.000000,0.000000,0.000000,0.000000,0.000000,1.000000,0.000000,0.000000,0.000000,0.000000,1.000000,0.000000,0.000000,-0.000000,0.000000,1.000000;;
  }

  Mesh  {
   225;
   6.284524;6.675556;2.386772;,
   -6.161412;6.675560;2.386772;,
   -6.161412;6.675560;11.661698;,
   -6.161412;6.675560;11.661698;,
   6.284524;6.675556;11.661698;,
   6.284524;6.675556;2.386772;,
   -6.161412;6.675560;2.386772;,
   -6.161416;-3.438052;2.386772;,
   -6.161416;-3.438052;11.661698;,
   -6.161416;-3.438052;11.661698;,
   -6.161412;6.675560;11.661698;,
   -6.161412;6.675560;2.386772;,
   -6.161416;-3.438052;2.386772;,
   6.284521;-3.438056;2.386772;,
   6.284521;-3.438056;11.661698;,
   6.284521;-3.438056;11.661698;,
   -6.161416;-3.438052;11.661698;,
   -6.161416;-3.438052;2.386772;,
   -6.161414;1.618754;14.444176;,
   6.284523;1.618750;14.444176;,
   6.284524;6.675556;11.661698;,
   6.284524;6.675556;11.661698;,
   -6.161412;6.675560;11.661698;,
   -6.161414;1.618754;14.444176;,
   -6.161412;6.675560;11.661698;,
   -6.161416;-3.438052;11.661698;,
   -6.161414;1.618754;14.444176;,
   6.284523;1.618750;14.444176;,
   -6.161414;1.618754;14.444176;,
   -6.161416;-3.438052;11.661698;,
   -6.161416;-3.438052;11.661698;,
   6.284521;-3.438056;11.661698;,
   6.284523;1.618750;14.444176;,
   0.971984;-4.945921;6.502483;,
   -5.101536;-4.945920;6.502483;,
   -5.101536;-3.369872;6.502483;,
   -5.101536;-3.369872;6.502483;,
   0.971984;-3.369874;6.502483;,
   0.971984;-4.945921;6.502483;,
   0.971984;-4.945921;10.876904;,
   0.971984;-3.369874;10.876904;,
   -5.101536;-3.369872;10.876904;,
   -5.101536;-3.369872;10.876904;,
   -5.101536;-4.945920;10.876904;,
   0.971984;-4.945921;10.876904;,
   0.971984;-4.945921;6.502483;,
   0.971984;-3.369874;6.502483;,
   0.971984;-3.369874;10.876904;,
   0.971984;-3.369874;10.876904;,
   0.971984;-4.945921;10.876904;,
   0.971984;-4.945921;6.502483;,
   -5.101536;-3.369872;6.502483;,
   -5.101536;-4.945920;6.502483;,
   -5.101536;-4.945920;10.876904;,
   -5.101536;-4.945920;10.876904;,
   -5.101536;-3.369872;10.876904;,
   -5.101536;-3.369872;6.502483;,
   -5.101536;-4.945920;6.502483;,
   0.971984;-4.945921;6.502483;,
   0.971984;-4.945921;10.876904;,
   0.971984;-4.945921;10.876904;,
   -5.101536;-4.945920;10.876904;,
   -5.101536;-4.945920;6.502483;,
   6.835688;7.654236;0.000000;,
   -6.835685;7.654240;0.000000;,
   -6.835685;7.654240;2.471643;,
   -6.835685;7.654240;2.471643;,
   6.835686;7.654236;2.471643;,
   6.835688;7.654236;0.000000;,
   -6.835685;7.654240;0.000000;,
   -6.835689;-4.211660;0.000000;,
   -6.835689;-4.211660;2.471643;,
   -6.835689;-4.211660;2.471643;,
   -6.835685;7.654240;2.471643;,
   -6.835685;7.654240;0.000000;,
   -6.835689;-4.211660;0.000000;,
   6.835684;-4.211665;0.000000;,
   6.835682;-4.211665;2.471643;,
   6.835682;-4.211665;2.471643;,
   -6.835689;-4.211660;2.471643;,
   -6.835689;-4.211660;0.000000;,
   -5.175596;-4.987627;2.448879;,
   -5.175597;-7.643670;0.153127;,
   -2.899825;-7.643671;0.153127;,
   -2.899825;-7.643671;0.153127;,
   -2.899824;-4.987628;2.448879;,
   -5.175596;-4.987627;2.448879;,
   -2.549290;-4.987628;0.153127;,
   -2.549290;-4.987628;2.448879;,
   -2.549291;-7.643671;0.153127;,
   -5.526129;-4.987627;0.153127;,
   -5.526130;-7.643670;0.153127;,
   -5.526129;-4.987627;2.448879;,
   -5.526129;-3.398233;2.448879;,
   -5.526129;-3.398233;0.153127;,
   -5.526129;-4.987627;0.153127;,
   -5.526129;-4.987627;0.153127;,
   -5.526129;-4.987627;2.448879;,
   -5.526129;-3.398233;2.448879;,
   -2.899824;-3.398234;2.448879;,
   -5.175596;-3.398233;2.448879;,
   -5.175596;-4.987627;2.448879;,
   -5.175596;-4.987627;2.448879;,
   -2.899824;-4.987628;2.448879;,
   -2.899824;-3.398234;2.448879;,
   -2.549289;-3.398234;0.153127;,
   -2.549289;-3.398234;2.448879;,
   -2.549290;-4.987628;2.448879;,
   -2.549290;-4.987628;2.448879;,
   -2.549290;-4.987628;0.153127;,
   -2.549289;-3.398234;0.153127;,
   -2.549290;-4.998189;3.530188;,
   -2.549289;-3.408796;3.530188;,
   -2.899824;-3.408796;3.530188;,
   -2.899824;-3.408796;3.530188;,
   -2.899824;-4.998189;3.530188;,
   -2.549290;-4.998189;3.530188;,
   -2.549291;-7.654233;1.234437;,
   -2.549290;-4.998189;3.530188;,
   -2.899824;-4.998189;3.530188;,
   -2.899824;-4.998189;3.530188;,
   -2.899825;-7.654233;1.234437;,
   -2.549291;-7.654233;1.234437;,
   -5.526129;-4.998188;3.530188;,
   -5.526130;-7.654232;1.234437;,
   -5.175597;-7.654232;1.234437;,
   -5.175597;-7.654232;1.234437;,
   -5.175596;-4.998188;3.530188;,
   -5.526129;-4.998188;3.530188;,
   -5.526129;-3.408795;3.530188;,
   -5.526129;-4.998188;3.530188;,
   -5.175596;-4.998188;3.530188;,
   -5.175596;-4.998188;3.530188;,
   -5.175596;-3.408795;3.530188;,
   -5.526129;-3.408795;3.530188;,
   -2.899825;-7.654233;1.234437;,
   -2.899824;-4.998189;3.530188;,
   -2.899824;-4.987628;2.448879;,
   -2.899824;-4.987628;2.448879;,
   -2.899825;-7.643671;0.153127;,
   -2.899825;-7.654233;1.234437;,
   -2.549291;-7.654233;1.234437;,
   -2.899825;-7.654233;1.234437;,
   -2.899825;-7.643671;0.153127;,
   -2.899825;-7.643671;0.153127;,
   -2.549291;-7.643671;0.153127;,
   -2.549291;-7.654233;1.234437;,
   -2.549290;-4.998189;3.530188;,
   -2.549291;-7.654233;1.234437;,
   -2.549291;-7.643671;0.153127;,
   -2.549291;-7.643671;0.153127;,
   -2.549290;-4.987628;2.448879;,
   -2.549290;-4.998189;3.530188;,
   -2.549289;-3.408796;3.530188;,
   -2.549290;-4.998189;3.530188;,
   -2.549290;-4.987628;2.448879;,
   -2.549290;-4.987628;2.448879;,
   -2.549289;-3.398234;2.448879;,
   -2.549289;-3.408796;3.530188;,
   -2.899824;-4.998189;3.530188;,
   -2.899824;-3.408796;3.530188;,
   -2.899824;-3.398234;2.448879;,
   -2.899824;-3.398234;2.448879;,
   -2.899824;-4.987628;2.448879;,
   -2.899824;-4.998189;3.530188;,
   -5.175596;-4.998188;3.530188;,
   -5.175597;-7.654232;1.234437;,
   -5.175597;-7.643670;0.153127;,
   -5.175597;-7.643670;0.153127;,
   -5.175596;-4.987627;2.448879;,
   -5.175596;-4.998188;3.530188;,
   -5.175596;-3.408795;3.530188;,
   -5.175596;-4.998188;3.530188;,
   -5.175596;-4.987627;2.448879;,
   -5.175596;-4.987627;2.448879;,
   -5.175596;-3.398233;2.448879;,
   -5.175596;-3.408795;3.530188;,
   -5.526129;-4.998188;3.530188;,
   -5.526129;-3.408795;3.530188;,
   -5.526129;-3.398233;2.448879;,
   -5.526129;-3.398233;2.448879;,
   -5.526129;-4.987627;2.448879;,
   -5.526129;-4.998188;3.530188;,
   -5.526130;-7.654232;1.234437;,
   -5.526129;-4.998188;3.530188;,
   -5.526129;-4.987627;2.448879;,
   -5.526129;-4.987627;2.448879;,
   -5.526130;-7.643670;0.153127;,
   -5.526130;-7.654232;1.234437;,
   -5.175597;-7.654232;1.234437;,
   -5.526130;-7.654232;1.234437;,
   -5.526130;-7.643670;0.153127;,
   -5.526130;-7.643670;0.153127;,
   -5.175597;-7.643670;0.153127;,
   -5.175597;-7.654232;1.234437;,
   6.835684;-4.211665;0.000000;,
   6.835688;7.654236;0.000000;,
   6.835682;-4.211665;2.471643;,
   6.835686;7.654236;2.471643;,
   6.835682;-4.211665;2.471643;,
   6.835688;7.654236;0.000000;,
   6.835686;7.654236;2.471643;,
   -6.835685;7.654240;2.471643;,
   -6.835689;-4.211660;2.471643;,
   -6.835689;-4.211660;2.471643;,
   6.835682;-4.211665;2.471643;,
   6.835686;7.654236;2.471643;,
   3.149189;1.050312;14.077149;,
   1.273006;-3.031495;11.749535;,
   3.149187;-3.031496;14.153500;,
   1.273006;-3.031495;11.749535;,
   5.217557;-3.031497;11.749535;,
   3.149187;-3.031496;14.153500;,
   3.149189;1.050312;14.077149;,
   3.149187;-3.031496;14.153500;,
   5.217557;-3.031497;11.749535;,
   6.284521;-3.438056;2.386772;,
   6.284524;6.675556;2.386772;,
   6.284521;-3.438056;11.661698;,
   6.284524;6.675556;11.661698;,
   6.284521;-3.438056;11.661698;,
   6.284524;6.675556;2.386772;,
   6.284521;-3.438056;11.661698;,
   6.284524;6.675556;11.661698;,
   6.284523;1.618750;14.444176;;
   75;
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
   3;141,142,143;,
   3;144,145,146;,
   3;147,148,149;,
   3;150,151,152;,
   3;153,154,155;,
   3;156,157,158;,
   3;159,160,161;,
   3;162,163,164;,
   3;165,166,167;,
   3;168,169,170;,
   3;171,172,173;,
   3;174,175,176;,
   3;177,178,179;,
   3;180,181,182;,
   3;183,184,185;,
   3;186,187,188;,
   3;189,190,191;,
   3;192,193,194;,
   3;195,196,197;,
   3;198,199,200;,
   3;201,202,203;,
   3;204,205,206;,
   3;207,208,209;,
   3;210,211,212;,
   3;213,214,215;,
   3;216,217,218;,
   3;219,220,221;,
   3;222,223,224;;

   MeshNormals  {
    225;
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
    -0.000000;-1.000000;0.000000;,
    -0.000000;-1.000000;0.000000;,
    -0.000000;-1.000000;0.000000;,
    -0.000000;-1.000000;0.000000;,
    -0.000000;-1.000000;0.000000;,
    -0.000000;-1.000000;0.000000;,
    0.000000;0.482083;0.876126;,
    0.000000;0.482083;0.876126;,
    0.000000;0.482083;0.876126;,
    0.000000;0.482083;0.876126;,
    0.000000;0.482083;0.876126;,
    0.000000;0.482083;0.876126;,
    -1.000000;0.000000;-0.000000;,
    -1.000000;0.000000;-0.000000;,
    -1.000000;0.000000;-0.000000;,
    -0.000000;-0.482083;0.876126;,
    -0.000000;-0.482083;0.876126;,
    -0.000000;-0.482083;0.876126;,
    -0.000000;-0.482083;0.876126;,
    -0.000000;-0.482083;0.876126;,
    -0.000000;-0.482083;0.876126;,
    0.000000;0.000000;-1.000000;,
    0.000000;0.000000;-1.000000;,
    0.000000;0.000000;-1.000000;,
    0.000000;0.000000;-1.000000;,
    0.000000;0.000000;-1.000000;,
    0.000000;0.000000;-1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -0.000000;-1.000000;0.000000;,
    -0.000000;-1.000000;0.000000;,
    -0.000000;-1.000000;0.000000;,
    -0.000000;-1.000000;0.000000;,
    -0.000000;-1.000000;0.000000;,
    -0.000000;-1.000000;0.000000;,
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
    -0.000000;-1.000000;-0.000000;,
    -0.000000;-1.000000;-0.000000;,
    -0.000000;-0.707107;0.707107;,
    -0.000000;-0.707107;0.707107;,
    -0.000000;-0.707107;0.707107;,
    -0.000000;-1.000000;-0.000000;,
    -0.000000;-0.653929;0.756556;,
    -0.000000;-0.653929;0.756556;,
    -0.000000;-0.653929;0.756556;,
    -0.000000;-0.653929;0.756556;,
    -0.000000;-0.653929;0.756556;,
    -0.000000;-0.653929;0.756556;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;-0.653929;0.756556;,
    0.000000;-0.653929;0.756556;,
    0.000000;-0.653929;0.756556;,
    0.000000;-0.653929;0.756556;,
    0.000000;-0.653929;0.756556;,
    0.000000;-0.653929;0.756556;,
    0.000000;-0.653929;0.756556;,
    0.000000;-0.653929;0.756556;,
    0.000000;-0.653929;0.756556;,
    0.000000;-0.653929;0.756556;,
    0.000000;-0.653929;0.756556;,
    0.000000;-0.653929;0.756556;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    0.000000;-0.999952;-0.009767;,
    0.000000;-0.999952;-0.009767;,
    0.000000;-0.999952;-0.009767;,
    0.000000;-0.999952;-0.009767;,
    0.000000;-0.999952;-0.009767;,
    0.000000;-0.999952;-0.009767;,
    1.000000;-0.000001;0.000000;,
    1.000000;-0.000001;0.000000;,
    1.000000;-0.000001;0.000000;,
    1.000000;-0.000000;-0.000000;,
    1.000000;-0.000000;-0.000000;,
    1.000000;-0.000000;-0.000000;,
    1.000000;-0.000000;-0.000000;,
    1.000000;-0.000000;-0.000000;,
    1.000000;-0.000000;-0.000000;,
    1.000000;-0.000000;-0.000000;,
    1.000000;-0.000000;-0.000000;,
    1.000000;-0.000000;-0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    1.000000;-0.000000;-0.000000;,
    1.000000;-0.000000;-0.000000;,
    1.000000;-0.000000;-0.000000;,
    1.000000;-0.000000;-0.000000;,
    1.000000;-0.000000;-0.000000;,
    1.000000;-0.000000;-0.000000;,
    1.000000;0.000000;0.000000;,
    1.000000;0.000000;0.000000;,
    1.000000;0.000000;0.000000;,
    1.000000;0.000000;0.000000;,
    1.000000;0.000000;0.000000;,
    1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    -1.000000;0.000000;0.000000;,
    0.000000;-0.999952;-0.009767;,
    0.000000;-0.999952;-0.009767;,
    0.000000;-0.999952;-0.009767;,
    0.000000;-0.999952;-0.009767;,
    0.000000;-0.999952;-0.009767;,
    0.000000;-0.999952;-0.009767;,
    1.000000;-0.000000;0.000001;,
    1.000000;-0.000000;0.000001;,
    1.000000;-0.000000;0.000001;,
    1.000000;-0.000000;0.000001;,
    1.000000;-0.000000;0.000001;,
    1.000000;-0.000000;0.000001;,
    0.000000;0.000000;1.000000;,
    0.000000;0.000000;1.000000;,
    -0.000000;-0.707107;0.707107;,
    -0.000000;-0.707107;0.707107;,
    -0.000000;-0.707107;0.707107;,
    0.000000;0.000000;1.000000;,
    -0.788277;0.011508;0.615213;,
    -0.788277;0.011508;0.615213;,
    -0.788277;0.011508;0.615213;,
    -0.000000;-1.000000;-0.000000;,
    -0.000000;-1.000000;-0.000000;,
    -0.000000;-1.000000;-0.000000;,
    0.757979;0.012198;0.652165;,
    0.757979;0.012198;0.652165;,
    0.757979;0.012198;0.652165;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;,
    1.000000;-0.000000;0.000000;;
    75;
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
    3;141,142,143;,
    3;144,145,146;,
    3;147,148,149;,
    3;150,151,152;,
    3;153,154,155;,
    3;156,157,158;,
    3;159,160,161;,
    3;162,163,164;,
    3;165,166,167;,
    3;168,169,170;,
    3;171,172,173;,
    3;174,175,176;,
    3;177,178,179;,
    3;180,181,182;,
    3;183,184,185;,
    3;186,187,188;,
    3;189,190,191;,
    3;192,193,194;,
    3;195,196,197;,
    3;198,199,200;,
    3;201,202,203;,
    3;204,205,206;,
    3;207,208,209;,
    3;210,211,212;,
    3;213,214,215;,
    3;216,217,218;,
    3;219,220,221;,
    3;222,223,224;;
   }

   MeshMaterialList  {
    1;
    75;
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
    { buildz4 }
   }

   MeshTextureCoords  {
    225;
    0.000764;0.678563;,
    0.156069;0.678563;,
    0.156069;0.545711;,
    0.156069;0.545711;,
    0.000764;0.545711;,
    0.000764;0.678563;,
    0.143168;0.678563;,
    0.281222;0.678563;,
    0.281222;0.545711;,
    0.281222;0.545711;,
    0.143168;0.545711;,
    0.143168;0.678563;,
    0.156069;0.678563;,
    0.000764;0.678563;,
    0.000764;0.545711;,
    0.000764;0.545711;,
    0.156069;0.545711;,
    0.156069;0.678563;,
    0.996938;0.169170;,
    0.862320;0.169170;,
    0.862320;0.215221;,
    0.862320;0.215221;,
    0.996938;0.215221;,
    0.996938;0.169170;,
    0.257929;0.545260;,
    0.164451;0.545260;,
    0.211190;0.566900;,
    0.862320;0.169170;,
    0.996938;0.169170;,
    0.996938;0.215711;,
    0.996938;0.215711;,
    0.862320;0.215711;,
    0.862320;0.169170;,
    0.120021;0.605353;,
    0.090136;0.605353;,
    0.090136;0.617707;,
    0.090136;0.617707;,
    0.120021;0.617707;,
    0.120021;0.605353;,
    0.120021;0.617707;,
    0.120021;0.605353;,
    0.090136;0.605353;,
    0.090136;0.605353;,
    0.090136;0.617707;,
    0.120021;0.617707;,
    0.068303;0.619610;,
    0.092461;0.619610;,
    0.092461;0.556952;,
    0.092461;0.556952;,
    0.068303;0.556952;,
    0.068303;0.619610;,
    0.117648;0.619610;,
    0.141806;0.619610;,
    0.141806;0.556952;,
    0.141806;0.556952;,
    0.117648;0.556952;,
    0.117648;0.619610;,
    0.067959;0.619610;,
    0.142402;0.619610;,
    0.142402;0.556952;,
    0.142402;0.556952;,
    0.067959;0.556952;,
    0.067959;0.619610;,
    0.356949;0.365815;,
    0.596463;0.365815;,
    0.596463;0.332296;,
    0.596463;0.332296;,
    0.356949;0.332296;,
    0.356949;0.365815;,
    0.342183;0.365815;,
    0.596463;0.365815;,
    0.596463;0.328870;,
    0.596463;0.328870;,
    0.342183;0.328870;,
    0.342183;0.365815;,
    0.356949;0.365815;,
    0.596463;0.365815;,
    0.596463;0.332296;,
    0.596463;0.332296;,
    0.356949;0.332296;,
    0.356949;0.365815;,
    0.868845;0.042725;,
    0.868845;0.089407;,
    0.918159;0.089406;,
    0.918159;0.089406;,
    0.918159;0.042725;,
    0.868845;0.042725;,
    0.406069;0.361758;,
    0.378071;0.329495;,
    0.443395;0.329365;,
    0.405928;0.361524;,
    0.443253;0.329131;,
    0.377929;0.329262;,
    0.365863;0.328279;,
    0.365863;0.365298;,
    0.384901;0.365298;,
    0.384901;0.365298;,
    0.384901;0.328279;,
    0.365863;0.328279;,
    0.918158;0.021974;,
    0.868844;0.021975;,
    0.868845;0.042725;,
    0.868845;0.042725;,
    0.918159;0.042725;,
    0.918158;0.021974;,
    0.365823;0.365531;,
    0.365823;0.328512;,
    0.384861;0.328512;,
    0.384861;0.328512;,
    0.384861;0.365531;,
    0.365823;0.365531;,
    0.477424;0.329241;,
    0.449791;0.329241;,
    0.449791;0.341362;,
    0.449791;0.341362;,
    0.477424;0.341362;,
    0.477424;0.329241;,
    0.539590;0.329241;,
    0.477424;0.329241;,
    0.477424;0.341362;,
    0.477424;0.341362;,
    0.539590;0.341362;,
    0.539590;0.329241;,
    0.468140;0.341296;,
    0.539743;0.341296;,
    0.539743;0.329454;,
    0.539743;0.329454;,
    0.468140;0.329454;,
    0.468140;0.341296;,
    0.449922;0.341297;,
    0.468140;0.341296;,
    0.468140;0.329454;,
    0.468140;0.329454;,
    0.449922;0.329454;,
    0.449922;0.341297;,
    0.473261;0.363123;,
    0.519260;0.363561;,
    0.510203;0.352664;,
    0.510203;0.352664;,
    0.464204;0.352226;,
    0.473261;0.363123;,
    0.479053;0.341565;,
    0.479053;0.329444;,
    0.453744;0.329444;,
    0.453744;0.329444;,
    0.453744;0.341565;,
    0.479053;0.341565;,
    0.519260;0.363561;,
    0.473261;0.363123;,
    0.464204;0.352226;,
    0.464204;0.352226;,
    0.510203;0.352664;,
    0.519260;0.363561;,
    0.531060;0.353557;,
    0.519260;0.363561;,
    0.510203;0.352664;,
    0.510203;0.352664;,
    0.522003;0.342660;,
    0.531060;0.353557;,
    0.519260;0.363561;,
    0.531060;0.353557;,
    0.522003;0.342660;,
    0.522003;0.342660;,
    0.510203;0.352664;,
    0.519260;0.363561;,
    0.519260;0.363561;,
    0.473261;0.363123;,
    0.464204;0.352226;,
    0.464204;0.352226;,
    0.510203;0.352664;,
    0.519260;0.363561;,
    0.531060;0.353557;,
    0.519260;0.363561;,
    0.510203;0.352664;,
    0.510203;0.352664;,
    0.522003;0.342660;,
    0.531060;0.353557;,
    0.519260;0.363561;,
    0.531060;0.353557;,
    0.522003;0.342660;,
    0.522003;0.342660;,
    0.510203;0.352664;,
    0.519260;0.363561;,
    0.473261;0.363123;,
    0.519260;0.363561;,
    0.510203;0.352664;,
    0.510203;0.352664;,
    0.464204;0.352226;,
    0.473261;0.363123;,
    0.479185;0.341056;,
    0.479185;0.328935;,
    0.453875;0.328935;,
    0.453875;0.328935;,
    0.453875;0.341056;,
    0.479185;0.341056;,
    0.596463;0.365815;,
    0.342183;0.365815;,
    0.596463;0.328870;,
    0.342183;0.328870;,
    0.596463;0.328870;,
    0.342183;0.365815;,
    0.596463;0.302833;,
    0.534136;0.302833;,
    0.534136;0.332296;,
    0.534136;0.332296;,
    0.596463;0.332296;,
    0.596463;0.302833;,
    0.912154;0.171723;,
    0.969252;0.199317;,
    0.969252;0.171723;,
    0.456820;0.382635;,
    0.343851;0.382635;,
    0.400336;0.466555;,
    0.912154;0.171723;,
    0.969252;0.171723;,
    0.969252;0.199808;,
    0.281222;0.678563;,
    0.143168;0.678563;,
    0.281222;0.545711;,
    0.143168;0.545711;,
    0.281222;0.545711;,
    0.143168;0.678563;,
    0.164451;0.545260;,
    0.257929;0.545260;,
    0.211190;0.566900;;
   }
  }
 }
}