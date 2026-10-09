module fft_twiddle_rom (
    output [8191:0] tw_real,
    output [8191:0] tw_imag
);

    assign tw_real[15:0] = 16'h7FFF;
    assign tw_imag[15:0] = 16'h0000;

    assign tw_real[31:16] = 16'h7FFF;
    assign tw_imag[31:16] = 16'hFF37;

    assign tw_real[47:32] = 16'h7FFE;
    assign tw_imag[47:32] = 16'hFE6E;

    assign tw_real[63:48] = 16'h7FFA;
    assign tw_imag[63:48] = 16'hFDA5;

    assign tw_real[79:64] = 16'h7FF6;
    assign tw_imag[79:64] = 16'hFCDC;

    assign tw_real[95:80] = 16'h7FF1;
    assign tw_imag[95:80] = 16'hFC13;

    assign tw_real[111:96] = 16'h7FEA;
    assign tw_imag[111:96] = 16'hFB4A;

    assign tw_real[127:112] = 16'h7FE2;
    assign tw_imag[127:112] = 16'hFA81;

    assign tw_real[143:128] = 16'h7FD9;
    assign tw_imag[143:128] = 16'hF9B8;

    assign tw_real[159:144] = 16'h7FCE;
    assign tw_imag[159:144] = 16'hF8EF;

    assign tw_real[175:160] = 16'h7FC2;
    assign tw_imag[175:160] = 16'hF827;

    assign tw_real[191:176] = 16'h7FB5;
    assign tw_imag[191:176] = 16'hF75E;

    assign tw_real[207:192] = 16'h7FA7;
    assign tw_imag[207:192] = 16'hF695;

    assign tw_real[223:208] = 16'h7F98;
    assign tw_imag[223:208] = 16'hF5CD;

    assign tw_real[239:224] = 16'h7F87;
    assign tw_imag[239:224] = 16'hF505;

    assign tw_real[255:240] = 16'h7F75;
    assign tw_imag[255:240] = 16'hF43C;

    assign tw_real[271:256] = 16'h7F62;
    assign tw_imag[271:256] = 16'hF374;

    assign tw_real[287:272] = 16'h7F4E;
    assign tw_imag[287:272] = 16'hF2AC;

    assign tw_real[303:288] = 16'h7F38;
    assign tw_imag[303:288] = 16'hF1E4;

    assign tw_real[319:304] = 16'h7F22;
    assign tw_imag[319:304] = 16'hF11C;

    assign tw_real[335:320] = 16'h7F0A;
    assign tw_imag[335:320] = 16'hF055;

    assign tw_real[351:336] = 16'h7EF0;
    assign tw_imag[351:336] = 16'hEF8D;

    assign tw_real[367:352] = 16'h7ED6;
    assign tw_imag[367:352] = 16'hEEC6;

    assign tw_real[383:368] = 16'h7EBA;
    assign tw_imag[383:368] = 16'hEDFF;

    assign tw_real[399:384] = 16'h7E9D;
    assign tw_imag[399:384] = 16'hED38;

    assign tw_real[415:400] = 16'h7E7F;
    assign tw_imag[415:400] = 16'hEC71;

    assign tw_real[431:416] = 16'h7E60;
    assign tw_imag[431:416] = 16'hEBAB;

    assign tw_real[447:432] = 16'h7E3F;
    assign tw_imag[447:432] = 16'hEAE4;

    assign tw_real[463:448] = 16'h7E1E;
    assign tw_imag[463:448] = 16'hEA1E;

    assign tw_real[479:464] = 16'h7DFB;
    assign tw_imag[479:464] = 16'hE958;

    assign tw_real[495:480] = 16'h7DD6;
    assign tw_imag[495:480] = 16'hE892;

    assign tw_real[511:496] = 16'h7DB1;
    assign tw_imag[511:496] = 16'hE7CD;

    assign tw_real[527:512] = 16'h7D8A;
    assign tw_imag[527:512] = 16'hE707;

    assign tw_real[543:528] = 16'h7D63;
    assign tw_imag[543:528] = 16'hE642;

    assign tw_real[559:544] = 16'h7D3A;
    assign tw_imag[559:544] = 16'hE57D;

    assign tw_real[575:560] = 16'h7D0F;
    assign tw_imag[575:560] = 16'hE4B9;

    assign tw_real[591:576] = 16'h7CE4;
    assign tw_imag[591:576] = 16'hE3F4;

    assign tw_real[607:592] = 16'h7CB7;
    assign tw_imag[607:592] = 16'hE330;

    assign tw_real[623:608] = 16'h7C89;
    assign tw_imag[623:608] = 16'hE26D;

    assign tw_real[639:624] = 16'h7C5A;
    assign tw_imag[639:624] = 16'hE1A9;

    assign tw_real[655:640] = 16'h7C2A;
    assign tw_imag[655:640] = 16'hE0E6;

    assign tw_real[671:656] = 16'h7BF9;
    assign tw_imag[671:656] = 16'hE023;

    assign tw_real[687:672] = 16'h7BC6;
    assign tw_imag[687:672] = 16'hDF61;

    assign tw_real[703:688] = 16'h7B92;
    assign tw_imag[703:688] = 16'hDE9E;

    assign tw_real[719:704] = 16'h7B5D;
    assign tw_imag[719:704] = 16'hDDDC;

    assign tw_real[735:720] = 16'h7B27;
    assign tw_imag[735:720] = 16'hDD1B;

    assign tw_real[751:736] = 16'h7AEF;
    assign tw_imag[751:736] = 16'hDC59;

    assign tw_real[767:752] = 16'h7AB7;
    assign tw_imag[767:752] = 16'hDB99;

    assign tw_real[783:768] = 16'h7A7D;
    assign tw_imag[783:768] = 16'hDAD8;

    assign tw_real[799:784] = 16'h7A42;
    assign tw_imag[799:784] = 16'hDA18;

    assign tw_real[815:800] = 16'h7A06;
    assign tw_imag[815:800] = 16'hD958;

    assign tw_real[831:816] = 16'h79C9;
    assign tw_imag[831:816] = 16'hD898;

    assign tw_real[847:832] = 16'h798A;
    assign tw_imag[847:832] = 16'hD7D9;

    assign tw_real[863:848] = 16'h794A;
    assign tw_imag[863:848] = 16'hD71B;

    assign tw_real[879:864] = 16'h790A;
    assign tw_imag[879:864] = 16'hD65C;

    assign tw_real[895:880] = 16'h78C8;
    assign tw_imag[895:880] = 16'hD59E;

    assign tw_real[911:896] = 16'h7885;
    assign tw_imag[911:896] = 16'hD4E1;

    assign tw_real[927:912] = 16'h7840;
    assign tw_imag[927:912] = 16'hD424;

    assign tw_real[943:928] = 16'h77FB;
    assign tw_imag[943:928] = 16'hD367;

    assign tw_real[959:944] = 16'h77B4;
    assign tw_imag[959:944] = 16'hD2AB;

    assign tw_real[975:960] = 16'h776C;
    assign tw_imag[975:960] = 16'hD1EF;

    assign tw_real[991:976] = 16'h7723;
    assign tw_imag[991:976] = 16'hD134;

    assign tw_real[1007:992] = 16'h76D9;
    assign tw_imag[1007:992] = 16'hD079;

    assign tw_real[1023:1008] = 16'h768E;
    assign tw_imag[1023:1008] = 16'hCFBE;

    assign tw_real[1039:1024] = 16'h7642;
    assign tw_imag[1039:1024] = 16'hCF04;

    assign tw_real[1055:1040] = 16'h75F4;
    assign tw_imag[1055:1040] = 16'hCE4B;

    assign tw_real[1071:1056] = 16'h75A6;
    assign tw_imag[1071:1056] = 16'hCD92;

    assign tw_real[1087:1072] = 16'h7556;
    assign tw_imag[1087:1072] = 16'hCCD9;

    assign tw_real[1103:1088] = 16'h7505;
    assign tw_imag[1103:1088] = 16'hCC21;

    assign tw_real[1119:1104] = 16'h74B3;
    assign tw_imag[1119:1104] = 16'hCB69;

    assign tw_real[1135:1120] = 16'h7460;
    assign tw_imag[1135:1120] = 16'hCAB2;

    assign tw_real[1151:1136] = 16'h740B;
    assign tw_imag[1151:1136] = 16'hC9FC;

    assign tw_real[1167:1152] = 16'h73B6;
    assign tw_imag[1167:1152] = 16'hC946;

    assign tw_real[1183:1168] = 16'h735F;
    assign tw_imag[1183:1168] = 16'hC890;

    assign tw_real[1199:1184] = 16'h7308;
    assign tw_imag[1199:1184] = 16'hC7DB;

    assign tw_real[1215:1200] = 16'h72AF;
    assign tw_imag[1215:1200] = 16'hC727;

    assign tw_real[1231:1216] = 16'h7255;
    assign tw_imag[1231:1216] = 16'hC673;

    assign tw_real[1247:1232] = 16'h71FA;
    assign tw_imag[1247:1232] = 16'hC5C0;

    assign tw_real[1263:1248] = 16'h719E;
    assign tw_imag[1263:1248] = 16'hC50D;

    assign tw_real[1279:1264] = 16'h7141;
    assign tw_imag[1279:1264] = 16'hC45B;

    assign tw_real[1295:1280] = 16'h70E3;
    assign tw_imag[1295:1280] = 16'hC3A9;

    assign tw_real[1311:1296] = 16'h7083;
    assign tw_imag[1311:1296] = 16'hC2F8;

    assign tw_real[1327:1312] = 16'h7023;
    assign tw_imag[1327:1312] = 16'hC248;

    assign tw_real[1343:1328] = 16'h6FC2;
    assign tw_imag[1343:1328] = 16'hC198;

    assign tw_real[1359:1344] = 16'h6F5F;
    assign tw_imag[1359:1344] = 16'hC0E9;

    assign tw_real[1375:1360] = 16'h6EFB;
    assign tw_imag[1375:1360] = 16'hC03A;

    assign tw_real[1391:1376] = 16'h6E97;
    assign tw_imag[1391:1376] = 16'hBF8C;

    assign tw_real[1407:1392] = 16'h6E31;
    assign tw_imag[1407:1392] = 16'hBEDF;

    assign tw_real[1423:1408] = 16'h6DCA;
    assign tw_imag[1423:1408] = 16'hBE32;

    assign tw_real[1439:1424] = 16'h6D62;
    assign tw_imag[1439:1424] = 16'hBD86;

    assign tw_real[1455:1440] = 16'h6CF9;
    assign tw_imag[1455:1440] = 16'hBCDA;

    assign tw_real[1471:1456] = 16'h6C8F;
    assign tw_imag[1471:1456] = 16'hBC2F;

    assign tw_real[1487:1472] = 16'h6C24;
    assign tw_imag[1487:1472] = 16'hBB85;

    assign tw_real[1503:1488] = 16'h6BB8;
    assign tw_imag[1503:1488] = 16'hBADC;

    assign tw_real[1519:1504] = 16'h6B4B;
    assign tw_imag[1519:1504] = 16'hBA33;

    assign tw_real[1535:1520] = 16'h6ADD;
    assign tw_imag[1535:1520] = 16'hB98B;

    assign tw_real[1551:1536] = 16'h6A6E;
    assign tw_imag[1551:1536] = 16'hB8E3;

    assign tw_real[1567:1552] = 16'h69FD;
    assign tw_imag[1567:1552] = 16'hB83C;

    assign tw_real[1583:1568] = 16'h698C;
    assign tw_imag[1583:1568] = 16'hB796;

    assign tw_real[1599:1584] = 16'h691A;
    assign tw_imag[1599:1584] = 16'hB6F1;

    assign tw_real[1615:1600] = 16'h68A7;
    assign tw_imag[1615:1600] = 16'hB64C;

    assign tw_real[1631:1616] = 16'h6832;
    assign tw_imag[1631:1616] = 16'hB5A8;

    assign tw_real[1647:1632] = 16'h67BD;
    assign tw_imag[1647:1632] = 16'hB505;

    assign tw_real[1663:1648] = 16'h6747;
    assign tw_imag[1663:1648] = 16'hB462;

    assign tw_real[1679:1664] = 16'h66D0;
    assign tw_imag[1679:1664] = 16'hB3C0;

    assign tw_real[1695:1680] = 16'h6657;
    assign tw_imag[1695:1680] = 16'hB31F;

    assign tw_real[1711:1696] = 16'h65DE;
    assign tw_imag[1711:1696] = 16'hB27F;

    assign tw_real[1727:1712] = 16'h6564;
    assign tw_imag[1727:1712] = 16'hB1DF;

    assign tw_real[1743:1728] = 16'h64E9;
    assign tw_imag[1743:1728] = 16'hB140;

    assign tw_real[1759:1744] = 16'h646C;
    assign tw_imag[1759:1744] = 16'hB0A2;

    assign tw_real[1775:1760] = 16'h63EF;
    assign tw_imag[1775:1760] = 16'hB005;

    assign tw_real[1791:1776] = 16'h6371;
    assign tw_imag[1791:1776] = 16'hAF68;

    assign tw_real[1807:1792] = 16'h62F2;
    assign tw_imag[1807:1792] = 16'hAECC;

    assign tw_real[1823:1808] = 16'h6272;
    assign tw_imag[1823:1808] = 16'hAE31;

    assign tw_real[1839:1824] = 16'h61F1;
    assign tw_imag[1839:1824] = 16'hAD97;

    assign tw_real[1855:1840] = 16'h616F;
    assign tw_imag[1855:1840] = 16'hACFD;

    assign tw_real[1871:1856] = 16'h60EC;
    assign tw_imag[1871:1856] = 16'hAC65;

    assign tw_real[1887:1872] = 16'h6068;
    assign tw_imag[1887:1872] = 16'hABCD;

    assign tw_real[1903:1888] = 16'h5FE4;
    assign tw_imag[1903:1888] = 16'hAB36;

    assign tw_real[1919:1904] = 16'h5F5E;
    assign tw_imag[1919:1904] = 16'hAAA0;

    assign tw_real[1935:1920] = 16'h5ED7;
    assign tw_imag[1935:1920] = 16'hAA0A;

    assign tw_real[1951:1936] = 16'h5E50;
    assign tw_imag[1951:1936] = 16'hA976;

    assign tw_real[1967:1952] = 16'h5DC8;
    assign tw_imag[1967:1952] = 16'hA8E2;

    assign tw_real[1983:1968] = 16'h5D3E;
    assign tw_imag[1983:1968] = 16'hA84F;

    assign tw_real[1999:1984] = 16'h5CB4;
    assign tw_imag[1999:1984] = 16'hA7BD;

    assign tw_real[2015:2000] = 16'h5C29;
    assign tw_imag[2015:2000] = 16'hA72C;

    assign tw_real[2031:2016] = 16'h5B9D;
    assign tw_imag[2031:2016] = 16'hA69C;

    assign tw_real[2047:2032] = 16'h5B10;
    assign tw_imag[2047:2032] = 16'hA60C;

    assign tw_real[2063:2048] = 16'h5A82;
    assign tw_imag[2063:2048] = 16'hA57E;

    assign tw_real[2079:2064] = 16'h59F4;
    assign tw_imag[2079:2064] = 16'hA4F0;

    assign tw_real[2095:2080] = 16'h5964;
    assign tw_imag[2095:2080] = 16'hA463;

    assign tw_real[2111:2096] = 16'h58D4;
    assign tw_imag[2111:2096] = 16'hA3D7;

    assign tw_real[2127:2112] = 16'h5843;
    assign tw_imag[2127:2112] = 16'hA34C;

    assign tw_real[2143:2128] = 16'h57B1;
    assign tw_imag[2143:2128] = 16'hA2C2;

    assign tw_real[2159:2144] = 16'h571E;
    assign tw_imag[2159:2144] = 16'hA238;

    assign tw_real[2175:2160] = 16'h568A;
    assign tw_imag[2175:2160] = 16'hA1B0;

    assign tw_real[2191:2176] = 16'h55F6;
    assign tw_imag[2191:2176] = 16'hA129;

    assign tw_real[2207:2192] = 16'h5560;
    assign tw_imag[2207:2192] = 16'hA0A2;

    assign tw_real[2223:2208] = 16'h54CA;
    assign tw_imag[2223:2208] = 16'hA01C;

    assign tw_real[2239:2224] = 16'h5433;
    assign tw_imag[2239:2224] = 16'h9F98;

    assign tw_real[2255:2240] = 16'h539B;
    assign tw_imag[2255:2240] = 16'h9F14;

    assign tw_real[2271:2256] = 16'h5303;
    assign tw_imag[2271:2256] = 16'h9E91;

    assign tw_real[2287:2272] = 16'h5269;
    assign tw_imag[2287:2272] = 16'h9E0F;

    assign tw_real[2303:2288] = 16'h51CF;
    assign tw_imag[2303:2288] = 16'h9D8E;

    assign tw_real[2319:2304] = 16'h5134;
    assign tw_imag[2319:2304] = 16'h9D0E;

    assign tw_real[2335:2320] = 16'h5098;
    assign tw_imag[2335:2320] = 16'h9C8F;

    assign tw_real[2351:2336] = 16'h4FFB;
    assign tw_imag[2351:2336] = 16'h9C11;

    assign tw_real[2367:2352] = 16'h4F5E;
    assign tw_imag[2367:2352] = 16'h9B94;

    assign tw_real[2383:2368] = 16'h4EC0;
    assign tw_imag[2383:2368] = 16'h9B17;

    assign tw_real[2399:2384] = 16'h4E21;
    assign tw_imag[2399:2384] = 16'h9A9C;

    assign tw_real[2415:2400] = 16'h4D81;
    assign tw_imag[2415:2400] = 16'h9A22;

    assign tw_real[2431:2416] = 16'h4CE1;
    assign tw_imag[2431:2416] = 16'h99A9;

    assign tw_real[2447:2432] = 16'h4C40;
    assign tw_imag[2447:2432] = 16'h9930;

    assign tw_real[2463:2448] = 16'h4B9E;
    assign tw_imag[2463:2448] = 16'h98B9;

    assign tw_real[2479:2464] = 16'h4AFB;
    assign tw_imag[2479:2464] = 16'h9843;

    assign tw_real[2495:2480] = 16'h4A58;
    assign tw_imag[2495:2480] = 16'h97CE;

    assign tw_real[2511:2496] = 16'h49B4;
    assign tw_imag[2511:2496] = 16'h9759;

    assign tw_real[2527:2512] = 16'h490F;
    assign tw_imag[2527:2512] = 16'h96E6;

    assign tw_real[2543:2528] = 16'h486A;
    assign tw_imag[2543:2528] = 16'h9674;

    assign tw_real[2559:2544] = 16'h47C4;
    assign tw_imag[2559:2544] = 16'h9603;

    assign tw_real[2575:2560] = 16'h471D;
    assign tw_imag[2575:2560] = 16'h9592;

    assign tw_real[2591:2576] = 16'h4675;
    assign tw_imag[2591:2576] = 16'h9523;

    assign tw_real[2607:2592] = 16'h45CD;
    assign tw_imag[2607:2592] = 16'h94B5;

    assign tw_real[2623:2608] = 16'h4524;
    assign tw_imag[2623:2608] = 16'h9448;

    assign tw_real[2639:2624] = 16'h447B;
    assign tw_imag[2639:2624] = 16'h93DC;

    assign tw_real[2655:2640] = 16'h43D1;
    assign tw_imag[2655:2640] = 16'h9371;

    assign tw_real[2671:2656] = 16'h4326;
    assign tw_imag[2671:2656] = 16'h9307;

    assign tw_real[2687:2672] = 16'h427A;
    assign tw_imag[2687:2672] = 16'h929E;

    assign tw_real[2703:2688] = 16'h41CE;
    assign tw_imag[2703:2688] = 16'h9236;

    assign tw_real[2719:2704] = 16'h4121;
    assign tw_imag[2719:2704] = 16'h91CF;

    assign tw_real[2735:2720] = 16'h4074;
    assign tw_imag[2735:2720] = 16'h9169;

    assign tw_real[2751:2736] = 16'h3FC6;
    assign tw_imag[2751:2736] = 16'h9105;

    assign tw_real[2767:2752] = 16'h3F17;
    assign tw_imag[2767:2752] = 16'h90A1;

    assign tw_real[2783:2768] = 16'h3E68;
    assign tw_imag[2783:2768] = 16'h903E;

    assign tw_real[2799:2784] = 16'h3DB8;
    assign tw_imag[2799:2784] = 16'h8FDD;

    assign tw_real[2815:2800] = 16'h3D08;
    assign tw_imag[2815:2800] = 16'h8F7D;

    assign tw_real[2831:2816] = 16'h3C57;
    assign tw_imag[2831:2816] = 16'h8F1D;

    assign tw_real[2847:2832] = 16'h3BA5;
    assign tw_imag[2847:2832] = 16'h8EBF;

    assign tw_real[2863:2848] = 16'h3AF3;
    assign tw_imag[2863:2848] = 16'h8E62;

    assign tw_real[2879:2864] = 16'h3A40;
    assign tw_imag[2879:2864] = 16'h8E06;

    assign tw_real[2895:2880] = 16'h398D;
    assign tw_imag[2895:2880] = 16'h8DAB;

    assign tw_real[2911:2896] = 16'h38D9;
    assign tw_imag[2911:2896] = 16'h8D51;

    assign tw_real[2927:2912] = 16'h3825;
    assign tw_imag[2927:2912] = 16'h8CF8;

    assign tw_real[2943:2928] = 16'h3770;
    assign tw_imag[2943:2928] = 16'h8CA1;

    assign tw_real[2959:2944] = 16'h36BA;
    assign tw_imag[2959:2944] = 16'h8C4A;

    assign tw_real[2975:2960] = 16'h3604;
    assign tw_imag[2975:2960] = 16'h8BF5;

    assign tw_real[2991:2976] = 16'h354E;
    assign tw_imag[2991:2976] = 16'h8BA0;

    assign tw_real[3007:2992] = 16'h3497;
    assign tw_imag[3007:2992] = 16'h8B4D;

    assign tw_real[3023:3008] = 16'h33DF;
    assign tw_imag[3023:3008] = 16'h8AFB;

    assign tw_real[3039:3024] = 16'h3327;
    assign tw_imag[3039:3024] = 16'h8AAA;

    assign tw_real[3055:3040] = 16'h326E;
    assign tw_imag[3055:3040] = 16'h8A5A;

    assign tw_real[3071:3056] = 16'h31B5;
    assign tw_imag[3071:3056] = 16'h8A0C;

    assign tw_real[3087:3072] = 16'h30FC;
    assign tw_imag[3087:3072] = 16'h89BE;

    assign tw_real[3103:3088] = 16'h3042;
    assign tw_imag[3103:3088] = 16'h8972;

    assign tw_real[3119:3104] = 16'h2F87;
    assign tw_imag[3119:3104] = 16'h8927;

    assign tw_real[3135:3120] = 16'h2ECC;
    assign tw_imag[3135:3120] = 16'h88DD;

    assign tw_real[3151:3136] = 16'h2E11;
    assign tw_imag[3151:3136] = 16'h8894;

    assign tw_real[3167:3152] = 16'h2D55;
    assign tw_imag[3167:3152] = 16'h884C;

    assign tw_real[3183:3168] = 16'h2C99;
    assign tw_imag[3183:3168] = 16'h8805;

    assign tw_real[3199:3184] = 16'h2BDC;
    assign tw_imag[3199:3184] = 16'h87C0;

    assign tw_real[3215:3200] = 16'h2B1F;
    assign tw_imag[3215:3200] = 16'h877B;

    assign tw_real[3231:3216] = 16'h2A62;
    assign tw_imag[3231:3216] = 16'h8738;

    assign tw_real[3247:3232] = 16'h29A4;
    assign tw_imag[3247:3232] = 16'h86F6;

    assign tw_real[3263:3248] = 16'h28E5;
    assign tw_imag[3263:3248] = 16'h86B6;

    assign tw_real[3279:3264] = 16'h2827;
    assign tw_imag[3279:3264] = 16'h8676;

    assign tw_real[3295:3280] = 16'h2768;
    assign tw_imag[3295:3280] = 16'h8637;

    assign tw_real[3311:3296] = 16'h26A8;
    assign tw_imag[3311:3296] = 16'h85FA;

    assign tw_real[3327:3312] = 16'h25E8;
    assign tw_imag[3327:3312] = 16'h85BE;

    assign tw_real[3343:3328] = 16'h2528;
    assign tw_imag[3343:3328] = 16'h8583;

    assign tw_real[3359:3344] = 16'h2467;
    assign tw_imag[3359:3344] = 16'h8549;

    assign tw_real[3375:3360] = 16'h23A7;
    assign tw_imag[3375:3360] = 16'h8511;

    assign tw_real[3391:3376] = 16'h22E5;
    assign tw_imag[3391:3376] = 16'h84D9;

    assign tw_real[3407:3392] = 16'h2224;
    assign tw_imag[3407:3392] = 16'h84A3;

    assign tw_real[3423:3408] = 16'h2162;
    assign tw_imag[3423:3408] = 16'h846E;

    assign tw_real[3439:3424] = 16'h209F;
    assign tw_imag[3439:3424] = 16'h843A;

    assign tw_real[3455:3440] = 16'h1FDD;
    assign tw_imag[3455:3440] = 16'h8407;

    assign tw_real[3471:3456] = 16'h1F1A;
    assign tw_imag[3471:3456] = 16'h83D6;

    assign tw_real[3487:3472] = 16'h1E57;
    assign tw_imag[3487:3472] = 16'h83A6;

    assign tw_real[3503:3488] = 16'h1D93;
    assign tw_imag[3503:3488] = 16'h8377;

    assign tw_real[3519:3504] = 16'h1CD0;
    assign tw_imag[3519:3504] = 16'h8349;

    assign tw_real[3535:3520] = 16'h1C0C;
    assign tw_imag[3535:3520] = 16'h831C;

    assign tw_real[3551:3536] = 16'h1B47;
    assign tw_imag[3551:3536] = 16'h82F1;

    assign tw_real[3567:3552] = 16'h1A83;
    assign tw_imag[3567:3552] = 16'h82C6;

    assign tw_real[3583:3568] = 16'h19BE;
    assign tw_imag[3583:3568] = 16'h829D;

    assign tw_real[3599:3584] = 16'h18F9;
    assign tw_imag[3599:3584] = 16'h8276;

    assign tw_real[3615:3600] = 16'h1833;
    assign tw_imag[3615:3600] = 16'h824F;

    assign tw_real[3631:3616] = 16'h176E;
    assign tw_imag[3631:3616] = 16'h822A;

    assign tw_real[3647:3632] = 16'h16A8;
    assign tw_imag[3647:3632] = 16'h8205;

    assign tw_real[3663:3648] = 16'h15E2;
    assign tw_imag[3663:3648] = 16'h81E2;

    assign tw_real[3679:3664] = 16'h151C;
    assign tw_imag[3679:3664] = 16'h81C1;

    assign tw_real[3695:3680] = 16'h1455;
    assign tw_imag[3695:3680] = 16'h81A0;

    assign tw_real[3711:3696] = 16'h138F;
    assign tw_imag[3711:3696] = 16'h8181;

    assign tw_real[3727:3712] = 16'h12C8;
    assign tw_imag[3727:3712] = 16'h8163;

    assign tw_real[3743:3728] = 16'h1201;
    assign tw_imag[3743:3728] = 16'h8146;

    assign tw_real[3759:3744] = 16'h113A;
    assign tw_imag[3759:3744] = 16'h812A;

    assign tw_real[3775:3760] = 16'h1073;
    assign tw_imag[3775:3760] = 16'h8110;

    assign tw_real[3791:3776] = 16'h0FAB;
    assign tw_imag[3791:3776] = 16'h80F6;

    assign tw_real[3807:3792] = 16'h0EE4;
    assign tw_imag[3807:3792] = 16'h80DE;

    assign tw_real[3823:3808] = 16'h0E1C;
    assign tw_imag[3823:3808] = 16'h80C8;

    assign tw_real[3839:3824] = 16'h0D54;
    assign tw_imag[3839:3824] = 16'h80B2;

    assign tw_real[3855:3840] = 16'h0C8C;
    assign tw_imag[3855:3840] = 16'h809E;

    assign tw_real[3871:3856] = 16'h0BC4;
    assign tw_imag[3871:3856] = 16'h808B;

    assign tw_real[3887:3872] = 16'h0AFB;
    assign tw_imag[3887:3872] = 16'h8079;

    assign tw_real[3903:3888] = 16'h0A33;
    assign tw_imag[3903:3888] = 16'h8068;

    assign tw_real[3919:3904] = 16'h096B;
    assign tw_imag[3919:3904] = 16'h8059;

    assign tw_real[3935:3920] = 16'h08A2;
    assign tw_imag[3935:3920] = 16'h804B;

    assign tw_real[3951:3936] = 16'h07D9;
    assign tw_imag[3951:3936] = 16'h803E;

    assign tw_real[3967:3952] = 16'h0711;
    assign tw_imag[3967:3952] = 16'h8032;

    assign tw_real[3983:3968] = 16'h0648;
    assign tw_imag[3983:3968] = 16'h8027;

    assign tw_real[3999:3984] = 16'h057F;
    assign tw_imag[3999:3984] = 16'h801E;

    assign tw_real[4015:4000] = 16'h04B6;
    assign tw_imag[4015:4000] = 16'h8016;

    assign tw_real[4031:4016] = 16'h03ED;
    assign tw_imag[4031:4016] = 16'h800F;

    assign tw_real[4047:4032] = 16'h0324;
    assign tw_imag[4047:4032] = 16'h800A;

    assign tw_real[4063:4048] = 16'h025B;
    assign tw_imag[4063:4048] = 16'h8006;

    assign tw_real[4079:4064] = 16'h0192;
    assign tw_imag[4079:4064] = 16'h8002;

    assign tw_real[4095:4080] = 16'h00C9;
    assign tw_imag[4095:4080] = 16'h8001;

    assign tw_real[4111:4096] = 16'h0000;
    assign tw_imag[4111:4096] = 16'h8000;

    assign tw_real[4127:4112] = 16'hFF37;
    assign tw_imag[4127:4112] = 16'h8001;

    assign tw_real[4143:4128] = 16'hFE6E;
    assign tw_imag[4143:4128] = 16'h8002;

    assign tw_real[4159:4144] = 16'hFDA5;
    assign tw_imag[4159:4144] = 16'h8006;

    assign tw_real[4175:4160] = 16'hFCDC;
    assign tw_imag[4175:4160] = 16'h800A;

    assign tw_real[4191:4176] = 16'hFC13;
    assign tw_imag[4191:4176] = 16'h800F;

    assign tw_real[4207:4192] = 16'hFB4A;
    assign tw_imag[4207:4192] = 16'h8016;

    assign tw_real[4223:4208] = 16'hFA81;
    assign tw_imag[4223:4208] = 16'h801E;

    assign tw_real[4239:4224] = 16'hF9B8;
    assign tw_imag[4239:4224] = 16'h8027;

    assign tw_real[4255:4240] = 16'hF8EF;
    assign tw_imag[4255:4240] = 16'h8032;

    assign tw_real[4271:4256] = 16'hF827;
    assign tw_imag[4271:4256] = 16'h803E;

    assign tw_real[4287:4272] = 16'hF75E;
    assign tw_imag[4287:4272] = 16'h804B;

    assign tw_real[4303:4288] = 16'hF695;
    assign tw_imag[4303:4288] = 16'h8059;

    assign tw_real[4319:4304] = 16'hF5CD;
    assign tw_imag[4319:4304] = 16'h8068;

    assign tw_real[4335:4320] = 16'hF505;
    assign tw_imag[4335:4320] = 16'h8079;

    assign tw_real[4351:4336] = 16'hF43C;
    assign tw_imag[4351:4336] = 16'h808B;

    assign tw_real[4367:4352] = 16'hF374;
    assign tw_imag[4367:4352] = 16'h809E;

    assign tw_real[4383:4368] = 16'hF2AC;
    assign tw_imag[4383:4368] = 16'h80B2;

    assign tw_real[4399:4384] = 16'hF1E4;
    assign tw_imag[4399:4384] = 16'h80C8;

    assign tw_real[4415:4400] = 16'hF11C;
    assign tw_imag[4415:4400] = 16'h80DE;

    assign tw_real[4431:4416] = 16'hF055;
    assign tw_imag[4431:4416] = 16'h80F6;

    assign tw_real[4447:4432] = 16'hEF8D;
    assign tw_imag[4447:4432] = 16'h8110;

    assign tw_real[4463:4448] = 16'hEEC6;
    assign tw_imag[4463:4448] = 16'h812A;

    assign tw_real[4479:4464] = 16'hEDFF;
    assign tw_imag[4479:4464] = 16'h8146;

    assign tw_real[4495:4480] = 16'hED38;
    assign tw_imag[4495:4480] = 16'h8163;

    assign tw_real[4511:4496] = 16'hEC71;
    assign tw_imag[4511:4496] = 16'h8181;

    assign tw_real[4527:4512] = 16'hEBAB;
    assign tw_imag[4527:4512] = 16'h81A0;

    assign tw_real[4543:4528] = 16'hEAE4;
    assign tw_imag[4543:4528] = 16'h81C1;

    assign tw_real[4559:4544] = 16'hEA1E;
    assign tw_imag[4559:4544] = 16'h81E2;

    assign tw_real[4575:4560] = 16'hE958;
    assign tw_imag[4575:4560] = 16'h8205;

    assign tw_real[4591:4576] = 16'hE892;
    assign tw_imag[4591:4576] = 16'h822A;

    assign tw_real[4607:4592] = 16'hE7CD;
    assign tw_imag[4607:4592] = 16'h824F;

    assign tw_real[4623:4608] = 16'hE707;
    assign tw_imag[4623:4608] = 16'h8276;

    assign tw_real[4639:4624] = 16'hE642;
    assign tw_imag[4639:4624] = 16'h829D;

    assign tw_real[4655:4640] = 16'hE57D;
    assign tw_imag[4655:4640] = 16'h82C6;

    assign tw_real[4671:4656] = 16'hE4B9;
    assign tw_imag[4671:4656] = 16'h82F1;

    assign tw_real[4687:4672] = 16'hE3F4;
    assign tw_imag[4687:4672] = 16'h831C;

    assign tw_real[4703:4688] = 16'hE330;
    assign tw_imag[4703:4688] = 16'h8349;

    assign tw_real[4719:4704] = 16'hE26D;
    assign tw_imag[4719:4704] = 16'h8377;

    assign tw_real[4735:4720] = 16'hE1A9;
    assign tw_imag[4735:4720] = 16'h83A6;

    assign tw_real[4751:4736] = 16'hE0E6;
    assign tw_imag[4751:4736] = 16'h83D6;

    assign tw_real[4767:4752] = 16'hE023;
    assign tw_imag[4767:4752] = 16'h8407;

    assign tw_real[4783:4768] = 16'hDF61;
    assign tw_imag[4783:4768] = 16'h843A;

    assign tw_real[4799:4784] = 16'hDE9E;
    assign tw_imag[4799:4784] = 16'h846E;

    assign tw_real[4815:4800] = 16'hDDDC;
    assign tw_imag[4815:4800] = 16'h84A3;

    assign tw_real[4831:4816] = 16'hDD1B;
    assign tw_imag[4831:4816] = 16'h84D9;

    assign tw_real[4847:4832] = 16'hDC59;
    assign tw_imag[4847:4832] = 16'h8511;

    assign tw_real[4863:4848] = 16'hDB99;
    assign tw_imag[4863:4848] = 16'h8549;

    assign tw_real[4879:4864] = 16'hDAD8;
    assign tw_imag[4879:4864] = 16'h8583;

    assign tw_real[4895:4880] = 16'hDA18;
    assign tw_imag[4895:4880] = 16'h85BE;

    assign tw_real[4911:4896] = 16'hD958;
    assign tw_imag[4911:4896] = 16'h85FA;

    assign tw_real[4927:4912] = 16'hD898;
    assign tw_imag[4927:4912] = 16'h8637;

    assign tw_real[4943:4928] = 16'hD7D9;
    assign tw_imag[4943:4928] = 16'h8676;

    assign tw_real[4959:4944] = 16'hD71B;
    assign tw_imag[4959:4944] = 16'h86B6;

    assign tw_real[4975:4960] = 16'hD65C;
    assign tw_imag[4975:4960] = 16'h86F6;

    assign tw_real[4991:4976] = 16'hD59E;
    assign tw_imag[4991:4976] = 16'h8738;

    assign tw_real[5007:4992] = 16'hD4E1;
    assign tw_imag[5007:4992] = 16'h877B;

    assign tw_real[5023:5008] = 16'hD424;
    assign tw_imag[5023:5008] = 16'h87C0;

    assign tw_real[5039:5024] = 16'hD367;
    assign tw_imag[5039:5024] = 16'h8805;

    assign tw_real[5055:5040] = 16'hD2AB;
    assign tw_imag[5055:5040] = 16'h884C;

    assign tw_real[5071:5056] = 16'hD1EF;
    assign tw_imag[5071:5056] = 16'h8894;

    assign tw_real[5087:5072] = 16'hD134;
    assign tw_imag[5087:5072] = 16'h88DD;

    assign tw_real[5103:5088] = 16'hD079;
    assign tw_imag[5103:5088] = 16'h8927;

    assign tw_real[5119:5104] = 16'hCFBE;
    assign tw_imag[5119:5104] = 16'h8972;

    assign tw_real[5135:5120] = 16'hCF04;
    assign tw_imag[5135:5120] = 16'h89BE;

    assign tw_real[5151:5136] = 16'hCE4B;
    assign tw_imag[5151:5136] = 16'h8A0C;

    assign tw_real[5167:5152] = 16'hCD92;
    assign tw_imag[5167:5152] = 16'h8A5A;

    assign tw_real[5183:5168] = 16'hCCD9;
    assign tw_imag[5183:5168] = 16'h8AAA;

    assign tw_real[5199:5184] = 16'hCC21;
    assign tw_imag[5199:5184] = 16'h8AFB;

    assign tw_real[5215:5200] = 16'hCB69;
    assign tw_imag[5215:5200] = 16'h8B4D;

    assign tw_real[5231:5216] = 16'hCAB2;
    assign tw_imag[5231:5216] = 16'h8BA0;

    assign tw_real[5247:5232] = 16'hC9FC;
    assign tw_imag[5247:5232] = 16'h8BF5;

    assign tw_real[5263:5248] = 16'hC946;
    assign tw_imag[5263:5248] = 16'h8C4A;

    assign tw_real[5279:5264] = 16'hC890;
    assign tw_imag[5279:5264] = 16'h8CA1;

    assign tw_real[5295:5280] = 16'hC7DB;
    assign tw_imag[5295:5280] = 16'h8CF8;

    assign tw_real[5311:5296] = 16'hC727;
    assign tw_imag[5311:5296] = 16'h8D51;

    assign tw_real[5327:5312] = 16'hC673;
    assign tw_imag[5327:5312] = 16'h8DAB;

    assign tw_real[5343:5328] = 16'hC5C0;
    assign tw_imag[5343:5328] = 16'h8E06;

    assign tw_real[5359:5344] = 16'hC50D;
    assign tw_imag[5359:5344] = 16'h8E62;

    assign tw_real[5375:5360] = 16'hC45B;
    assign tw_imag[5375:5360] = 16'h8EBF;

    assign tw_real[5391:5376] = 16'hC3A9;
    assign tw_imag[5391:5376] = 16'h8F1D;

    assign tw_real[5407:5392] = 16'hC2F8;
    assign tw_imag[5407:5392] = 16'h8F7D;

    assign tw_real[5423:5408] = 16'hC248;
    assign tw_imag[5423:5408] = 16'h8FDD;

    assign tw_real[5439:5424] = 16'hC198;
    assign tw_imag[5439:5424] = 16'h903E;

    assign tw_real[5455:5440] = 16'hC0E9;
    assign tw_imag[5455:5440] = 16'h90A1;

    assign tw_real[5471:5456] = 16'hC03A;
    assign tw_imag[5471:5456] = 16'h9105;

    assign tw_real[5487:5472] = 16'hBF8C;
    assign tw_imag[5487:5472] = 16'h9169;

    assign tw_real[5503:5488] = 16'hBEDF;
    assign tw_imag[5503:5488] = 16'h91CF;

    assign tw_real[5519:5504] = 16'hBE32;
    assign tw_imag[5519:5504] = 16'h9236;

    assign tw_real[5535:5520] = 16'hBD86;
    assign tw_imag[5535:5520] = 16'h929E;

    assign tw_real[5551:5536] = 16'hBCDA;
    assign tw_imag[5551:5536] = 16'h9307;

    assign tw_real[5567:5552] = 16'hBC2F;
    assign tw_imag[5567:5552] = 16'h9371;

    assign tw_real[5583:5568] = 16'hBB85;
    assign tw_imag[5583:5568] = 16'h93DC;

    assign tw_real[5599:5584] = 16'hBADC;
    assign tw_imag[5599:5584] = 16'h9448;

    assign tw_real[5615:5600] = 16'hBA33;
    assign tw_imag[5615:5600] = 16'h94B5;

    assign tw_real[5631:5616] = 16'hB98B;
    assign tw_imag[5631:5616] = 16'h9523;

    assign tw_real[5647:5632] = 16'hB8E3;
    assign tw_imag[5647:5632] = 16'h9592;

    assign tw_real[5663:5648] = 16'hB83C;
    assign tw_imag[5663:5648] = 16'h9603;

    assign tw_real[5679:5664] = 16'hB796;
    assign tw_imag[5679:5664] = 16'h9674;

    assign tw_real[5695:5680] = 16'hB6F1;
    assign tw_imag[5695:5680] = 16'h96E6;

    assign tw_real[5711:5696] = 16'hB64C;
    assign tw_imag[5711:5696] = 16'h9759;

    assign tw_real[5727:5712] = 16'hB5A8;
    assign tw_imag[5727:5712] = 16'h97CE;

    assign tw_real[5743:5728] = 16'hB505;
    assign tw_imag[5743:5728] = 16'h9843;

    assign tw_real[5759:5744] = 16'hB462;
    assign tw_imag[5759:5744] = 16'h98B9;

    assign tw_real[5775:5760] = 16'hB3C0;
    assign tw_imag[5775:5760] = 16'h9930;

    assign tw_real[5791:5776] = 16'hB31F;
    assign tw_imag[5791:5776] = 16'h99A9;

    assign tw_real[5807:5792] = 16'hB27F;
    assign tw_imag[5807:5792] = 16'h9A22;

    assign tw_real[5823:5808] = 16'hB1DF;
    assign tw_imag[5823:5808] = 16'h9A9C;

    assign tw_real[5839:5824] = 16'hB140;
    assign tw_imag[5839:5824] = 16'h9B17;

    assign tw_real[5855:5840] = 16'hB0A2;
    assign tw_imag[5855:5840] = 16'h9B94;

    assign tw_real[5871:5856] = 16'hB005;
    assign tw_imag[5871:5856] = 16'h9C11;

    assign tw_real[5887:5872] = 16'hAF68;
    assign tw_imag[5887:5872] = 16'h9C8F;

    assign tw_real[5903:5888] = 16'hAECC;
    assign tw_imag[5903:5888] = 16'h9D0E;

    assign tw_real[5919:5904] = 16'hAE31;
    assign tw_imag[5919:5904] = 16'h9D8E;

    assign tw_real[5935:5920] = 16'hAD97;
    assign tw_imag[5935:5920] = 16'h9E0F;

    assign tw_real[5951:5936] = 16'hACFD;
    assign tw_imag[5951:5936] = 16'h9E91;

    assign tw_real[5967:5952] = 16'hAC65;
    assign tw_imag[5967:5952] = 16'h9F14;

    assign tw_real[5983:5968] = 16'hABCD;
    assign tw_imag[5983:5968] = 16'h9F98;

    assign tw_real[5999:5984] = 16'hAB36;
    assign tw_imag[5999:5984] = 16'hA01C;

    assign tw_real[6015:6000] = 16'hAAA0;
    assign tw_imag[6015:6000] = 16'hA0A2;

    assign tw_real[6031:6016] = 16'hAA0A;
    assign tw_imag[6031:6016] = 16'hA129;

    assign tw_real[6047:6032] = 16'hA976;
    assign tw_imag[6047:6032] = 16'hA1B0;

    assign tw_real[6063:6048] = 16'hA8E2;
    assign tw_imag[6063:6048] = 16'hA238;

    assign tw_real[6079:6064] = 16'hA84F;
    assign tw_imag[6079:6064] = 16'hA2C2;

    assign tw_real[6095:6080] = 16'hA7BD;
    assign tw_imag[6095:6080] = 16'hA34C;

    assign tw_real[6111:6096] = 16'hA72C;
    assign tw_imag[6111:6096] = 16'hA3D7;

    assign tw_real[6127:6112] = 16'hA69C;
    assign tw_imag[6127:6112] = 16'hA463;

    assign tw_real[6143:6128] = 16'hA60C;
    assign tw_imag[6143:6128] = 16'hA4F0;

    assign tw_real[6159:6144] = 16'hA57E;
    assign tw_imag[6159:6144] = 16'hA57E;

    assign tw_real[6175:6160] = 16'hA4F0;
    assign tw_imag[6175:6160] = 16'hA60C;

    assign tw_real[6191:6176] = 16'hA463;
    assign tw_imag[6191:6176] = 16'hA69C;

    assign tw_real[6207:6192] = 16'hA3D7;
    assign tw_imag[6207:6192] = 16'hA72C;

    assign tw_real[6223:6208] = 16'hA34C;
    assign tw_imag[6223:6208] = 16'hA7BD;

    assign tw_real[6239:6224] = 16'hA2C2;
    assign tw_imag[6239:6224] = 16'hA84F;

    assign tw_real[6255:6240] = 16'hA238;
    assign tw_imag[6255:6240] = 16'hA8E2;

    assign tw_real[6271:6256] = 16'hA1B0;
    assign tw_imag[6271:6256] = 16'hA976;

    assign tw_real[6287:6272] = 16'hA129;
    assign tw_imag[6287:6272] = 16'hAA0A;

    assign tw_real[6303:6288] = 16'hA0A2;
    assign tw_imag[6303:6288] = 16'hAAA0;

    assign tw_real[6319:6304] = 16'hA01C;
    assign tw_imag[6319:6304] = 16'hAB36;

    assign tw_real[6335:6320] = 16'h9F98;
    assign tw_imag[6335:6320] = 16'hABCD;

    assign tw_real[6351:6336] = 16'h9F14;
    assign tw_imag[6351:6336] = 16'hAC65;

    assign tw_real[6367:6352] = 16'h9E91;
    assign tw_imag[6367:6352] = 16'hACFD;

    assign tw_real[6383:6368] = 16'h9E0F;
    assign tw_imag[6383:6368] = 16'hAD97;

    assign tw_real[6399:6384] = 16'h9D8E;
    assign tw_imag[6399:6384] = 16'hAE31;

    assign tw_real[6415:6400] = 16'h9D0E;
    assign tw_imag[6415:6400] = 16'hAECC;

    assign tw_real[6431:6416] = 16'h9C8F;
    assign tw_imag[6431:6416] = 16'hAF68;

    assign tw_real[6447:6432] = 16'h9C11;
    assign tw_imag[6447:6432] = 16'hB005;

    assign tw_real[6463:6448] = 16'h9B94;
    assign tw_imag[6463:6448] = 16'hB0A2;

    assign tw_real[6479:6464] = 16'h9B17;
    assign tw_imag[6479:6464] = 16'hB140;

    assign tw_real[6495:6480] = 16'h9A9C;
    assign tw_imag[6495:6480] = 16'hB1DF;

    assign tw_real[6511:6496] = 16'h9A22;
    assign tw_imag[6511:6496] = 16'hB27F;

    assign tw_real[6527:6512] = 16'h99A9;
    assign tw_imag[6527:6512] = 16'hB31F;

    assign tw_real[6543:6528] = 16'h9930;
    assign tw_imag[6543:6528] = 16'hB3C0;

    assign tw_real[6559:6544] = 16'h98B9;
    assign tw_imag[6559:6544] = 16'hB462;

    assign tw_real[6575:6560] = 16'h9843;
    assign tw_imag[6575:6560] = 16'hB505;

    assign tw_real[6591:6576] = 16'h97CE;
    assign tw_imag[6591:6576] = 16'hB5A8;

    assign tw_real[6607:6592] = 16'h9759;
    assign tw_imag[6607:6592] = 16'hB64C;

    assign tw_real[6623:6608] = 16'h96E6;
    assign tw_imag[6623:6608] = 16'hB6F1;

    assign tw_real[6639:6624] = 16'h9674;
    assign tw_imag[6639:6624] = 16'hB796;

    assign tw_real[6655:6640] = 16'h9603;
    assign tw_imag[6655:6640] = 16'hB83C;

    assign tw_real[6671:6656] = 16'h9592;
    assign tw_imag[6671:6656] = 16'hB8E3;

    assign tw_real[6687:6672] = 16'h9523;
    assign tw_imag[6687:6672] = 16'hB98B;

    assign tw_real[6703:6688] = 16'h94B5;
    assign tw_imag[6703:6688] = 16'hBA33;

    assign tw_real[6719:6704] = 16'h9448;
    assign tw_imag[6719:6704] = 16'hBADC;

    assign tw_real[6735:6720] = 16'h93DC;
    assign tw_imag[6735:6720] = 16'hBB85;

    assign tw_real[6751:6736] = 16'h9371;
    assign tw_imag[6751:6736] = 16'hBC2F;

    assign tw_real[6767:6752] = 16'h9307;
    assign tw_imag[6767:6752] = 16'hBCDA;

    assign tw_real[6783:6768] = 16'h929E;
    assign tw_imag[6783:6768] = 16'hBD86;

    assign tw_real[6799:6784] = 16'h9236;
    assign tw_imag[6799:6784] = 16'hBE32;

    assign tw_real[6815:6800] = 16'h91CF;
    assign tw_imag[6815:6800] = 16'hBEDF;

    assign tw_real[6831:6816] = 16'h9169;
    assign tw_imag[6831:6816] = 16'hBF8C;

    assign tw_real[6847:6832] = 16'h9105;
    assign tw_imag[6847:6832] = 16'hC03A;

    assign tw_real[6863:6848] = 16'h90A1;
    assign tw_imag[6863:6848] = 16'hC0E9;

    assign tw_real[6879:6864] = 16'h903E;
    assign tw_imag[6879:6864] = 16'hC198;

    assign tw_real[6895:6880] = 16'h8FDD;
    assign tw_imag[6895:6880] = 16'hC248;

    assign tw_real[6911:6896] = 16'h8F7D;
    assign tw_imag[6911:6896] = 16'hC2F8;

    assign tw_real[6927:6912] = 16'h8F1D;
    assign tw_imag[6927:6912] = 16'hC3A9;

    assign tw_real[6943:6928] = 16'h8EBF;
    assign tw_imag[6943:6928] = 16'hC45B;

    assign tw_real[6959:6944] = 16'h8E62;
    assign tw_imag[6959:6944] = 16'hC50D;

    assign tw_real[6975:6960] = 16'h8E06;
    assign tw_imag[6975:6960] = 16'hC5C0;

    assign tw_real[6991:6976] = 16'h8DAB;
    assign tw_imag[6991:6976] = 16'hC673;

    assign tw_real[7007:6992] = 16'h8D51;
    assign tw_imag[7007:6992] = 16'hC727;

    assign tw_real[7023:7008] = 16'h8CF8;
    assign tw_imag[7023:7008] = 16'hC7DB;

    assign tw_real[7039:7024] = 16'h8CA1;
    assign tw_imag[7039:7024] = 16'hC890;

    assign tw_real[7055:7040] = 16'h8C4A;
    assign tw_imag[7055:7040] = 16'hC946;

    assign tw_real[7071:7056] = 16'h8BF5;
    assign tw_imag[7071:7056] = 16'hC9FC;

    assign tw_real[7087:7072] = 16'h8BA0;
    assign tw_imag[7087:7072] = 16'hCAB2;

    assign tw_real[7103:7088] = 16'h8B4D;
    assign tw_imag[7103:7088] = 16'hCB69;

    assign tw_real[7119:7104] = 16'h8AFB;
    assign tw_imag[7119:7104] = 16'hCC21;

    assign tw_real[7135:7120] = 16'h8AAA;
    assign tw_imag[7135:7120] = 16'hCCD9;

    assign tw_real[7151:7136] = 16'h8A5A;
    assign tw_imag[7151:7136] = 16'hCD92;

    assign tw_real[7167:7152] = 16'h8A0C;
    assign tw_imag[7167:7152] = 16'hCE4B;

    assign tw_real[7183:7168] = 16'h89BE;
    assign tw_imag[7183:7168] = 16'hCF04;

    assign tw_real[7199:7184] = 16'h8972;
    assign tw_imag[7199:7184] = 16'hCFBE;

    assign tw_real[7215:7200] = 16'h8927;
    assign tw_imag[7215:7200] = 16'hD079;

    assign tw_real[7231:7216] = 16'h88DD;
    assign tw_imag[7231:7216] = 16'hD134;

    assign tw_real[7247:7232] = 16'h8894;
    assign tw_imag[7247:7232] = 16'hD1EF;

    assign tw_real[7263:7248] = 16'h884C;
    assign tw_imag[7263:7248] = 16'hD2AB;

    assign tw_real[7279:7264] = 16'h8805;
    assign tw_imag[7279:7264] = 16'hD367;

    assign tw_real[7295:7280] = 16'h87C0;
    assign tw_imag[7295:7280] = 16'hD424;

    assign tw_real[7311:7296] = 16'h877B;
    assign tw_imag[7311:7296] = 16'hD4E1;

    assign tw_real[7327:7312] = 16'h8738;
    assign tw_imag[7327:7312] = 16'hD59E;

    assign tw_real[7343:7328] = 16'h86F6;
    assign tw_imag[7343:7328] = 16'hD65C;

    assign tw_real[7359:7344] = 16'h86B6;
    assign tw_imag[7359:7344] = 16'hD71B;

    assign tw_real[7375:7360] = 16'h8676;
    assign tw_imag[7375:7360] = 16'hD7D9;

    assign tw_real[7391:7376] = 16'h8637;
    assign tw_imag[7391:7376] = 16'hD898;

    assign tw_real[7407:7392] = 16'h85FA;
    assign tw_imag[7407:7392] = 16'hD958;

    assign tw_real[7423:7408] = 16'h85BE;
    assign tw_imag[7423:7408] = 16'hDA18;

    assign tw_real[7439:7424] = 16'h8583;
    assign tw_imag[7439:7424] = 16'hDAD8;

    assign tw_real[7455:7440] = 16'h8549;
    assign tw_imag[7455:7440] = 16'hDB99;

    assign tw_real[7471:7456] = 16'h8511;
    assign tw_imag[7471:7456] = 16'hDC59;

    assign tw_real[7487:7472] = 16'h84D9;
    assign tw_imag[7487:7472] = 16'hDD1B;

    assign tw_real[7503:7488] = 16'h84A3;
    assign tw_imag[7503:7488] = 16'hDDDC;

    assign tw_real[7519:7504] = 16'h846E;
    assign tw_imag[7519:7504] = 16'hDE9E;

    assign tw_real[7535:7520] = 16'h843A;
    assign tw_imag[7535:7520] = 16'hDF61;

    assign tw_real[7551:7536] = 16'h8407;
    assign tw_imag[7551:7536] = 16'hE023;

    assign tw_real[7567:7552] = 16'h83D6;
    assign tw_imag[7567:7552] = 16'hE0E6;

    assign tw_real[7583:7568] = 16'h83A6;
    assign tw_imag[7583:7568] = 16'hE1A9;

    assign tw_real[7599:7584] = 16'h8377;
    assign tw_imag[7599:7584] = 16'hE26D;

    assign tw_real[7615:7600] = 16'h8349;
    assign tw_imag[7615:7600] = 16'hE330;

    assign tw_real[7631:7616] = 16'h831C;
    assign tw_imag[7631:7616] = 16'hE3F4;

    assign tw_real[7647:7632] = 16'h82F1;
    assign tw_imag[7647:7632] = 16'hE4B9;

    assign tw_real[7663:7648] = 16'h82C6;
    assign tw_imag[7663:7648] = 16'hE57D;

    assign tw_real[7679:7664] = 16'h829D;
    assign tw_imag[7679:7664] = 16'hE642;

    assign tw_real[7695:7680] = 16'h8276;
    assign tw_imag[7695:7680] = 16'hE707;

    assign tw_real[7711:7696] = 16'h824F;
    assign tw_imag[7711:7696] = 16'hE7CD;

    assign tw_real[7727:7712] = 16'h822A;
    assign tw_imag[7727:7712] = 16'hE892;

    assign tw_real[7743:7728] = 16'h8205;
    assign tw_imag[7743:7728] = 16'hE958;

    assign tw_real[7759:7744] = 16'h81E2;
    assign tw_imag[7759:7744] = 16'hEA1E;

    assign tw_real[7775:7760] = 16'h81C1;
    assign tw_imag[7775:7760] = 16'hEAE4;

    assign tw_real[7791:7776] = 16'h81A0;
    assign tw_imag[7791:7776] = 16'hEBAB;

    assign tw_real[7807:7792] = 16'h8181;
    assign tw_imag[7807:7792] = 16'hEC71;

    assign tw_real[7823:7808] = 16'h8163;
    assign tw_imag[7823:7808] = 16'hED38;

    assign tw_real[7839:7824] = 16'h8146;
    assign tw_imag[7839:7824] = 16'hEDFF;

    assign tw_real[7855:7840] = 16'h812A;
    assign tw_imag[7855:7840] = 16'hEEC6;

    assign tw_real[7871:7856] = 16'h8110;
    assign tw_imag[7871:7856] = 16'hEF8D;

    assign tw_real[7887:7872] = 16'h80F6;
    assign tw_imag[7887:7872] = 16'hF055;

    assign tw_real[7903:7888] = 16'h80DE;
    assign tw_imag[7903:7888] = 16'hF11C;

    assign tw_real[7919:7904] = 16'h80C8;
    assign tw_imag[7919:7904] = 16'hF1E4;

    assign tw_real[7935:7920] = 16'h80B2;
    assign tw_imag[7935:7920] = 16'hF2AC;

    assign tw_real[7951:7936] = 16'h809E;
    assign tw_imag[7951:7936] = 16'hF374;

    assign tw_real[7967:7952] = 16'h808B;
    assign tw_imag[7967:7952] = 16'hF43C;

    assign tw_real[7983:7968] = 16'h8079;
    assign tw_imag[7983:7968] = 16'hF505;

    assign tw_real[7999:7984] = 16'h8068;
    assign tw_imag[7999:7984] = 16'hF5CD;

    assign tw_real[8015:8000] = 16'h8059;
    assign tw_imag[8015:8000] = 16'hF695;

    assign tw_real[8031:8016] = 16'h804B;
    assign tw_imag[8031:8016] = 16'hF75E;

    assign tw_real[8047:8032] = 16'h803E;
    assign tw_imag[8047:8032] = 16'hF827;

    assign tw_real[8063:8048] = 16'h8032;
    assign tw_imag[8063:8048] = 16'hF8EF;

    assign tw_real[8079:8064] = 16'h8027;
    assign tw_imag[8079:8064] = 16'hF9B8;

    assign tw_real[8095:8080] = 16'h801E;
    assign tw_imag[8095:8080] = 16'hFA81;

    assign tw_real[8111:8096] = 16'h8016;
    assign tw_imag[8111:8096] = 16'hFB4A;

    assign tw_real[8127:8112] = 16'h800F;
    assign tw_imag[8127:8112] = 16'hFC13;

    assign tw_real[8143:8128] = 16'h800A;
    assign tw_imag[8143:8128] = 16'hFCDC;

    assign tw_real[8159:8144] = 16'h8006;
    assign tw_imag[8159:8144] = 16'hFDA5;

    assign tw_real[8175:8160] = 16'h8002;
    assign tw_imag[8175:8160] = 16'hFE6E;

    assign tw_real[8191:8176] = 16'h8001;
    assign tw_imag[8191:8176] = 16'hFF37;

endmodule
